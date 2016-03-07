From: Alexander Rinass <alex@fournova.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Mon, 7 Mar 2016 08:47:47 +0100
Message-ID: <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com> <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com> <56D9D8C6.2060104@ramsayjones.plus.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 08:47:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acpsw-0008Hl-2e
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 08:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbcCGHrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2016 02:47:17 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36838 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcCGHrR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2016 02:47:17 -0500
Received: by mail-wm0-f54.google.com with SMTP id n186so72676219wmn.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pp5jvINkCe9KcdWNQrNxRDoDmqJYu2S65GrbZa290kk=;
        b=LeXuxEGq8f4aT2LCJrPyoLdx1q9Eb6Q+FCG6lisOZ7HtfArd/CgpjDF/Rqj/LlsVSz
         cPX2rogh41qzRtUtK4MI49UzyFFOnHIZv4TCbb8gTBMpRUa6k3sPChkAoy/xpFzAPXKt
         riTdQa3BtnKJT4nZoEkmSnJDzx4NliNoN5gKaprTc7C5Jw0HxFTjw2lLKEqsuKayXJF7
         cbn73YXo/LdydApRMDisFcHU3vA5kdCkLL/QYk7gFhQPR6/Vo9C7EWH2R6ogRC16Iuzl
         bIaFG5yL1T3TYXYsQMxnstJDj6LtAoKz90i6RGfZpBwqkFWWTsJYY7gEDrPRNjVYfom6
         dGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Pp5jvINkCe9KcdWNQrNxRDoDmqJYu2S65GrbZa290kk=;
        b=HYxDd4sXNd0e51zGymJTvwMq9zlKuRR908buyTir4NekBQg/iI8TgWBotRqhA06c12
         XHuY9iX4vu4SpVTotj28zRYzBKgwNV4kCSI7tatTrNaYYV06cffbQ4cDQ4wRtPufl+1s
         uJSaVkRMIAAA6aatws92FE/gxpyHq59/gpNaKLLNswc+q5+xBHM389NCaqItQ42lUkJE
         xzpZQBC94LKhm0CxshMi15XlCbVvGarQZ++rUul9SUWmD3gD5W2oJyMpra+ADGNDg4en
         7y3fY1s5iJDGo7sKl5VEN8kRXkKIidHZqNYlEow0JjwxBvWuO4bZIMBdbHEjo5HNjXAD
         YQ3A==
X-Gm-Message-State: AD7BkJIDUzevgSehkeZt3wH6/muhuSp7U6xjmSiOCdqodpOYyIhfsioRV/LOEUSMaLxH4g==
X-Received: by 10.194.61.240 with SMTP id t16mr21114036wjr.27.1457336835348;
        Sun, 06 Mar 2016 23:47:15 -0800 (PST)
Received: from ?IPv6:2a02:908:df42:8b00:8962:7301:7cdc:4fc7? ([2a02:908:df42:8b00:8962:7301:7cdc:4fc7])
        by smtp.gmail.com with ESMTPSA id l135sm12336896wmb.13.2016.03.06.23.47.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 23:47:14 -0800 (PST)
In-Reply-To: <56D9D8C6.2060104@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288381>


> On 04 Mar 2016, at 19:49, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
>=20
> On 04/03/16 14:37, Alexander Rinass wrote:
>>=20
>>> On 04 Mar 2016, at 13:16, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
>>>=20
>>> On 03/04/2016 10:07 AM, Alexander Rinass wrote:
> [snip]
>=20
>>=20
>> Sticking a precompose_argv(argc, argv) into diff.c=E2=80=99s cmd_dif=
f function fixes the issue.
>>=20
>> But I had to disable the check (precomposed_unicode !=3D 1) in preco=
mpose_argv to make it work. That=E2=80=99s probably because precompose_=
argv is usually called from parse_options and is missing some other cal=
l before it?
>>=20
>=20
> Yes, you need to place it after the configuration is read, but before
> calls to diff_no_index() or setup_revisions(). Directly after the cal=
l
> to git_config() should be fine. [But this begs the question about oth=
er
> commands, including plumbing, which don't call parse_options().]
>=20
> Maybe this will work for you (I can't test it, since I don't have any
> access to a Mac):
>=20
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 343c6b8..b7a9405 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -320,6 +320,7 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
> 		gitmodules_config();
> 	init_diff_ui_defaults();
> 	git_config(git_diff_ui_config, NULL);
> +	precompose_argv(argc, argv);
>=20
> 	init_revisions(&rev, prefix);

Your patch fixes it for the diff command without further modifications.

I have also modified diff-tree, diff-index and diff-files by adding the=
 precompose_argv call and successfully verified it.

I have attached the full patch. If there is anything else I can test, l=
et me know.

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 8ed2eb8..15c61fd 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -24,6 +24,7 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev =3D 0;
+	precompose_argv(argc, argv);
=20
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	while (1 < argc && argv[1][0] =3D=3D '-') {
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index d979824..1af373d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -21,6 +21,7 @@ int cmd_diff_index(int argc, const char **argv, const=
 char *prefix)
 	gitmodules_config();
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev =3D 0;
+	precompose_argv(argc, argv);
=20
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 2a12b81..806dd7a 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -114,6 +114,8 @@ int cmd_diff_tree(int argc, const char **argv, cons=
t char *prefix)
 	opt->disable_stdin =3D 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak =3D diff_tree_tweak_rev;
+
+	precompose_argv(argc, argv);
 	argc =3D setup_revisions(argc, argv, opt, &s_r_opt);
=20
 	while (--argc > 0) {
diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..d6b8f98 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -319,6 +319,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	if (!no_index)
 		gitmodules_config();
 	git_config(git_diff_ui_config, NULL);
+	precompose_argv(argc, argv);
=20
 	init_revisions(&rev, prefix);
=20
