Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264A43E08B
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228927; cv=pass; b=PkxGncrQmogseTdE+0NAucscD4YzR2gBFm5YKDjcNO999JcBRpcMQi53hRyMtqvDTnYgvAs7QuTsVqcMhIi6arYmbZvBLX4kLBfG8r4YmDy367es7l2AIGTanEKtkbKsfCUqM9fvdM96FWkt3FD5XkmWhUDX1/526RxpxpFzqmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228927; c=relaxed/simple;
	bh=z5N5ADczsk/TRy5ioD+sHkzOTqbuDFCEpc7N+OEeH+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/FzFokR9YowGkRyanCXiiNjwb16pz+MGHXXEe8EoCWDUbcT2CQYMgP8KWMeID9/uHRIpGJNjXK79oFMPPP5nwTKRtqNwIOM2XUUqm+7rI++irq7fxQAuvpK/4vbEH4+T6s4MR0c5vDKugsX7b0PEfLyUhY+0LCdPB+l4r2FTF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcNxOoh8; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcNxOoh8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf27856f9cso20892705ad.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228925; cv=none;
        d=google.com; s=arc-20260327;
        b=iu0TCotqD5ZWextbcQZKRCbWs82tHcfC2YHruD450x5Hp5T3p5VSh0mC3/0jY0wg3c
         IBj/5imY5N5t27punsp3CQqu/berUfqmCATCnPxNE4n+irub2Y1w5BiCvtSAmycRNA7X
         3+yYtBXie3SsHwZb8W6l2l/NgfaV9PfUS/xjJGog9ns/oR+ybrZp2Dyxwppz86Xpb1cP
         Vd+pf0Qp2ie0b+sjgP/cPirEWx8ZmBnANihb0eQ4bgmstpTQr4/OHJcVqxTt7E4q1VqY
         Bucm2ezPIrlM8BdFAZmG7DvuBrTJZwbhRnyOEpH3p7rkWUifctErqcxLlvoK/hj/hQCn
         rJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wAy587k/lCPhH4Xpjii5Y96p0S6xgOBmQoFDK9c9A7A=;
        fh=GttNNfaEDCcSo3YpKNngFrQNcM5mjG8bvv8VuhbD5O8=;
        b=U7Y/XOknDdkl5g8oG20DkZbOgMrXOcjQcHssPe7ZPDulB3sr40SqDAg5pxzO16dfdj
         1U606ORu1wji4BwOe0YjhxBthp/bgmxuOmJGxSy5FvCgLyoL+yDGO5V6EOkaYpesQXO9
         6UFSzXhvNNjHxsMtTNctv+nhg9+JVCUofxy4rn/cclkIGO/s3eqwnHtdsOH+bnWDyAkz
         4I1IoGpzfADATdVkMO5mFZuNuA3e0ljnIXatV6gqQjCfw8Ues0SJtE8boge3kStAja3o
         vr+MbO7OpNuPD+umbppOklvBpMuxhQftkZijiSG3wJTkBZJroOCwpSATDKrXNpE4n8Kh
         6zOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228925; x=1787833725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wAy587k/lCPhH4Xpjii5Y96p0S6xgOBmQoFDK9c9A7A=;
        b=PcNxOoh88GpNaNXwwf0GytjVK3zaLmh620Ra5i96CU9w8ZI+jhMMH0wJnx+ZGz+LG4
         QtjNPJ5v7VduO6ZDbwYQzZfmIqL1jZvMaHk6pQmHzX06iNLlUBR0w2xb7LjVVXnpv0IY
         jvZ6qU6yGdq3ZeepHX5VN+PEi5jGJRWP/tlAWZd55OYeoFfVjYtBftvjG4Z1ZXNm6WvE
         K0DL5obP4UA/SVudDi8H9KXX4l+BULQxX4k7ySoMxuyuVX+EP2bc9pTJmaVbWwtz9w23
         FAyI8/QBiunD7ZtB9Nd7YimhCfcCgra7WijGMQXuEJvC8p/u3K53yAtNUuK+bBQtD1Aa
         ci9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228925; x=1787833725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAy587k/lCPhH4Xpjii5Y96p0S6xgOBmQoFDK9c9A7A=;
        b=HIbfNN/56LctFUC9LspEVYXQENsxuPBnwT76Wm2LSNIoT4Qi23zE+qJeH/ZvQ7q2mm
         zvYYLO6W+aQ2vVLNqNYxCYjvVAAlWf3HIQQBipeeGuqugQX6hoNIEAkdViF1/vWUL1Be
         J2BPqMUI/yObqaO8OCc66a3W0e8qGWsvt9cSYa6chPBm9dVOHxdzkoaHL1HnK3pl1ruD
         rdL4p4jQ7kN/uQi5ICvNgX9ewgBVAwlaklDvLLvbIkTPultK2Qz3Y8eNIzFvzuYT+IiB
         5HqChY0hCvWvSqFWl/WYGkYksskxXvINSk6Goi+54fAV4rcMeQyotJR3DT/AuVmafcT/
         g8vg==
