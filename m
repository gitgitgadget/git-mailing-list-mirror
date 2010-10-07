From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 07 Oct 2010 20:33:58 +0200
Message-ID: <87wrptua21.fsf@gmail.com>
References: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:35:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vJ9-0004Ay-I4
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab0JGSfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:35:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab0JGSfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 14:35:03 -0400
Received: by fxm4 with SMTP id 4so120154fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=/BM6bEe7cDEVxYTJdmuvewYIpbX3zHl56PLRGCEfmts=;
        b=vkTjvPEyRkMxtfWGNGqY4CyweLrJbLJesH6vWIEggo/XfvCupeIPxkDHrHiAToWvas
         PpmvtBxxPNiZ/DH0fIEqdm6wYbfi+zMfOmbaRrQiQfFCwgV/dSOqCncYGm3aayuDnaAi
         LuXtE/egak1ske7yA6Sgaw2xAaZe4xdltS7Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=b2zmontNecGXyj6NuR46/hcAJ8gdszRClsb117drxB8hzh/cbjjqa0SwMl7TTBOEX2
         pG+C1WQK0FJbz1zoOaP6DCAg1a7YLO0+GeM33v8oTZw/0UBV4UAKqi9JkEdkY+ADg7qs
         V7Mg/XmvymgHn54NQpn2nuPWScBEMdJFkKPGY=
Received: by 10.223.120.73 with SMTP id c9mr1655670far.106.1286476501278;
        Thu, 07 Oct 2010 11:35:01 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id a16sm729068fak.19.2010.10.07.11.34.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 11:34:59 -0700 (PDT)
In-Reply-To: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 7 Oct 2010 15:23:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158428>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Also mention, that --stdin and --index-info needs to be the last
> option supplied and indicate this in the usage string.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
>
> We may like the usage string like this:
>
> [[-z] --stdin | --index-info]

Yeah, that'd be definitely better IMO.

Also the usage string in builtin/update-index.c should be updated to th=
e
same effect.

There is actually at least one more problem with the current SYNOPSIS o=
f
`update-index'. Obviously the `*' on the third line of the Asciidoc
source makes the whole `--cacheinfo' line disappear and the rest bold
(cf. e.g. the result at
<http://www.kernel.org/pub/software/scm/git/docs/git-update-index.html>=
).

I guess using `...' instead of the asterisks (also on the last line,
i.e. [<file>...], not [<file>]*) would both fix the problem and at the
same time make it more consistent with other man pages.

> to make it also clear, that -z applies only to --stdin or --index-onl=
y.
> ---
>  Documentation/git-update-index.txt |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt
> b/Documentation/git-update-index.txt
> index 74d1d49..4441d7c 100644 Documentation/git-update-index.txt
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -18,8 +18,9 @@ SYNOPSIS
>  	     [--skip-worktree | --no-skip-worktree]
>  	     [--ignore-submodules]
>  	     [--really-refresh] [--unresolve] [--again | -g]
> -	     [--info-only] [--index-info]
> -	     [-z] [--stdin]
> +	     [--info-only]
> +	     [-z]
> +	     [--stdin] [--index-info]
>  	     [--verbose]
>  	     [--] [<file>]*

Shouldn't `--verbose' be also moved before the must-be-last options?

> @@ -72,7 +73,7 @@ OPTIONS
>  	Directly insert the specified info into the index.
> =20
>  --index-info::
> -        Read index information from stdin.
> +        Read index information from stdin (Must be last option).

I'm not a native speaker myself, but I suspect "must be THE last option=
"
is more correct (including the lower-case `m' :-)).

>  --chmod=3D(+|-)x::
>          Set the execute permissions on the updated files.
> @@ -138,14 +139,15 @@ you will need to handle the situation manually.
>  --stdin::
>  	Instead of taking list of paths from the command line,
>  	read list of paths from the standard input.  Paths are
> -	separated by LF (i.e. one path per line) by default.
> +	separated by LF (i.e. one path per line) by default
> +	(Must be last option).

(same here)

> =20
>  --verbose::
>          Report what is being added and removed from index.
> =20
>  -z::
> -	Only meaningful with `--stdin`; paths are separated with
> -	NUL character instead of LF.
> +	Only meaningful with `--stdin` or `--index-info`; paths are
> +	separated with NUL character instead of LF.
> =20
>  \--::
>  	Do not interpret any more arguments as options.

Thanks,

=C5=A0t=C4=9Bp=C3=A1n
