Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7A18E02A
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015850; cv=pass; b=lTDZD6a4yKItYcrDsG7ezC/cfjIOunOodVlwtNcuvyeAjf5UqrQcf/1HWujImua85g4aznSExsec8jw12hLHzNEuNBeA1bF0KOO/psSjvOLYZrzKL9H7jYsoj109svwNu6IXjSLWcjN/oAG+5pR0ac7LfZ4H/+EyCtId1NYjnRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015850; c=relaxed/simple;
	bh=e59QaQRHEkT+qlBq8YzN+xlv8vD9zChB5yWJ2TLt9yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPueLD4Sybljy+PBlwcEgLAgkLlpBVJbSD/P66WIC8CogGFAFedzofbQDYP7sgHte9aWm6dcUvn8tzL2XsO3ucK2WtnhmaT1Im9Em+qRfdAn1gaj8mq76j6etwb0fDwAMx2U28k28VTAM/5eGGBXOV40pW8As3HMIP4GXD17ac8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8jvAV3y; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8jvAV3y"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1496657a91.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786015848; cv=none;
        d=google.com; s=arc-20260327;
        b=knRL32dtvAS6gio8zain9biIikeZObtOG0FqVFAS/YpKv07WnU3Wpu3oL4btYFJqgt
         L93D1HTH7DFBxCV9GWoXK4IuQ5/Mons4z+T9mfyvnm3ZIKXK945qQCtbHuHNCENpWzei
         Y5umCtd9PT0jezM6bcWvtvJeNhpZI7tDLYvauZqPlwnApUmGEGE3/HiceakyHCDIhZmf
         W0Bi6LlMwp4/DF830gH+6GH/+t69qTNkFXCwjK4a2vGAA+nualFiFoBuEjaiuOm3SUgR
         zCg90nekX6a6JgKHJ0fFEeHJkLu0BgNYdzN58+72muILgtwmghGfq2IjUOpVYfiINfHC
         esog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yIFTyGIrS/VscC9IKaUvM/NOvn+2KvJaA4/7k9u4o40=;
        fh=Gl1yUhNnY/d0FwAIaGoMwb0WkywJIt0FuZR+TDAfljI=;
        b=DohRH0IV3bGPWJ65FGM4O6cgX4Hs21WefAtdm7vm5aKU4BGsg8eVQI6rOwAbzUGyfH
         XucnZAzwD/3WqUu7UQUKNfmd3JORvWm4wFSOsoH40izljDCJ5CGoMU8xhuqrSZush1ay
         Vb35hh5GRhbU+PrBoyGO0kOjavrB2RzOeUTq9GVZCHxKPV+O0YgrisSu0rTSQDOYj8R7
         ciEl+ifbAzplr065pDYajsW7KyDDgl4oRXjTaL7lOE6tUEzLJzsVl0wbzI44cUKAWvc8
         R5aapAKgEYW2UJJOyj29y6FBk3nXDyKYSz6DajOuOGPdUyGQwuKRek7m3+TEl8JaTTSg
         8PbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015848; x=1786620648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIFTyGIrS/VscC9IKaUvM/NOvn+2KvJaA4/7k9u4o40=;
        b=R8jvAV3y4+PTcPnotv4bwjL3GRt5z3eXqSFog5V3tkh+2Iqch0dAGJoaVoel9b95eS
         +Y09HIK++MNQQwccUKdjPQJ6ShgtNO8b90KQYl/79HoXUyAHAbI662m0sh7yV1NNoguf
         IbRl87VK0cizH0SUXIPSYZpbeqmO8I3UVOeqQDfKPon9zN/NrHzWJ1zWE76i4RWkGs7B
         kpjuFs2lg/JMM7h7WKvz4ZlovAGjeGAYif3QdwP2nOpK8lKE+eRBxgNanL8dyDXnDBH5
         oHxM6cJS80U70XM+xj8cisAWzOfVffdEMebUdSPFUUuCPEbZSX7/WH1/kCnYK4RiUKcB
         axfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015848; x=1786620648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIFTyGIrS/VscC9IKaUvM/NOvn+2KvJaA4/7k9u4o40=;
        b=keY32lxRMDuQTvUJa8Gf9fUkRtNJmGYVPNu73i88PWaxQGkJGsC8hhPuy0GIFkVOTi
         8KkGmwEisRfovvIWKEtTHmHzqZfL1gfIzpK+2jeKSEb813/ZI7DW7wUxsQI3v04kPOpH
         PG09k/MR5XeXazrYWVoitm6dFB52YT0DwtzC9njKXW8iAIMrZi9I4g9putM599Wjl/XL
         flAziHYGeqNPnXRmR1BAChF/9OIddMGkuUbLW7KUcI/NPf3Y9gtG0r6JXlw243OVePIa
         bCcdwAKVswL4RKboehg2HFSSZKKWK/2j7ztCyqIF/BWW+QCnt7hLPrwd9M/xSThsrv85
         Rz6g==
X-Gm-Message-State: AOJu0Yxvskiss0SYLzcujYs2AxfwA9vFvF5EyhgH+/rXw+8/DZ7BzIJS
	heb2CDpdPuAx2bvs6lR5gsn9J87N846shm3bjHyfnFLPFn0cLcjwk14DJ0pcOjgPLmUo6MEj2oa
	bXOnaowcyNOf1PEHNoAYZXjIr/if7jrhPUFJK0ivRxg==