X-Gm-Message-State: AFuF++mpMB087PrCMIeEjzMGlWxjxhIcUmNi9VZNsp7YG5XdovB4Q/Xd
	euI+rcEuFAL/uzg+A/K9YznAoK42gRE7qQdpv3KdiTpdHG6oE41gsJEO7486PsteyEU8vbb7pno
	2d16qWnwagpgwx78uAz8VgRPLVo3ZYoPQyYeK
X-Gm-Gg: AR+sD13MmeLAkSn2J5lkdYWrscse2x7hinU3WNyqYM9R82/m+MJsqsfzZcJiRpV9ahs
	td2G7ltB96iGEizPvLi2oydt2crXFZQuAEvtmB+tEwma1IRAtRL1yKg+pYbmjr/D+tkEpPUGFR0
	6feAija8H0NPGS5dDzom+0zRxBMR5MOSzc3vi6Y8EejfuAx9Aw/yiHIkrw/iihY3NwybH+cevW2
	S/o/67b+ZAkZftj7sT8E6oKqum4AcKlJfuZX1amUSyFljmSDZUA6YjHQGAwBuqaVkKTpAsmlwC1
	/LS7JtAOmygNZc5ngRDrvqXo3twAt8E5gdsqEoy2Vc95PmJ39KWfVgl0PyDSEEEDcaQflY06aFn
	BZeY0uM6eMVmc6HFw70boGmhdJL9MVKncfFaNIDJvINOcDUOTG5bYLRopH0x5XfIusqq5kLWjtl
	ZGlbCC4ZNpP6WY+incYc4=
X-Received: by 2002:a17:903:2bcb:b0:2cc:9179:32e with SMTP id
 d9443c01a7336-2d601e80fd8mr242266585ad.10.1787228925212; Thu, 20 Aug 2026
 05:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com> <pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
In-Reply-To: <pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Aug 2026 08:28:33 -0400
X-Gm-Features: AcwNN1WnuO9wXpN8xm1lGPS1LX-JR2VjPogcPvygTGy8OrTQBpHQeZjOrELVl-8
Message-ID: <CALnO6CC35iuyJpKZtkEN7fGuGK7zKd_jbebyZdKSQ1pyfOBRZA@mail.gmail.com>
Subject: Re: [PATCH v2] completion: zsh: support completion after "git -C <path>"
To: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lutz Lengemann <lutz@lengemann.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:07=E2=80=AFAM Lutz Lengemann via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lutz Lengemann <lutz@lengemann.net>
>
> The zsh completion wrapper does not handle the global -C option, so
>
>         git -C <path> <command> <TAB>
>
> offers nothing.  -C is not part of the _arguments specification, and the
> wrapper hard-codes __git_cmd_idx=3D1, i.e. it assumes that the command is
> the first argument, so the bash helpers look at the wrong word.  The
> latter is not specific to -C; the assumption breaks after any global
> option, e.g. "git -p checkout <TAB>" does not complete branch names.
>
> Add -C to the specification, and find the command by skipping over the
> global options and, where they take one, their arguments, as __git_main
> in git-completion.bash does.  The index is one less than zsh's, as the
> helpers count the words from zero.  Collect the paths given to -C into
> __git_C_args, or else the helpers run git in the current directory and
> fail to resolve the aliases and refs of the repository the command runs
> in.
>
> The argument of a -C is still completed without regard for the -C
> options before it, i.e. "git -C dir -C <TAB>" offers the directories in
> ".", not the ones in "dir".
>
> Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
> ---
>     completion: zsh: support completion after "git -C "
>
>      * The command is now located by walking the global options in front =
of
>        it, mirroring the loop at the beginning of __git_main in
>        git-completion.bash, instead of skipping only leading -C options.
>        This also fixes argument completion after other global options, e.=
g.
>        git -p checkout <TAB>.
>      * The log message uses the present tense for the pre-image and notes
>        that the argument of a -C is completed without regard for the -C
>        options before it.
>
>     cc: Ben Knoble ben.knoble@gmail.com cc: Junio C Hamano gitster@pobox.=
com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2155%2F=
mobilutz%2Fzsh-complete-global-C-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2155/mobil=
utz/zsh-complete-global-C-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2155
>
> Range-diff vs v1:
>
>  1:  9739cde6fc ! 1:  9984228f1f completion: zsh: support completion afte=
r "git -C <path>"
>      @@ Metadata
[snip]
>
>           Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
>
>      @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
>                 '(- :)--version[prints the git suite version]' \
>                 '--exec-path=3D-[path to where your core git programs are=
 installed]:: :_directories' \
>       @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
>      +          done
>                 ;;
>         (arg)
>      -          local command=3D"${words[1]}" __git_dir __git_cmd_idx=3D1
>      +-         local command=3D"${words[1]}" __git_dir __git_cmd_idx=3D1
>      ++         local command=3D"${words[1]}" __git_dir __git_cmd_idx

