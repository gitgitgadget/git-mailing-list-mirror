Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDCC46467
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjACRSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 12:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACRSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 12:18:42 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3182333
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672766313; bh=FlL7NJnjiBjR7NgqtjAR/nWx1GgAyflPo6GLZnUXaaI=;
        h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
        b=fRuhalI8OSdarrRyFtAyAUTg29mZPVfYpDxM5QSHJR+LU0fU40xYE9NudaQI4Li8r
         qrhldOOV2Vgoxgqdzh0XitF9nvCjvL3xB+cu4TSJjfH3DHv+c7J01SRZi6Qjvipv9F
         DCumYAB1eakCnFmiqHqS5drieVRF6hPe6IpDnrV7lpmRnGCobKkvCPGO0YyLFMoHep
         sykQLtO7TBJ1XDXQxpIg9iq3UBKrzD6bJnSc4QQCfbyjn8o4Wuk+G/CO3Evk46GSdk
         eHmeR2fY8jBFQvIMuIRIPd5ZSEmN6YCthHv5kzsr11oA0PSlvXF1QAzG7GxCrlcZZc
         8FmJxQqynAscA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1oZrTu3Z4c-00eZ5R; Tue, 03
 Jan 2023 18:18:32 +0100
Message-ID: <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de>
Date:   Tue, 3 Jan 2023 18:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-4-gitster@pobox.com>
Content-Language: en-US
In-Reply-To: <20220915160659.126441-4-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LfCVle9TwhTYToYbVDIuVFB5aqCNEtzu8sTgIrbqqNpB8Z9pQb+
 3F/SH4udBB3etSWK7ENNZfFn63G5kbVN9y31n6mDa8OLEdPjPYoIY0yR1rgh0qp7KC+LQcF
 vDx12XRVTZJwmQj5nrmRCKg7P1n03Gm16Sp++lsEznXFC7qX3UrwgCwZYNzwrLJ72jANVHZ
 5ieo/3WZPBllqpOS5Yb/A==
UI-OutboundReport: notjunk:1;M01:P0:y/1l9/zhhaI=;8/bElV1lRt4GiNf6shs6IjBji4c
 vWHllYteSa1bnNEY9//Mxtiffygk13IUHvmhwulTC9q8eDEoS8kcIkQ0hF7c50YjLDIhRmUDy
 ale9n0cH6KxavjgeBycpV1EkW+DBBoTVGabSsjzvwA00e5RBblDO3weKETpdDRZJb+b/6WccN
 HcMRjjIWMKCs4FBT4OIACT2ceHl4M1sp0689Sh+XYYO8DbkWs3CpgNXRngKjl/jIr1OkebyKZ
 SzpawkyQyJu2OYmJVYalnFCxD3NEsQFe99QPB4p6ENo+BTychABnTAWNp630CLWhFuROa4KhK
 vQdfVXu2G2jw2hck6A12bp2sYOV9rt8ZiYivW64QlNrVZ1A+iPYCpGAVeg437Joyk9YmiPoWi
 ZUvwrpAVueFRsH8CqrR9NMU+G82zeIyHmF4a+w/avFOx2B4zqEMi1rg+numcf1iOz0gphasII
 r/IT9crxTu7hWJspLvyYWNR58yjLq3AW3mUYFJdMTRoW4ezGN0JJPrJ8k+DvVPnULOv1KzgsP
 TbTF6xVMuWvDq21jUBOSzcT4CmC6AOdzfX1XqZpjbYVOmN1JSbkd3VH1gtSUHozEpvFznuV9v
 vamu0sycg88dyxr/GYYcT+YiaIhpzPzxF8ii9Fsl/vDXkmq0SyOAVoUAO6icJd8uVYCGSsdrc
 2APkct8QToYTLiK/xWc4zGtgQYJ1Rvdv6J8olcnJvLzB83ieVgCnn2JhSan4fyB0rlaqMcvug
 zF21zhUEki4T+CmadZSLpBopra4y7ylLA+n36tfxVGBVMWRj5T515lcSAQgrRUsP+D3i/8aI5
 3CCONvVW7u3IjxzxKNQSVoMCjyNIej7OyRczwWBngtqeJ1KmRYBLdxHKVopffffuNq/bEY9XU
 W12d+Lc10OB+lRP4XEamyiK2Kuib0jyKmn0mqccl05wjLE1uI4ekEkaptSbxsw9lyeIV0+KDp
 U+bhtrf8gRBN19tGRFjngHwzvJk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.22 um 18:06 schrieb Junio C Hamano:
> This uses atoi() and checks if the result is not zero to decide what
> to do.  Turning it into the usual Boolean environment variable to
> use git_env_bool() would not break those who have been using "set to
> 0, or set to non-zero, that can be parsed with atoi()" values, but
> will match the expectation of those who expected "true" to mean
> "yes".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git.txt | 1 +
>  write-or-die.c        | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index e2f61a1ec8..3d31252bf2 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -722,6 +722,7 @@ for further details.
>  	waiting for someone with sufficient permissions to fix it.
>
>  `GIT_FLUSH`::
> +// NEEDSWORK: make it into a usual Boolean environment variable
>  	If this environment variable is set to "1", then commands such
>  	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
>  	'git check-attr' and 'git check-ignore' will
> diff --git a/write-or-die.c b/write-or-die.c
> index c4fd91b5b4..aaa0318e82 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -23,6 +23,7 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>
>  	if (f =3D=3D stdout) {
>  		if (skip_stdout_flush < 0) {
> +			/* NEEDSWORK: make this a normal Boolean */
>  			cp =3D getenv("GIT_FLUSH");

OK, how about this?

=2D-- >8 ---
Subject: [PATCH] environ: use git_parse_maybe_bool() for GIT_FLUSH

Accept textual boolean values like "true" and "false" for GIT_FLUSH by
using git_parse_maybe_bool() to parse the variable's value.  Here's
how this changes whether to flush:

                       before                  with this patch
=2D--------------------- ----------------------- -----------------------
(unset)                if stdin is not a file  if stdin is not a file
GIT_FLUSH=3D             no                      no
GIT_FLUSH=3D0            no                      no
GIT_FLUSH=3D1	       yes                     yes
GIT_FLUSH=3Dfalse        no                      no
GIT_FLUSH=3Dtrue         no                      yes
GIT_FLUSH=3Dbogus        no                      if stdin is not a file
GIT_FLUSH=3D10000000000  yes                     if stdin is not a file

The patch looks big because it reverses the meaning of the variable
skip_stdout_flush.  The non-negated flush_stdout maps directly to the
return value of git_parse_maybe_bool() (0 false, 1 true, -1 invalid).

This implementation ignores invalid values, and doesn't even report
them, as before.  If we want to do that then we need to stop parsing
the variable lazily, in order to report errors before the first
output is written -- in maybe_flush_or_die() it's too late.

Requested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git.txt | 10 ++++------
 write-or-die.c        | 18 +++++++++---------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1d33e083ab..3ce0df983c 100644
=2D-- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -722,15 +722,13 @@ for further details.
 	waiting for someone with sufficient permissions to fix it.

 `GIT_FLUSH`::
-// NEEDSWORK: make it into a usual Boolean environment variable
-	If this environment variable is set to "1", then commands such
+	If this Boolean environment variable is set to true, then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
 	'git check-attr' and 'git check-ignore' will
 	force a flush of the output stream after each record have been
-	flushed. If this
-	variable is set to "0", the output of these commands will be done
-	using completely buffered I/O.   If this environment variable is
-	not set, Git will choose buffered or record-oriented flushing
+	flushed.  If it is set to false, then the output of these commands will
+	be done using completely buffered I/O.  If unset or set to an invalid
+	value, Git will choose buffered or record-oriented flushing
 	based on whether stdout appears to be redirected to a file or not.

 `GIT_TRACE`::
diff --git a/write-or-die.c b/write-or-die.c
index aaa0318e82..444e72b69a 100644
=2D-- a/write-or-die.c
+++ b/write-or-die.c
@@ -17,23 +17,23 @@
  */
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
-	static int skip_stdout_flush =3D -1;
+	static int flush_stdout =3D -1;
 	struct stat st;
 	char *cp;

 	if (f =3D=3D stdout) {
-		if (skip_stdout_flush < 0) {
-			/* NEEDSWORK: make this a normal Boolean */
+		if (flush_stdout < 0) {
 			cp =3D getenv("GIT_FLUSH");
 			if (cp)
-				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
-			else if ((fstat(fileno(stdout), &st) =3D=3D 0) &&
-				 S_ISREG(st.st_mode))
-				skip_stdout_flush =3D 1;
+				flush_stdout =3D git_parse_maybe_bool(cp);
+		}
+		if (flush_stdout < 0) {
+			if (!fstat(fileno(stdout), &st) && S_ISREG(st.st_mode))
+				flush_stdout =3D 0;
 			else
-				skip_stdout_flush =3D 0;
+				flush_stdout =3D 1;
 		}
-		if (skip_stdout_flush && !ferror(f))
+		if (!flush_stdout && !ferror(f))
 			return;
 	}
 	if (fflush(f)) {
=2D-
2.39.0