X-Gm-Gg: AR+sD109r6GZNEzEUuSPgIQ/owNRmowLsjFOatHYLfiTjGadcsTJzqgMUWp9WzOHrIj
	be0G1uCYahlxfhqSxraob516Nkxl8NSqa6MraAFWt2t3kmf7VYh8KDqzT88eA7t4Ae88bo7Zqwg
	5e9IRE+2AMlpbR5i7EjSAif7+N441uQjY+3jBjEXv7qYLdzPPHmdYVdA2U2yX4/4JufStXq5P8z
	BHiRc0brSR/CvY4TIk8i8pa+AHXkb4gD1D0EVGMe5SrKAy3Q6Az/aTUoIjrIUG7nfWQwzhYuTSz
	P9DPMnRNFqPuLZF9wJLfz91ZgroBimzCUNva+pfy1JOrQzNTUGmvD7ceVrj5bICsxL0mpk7xD37
	7W5hlSdcYvwkoogB+amZEs7pKqoHpxcjw/5grOkezrf4S5XEw4AXlhYFEU3ypCu4WnpuZpxNkpY
	V/w7UbTYH2W23iFwBjffk=
X-Received: by 2002:a17:90b:3803:b0:38e:6dd:a9ad with SMTP id
 98e67ed59e1d1-3903bb00ecbmr12101633a91.0.1786015848102; Thu, 06 Aug 2026
 04:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcxw010me.fsf@gitster.g> <20260805194250.3316220-1-gitster@pobox.com>
 <20260805194250.3316220-4-gitster@pobox.com>
In-Reply-To: <20260805194250.3316220-4-gitster@pobox.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Aug 2026 07:30:36 -0400
X-Gm-Features: AUfX_mycXHsRdotZkIitwErcUeOi6Y5ogDSjSI6ughxsydyFeckdZAk0DOJL6V0
Message-ID: <CALnO6CA8sjivVfz45OEDWnvw516z9Nd9SnC+zfJ=FK=Y6Q7MJg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] completion: 'git diff' completes untracked paths
 as a last resort
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
	Britton Leo Kerin <britton.kerin@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Junio,

On Wed, Aug 5, 2026 at 3:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> We taught 'git diff' to first try to complete revisions (unless '--'
> is present on the command line) and, failing that, to complete
> tracked paths.  If this yields nothing, it lets the Bash default,
> which offers paths in $PWD, kick in.
>
> Teach it to complete untracked paths before giving up and letting
> the Bash default kick in.  With this change,
>
>     $ git -C another-directory diff un<TAB>
>
> finds the 'untracked' file in another-directory and offers it as a
> completion candidate.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash |  4 ++++
>  t/t9902-completion.sh                  | 22 +++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 845fd19f70..7741789e41 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1985,6 +1985,10 @@ _git_diff ()
>         if [ ${#COMPREPLY[@]} -eq 0 ]; then
>                 __git_complete_index_file
>         fi
> +
> +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
> +               __git_complete_index_file "--others --directory"
> +       fi
>  }
>
>  __git_mergetools_common=3D"diffuse diffmerge ecmerge emerge kdiff3 meld =
opendiff
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 10ac690e21..53a2bfb2ac 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2663,6 +2663,7 @@ test_expect_success 'setup for integration tests' '
>         echo content >file1 &&
>         echo more >file2 &&
>         git add file1 file2 &&
> +       echo untracked >ufile &&
>         git commit -m one &&
>         git branch mybranch &&
>         git tag mytag
> @@ -2728,6 +2729,15 @@ test_expect_success 'git diff -- completes tracked=
 paths' '
>         EOF
>  '
>
> +test_expect_success 'git diff [--] completes untracked paths, too' '
> +       test_completion "git diff u" <<-\EOF &&
> +       ufile
> +       EOF
> +       test_completion "git diff -- u" <<-\EOF
> +       ufile
> +       EOF
> +'
> +

LGTM up to here.

>  test_expect_success 'git -C <path> diff completes tracked paths in speci=
fied repo' '
>         test_when_finished "rm -rf repo-for-diff" &&
>         git init repo-for-diff &&
> @@ -2744,11 +2754,21 @@ test_expect_success 'git -C <path> diff -- comple=
tes pathspecs in specified repo
>         test_when_finished "rm -rf repo-for-diff" &&
>         git init repo-for-diff &&
>         echo content >repo-for-diff/otherfile &&
> +       echo untracked >repo-for-diff/untracked &&
>         git -C repo-for-diff add otherfile &&
>         git -C repo-for-diff commit -m otherfile &&
> -       test_completion "git -C repo-for-diff diff -- o" <<-\EOF
> +       test_completion "git -C repo-for-diff diff o" <<-\EOF &&
> +       otherfile
> +       EOF

Here, with more context (which I won't paste, because GMail=E2=80=A6), it
looks like this test is redundant with the test just before?

> +       test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
>         otherfile
>         EOF
> +       test_completion "git -C repo-for-diff diff u" <<-\EOF &&
> +       untracked
> +       EOF
> +       test_completion "git -C repo-for-diff diff -- u" <<-\EOF
> +       untracked
> +       EOF
>  '

These tests intermingle with -- and without; the other tests separated them=
.

I don't think I have a strong preference, but perhaps consistency is a
good ideal?

--=20
D. Ben Knoble