Ok, this matches what the message describes about __git_cmd_idx not
being able to assume=3D1; it's different in this version because we are
a bit more sophisticated in our parsing.

>       +         local -a __git_C_args
>       +         local -i i=3D2
>       +
>      -+         while [[ ${orig_words[i]} =3D=3D -C ]]; do
>      -+                 __git_C_args+=3D(-C ${orig_words[i+1]})
>      -+                 (( __git_cmd_idx +=3D 2 ))
>      -+                 (( i +=3D 2 ))
>      ++         while (( i <=3D $#orig_words )); do
>      ++                 case ${orig_words[i]} in
>      ++                 -C)
>      ++                         __git_C_args+=3D(-C ${orig_words[i+1]})
>      ++                         (( i++ ))

At first I thought "should that be i+=3D2?"; then I saw the
unconditional i++ later. Reasonable, though I'm not sure what happens
if we walk off the end of the array here: If i=3D#orig_words, then
__git_C_args has (-C) and i becomes #orig_words+2; later,
__git_cmd_idx becomes #orig_words+1, which is empty. I'll keep that in
mind when looking at how we handle those variables.

=E2=80=A6Ok, those are handled in the Bash completion. AFAICT, they don't d=
o
anything special when the dir is missing either. A bit strange, but
not something this patch needs to solve, I suppose. __git_cmd_idx is
used many places, as we would imagine, and I didn't look carefully at
what happens when it indexes an empty spot (but it looks to mostly be
used in comparisons where that would just go falsy, or in arithmetic I
haven't really checked at all).

(I also haven't thought carefully about the difference between Zsh's
1-based indexing and Bash's 0-based, so I'm not sure if there's an
issue lurking there.)

>      ++                         ;;
>      ++                 -c|--git-dir|--work-tree|--namespace)
>      ++                         (( i++ ))
>      ++                         ;;
>      ++                 -*)
>      ++                         ;;

Yep, unlike Bash (which requires at least one command in the "list"
part between a pattern and the terminator), Zsh accepts empty actions
here.

>      ++                 *)
>      ++                         break
>      ++                         ;;
>      ++                 esac
>      ++                 (( i++ ))
>       +         done
>      ++
>      ++         __git_cmd_idx=3D$(( i - 1 ))
>
>                 if (( $+opt_args[--bare] )); then
>                         __git_dir=3D'.'
>
>
>  contrib/completion/git-completion.zsh | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/g=
it-completion.zsh
> index c32186a977..d5c526665b 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -227,6 +227,7 @@ __git_zsh_main ()
>                 '(-p --paginate --no-pager)'{-p,--paginate}'[pipe all out=
put into ''less'']' \
>                 '(-p --paginate)--no-pager[do not pipe git output into a =
pager]' \
>                 '--git-dir=3D-[set the path to the repository]: :_directo=
ries' \
> +               '*-C[run as if git was started in <path>]: :_directories'=
 \

At first I wasn't sure about the blank description (space between 2
colons) of the argument to -C, but I see that _directories
automatically describes the completed thing as "directory," so that's
fine.

Overall, if this version works, I think I'm happy with it. Confirming
the index math works out between the 2 shells might be a useful
exercise, but /shrug.

--=20
D. Ben Knoble
