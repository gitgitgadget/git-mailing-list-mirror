Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27169C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhLTWj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:39:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:42733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhLTWj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640039964;
        bh=/ItQJtD6vOgSM3vt4ZyoIJzAH0jmN9TGdp6IMxlDycc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ik/gefXUOWmWP5PqppFOXhboUfqqUe/Il04wLG9qNDQiDdQYxunblDQ5xb+JX7QSJ
         2iaSzApzKSDOh+WTDSJCMmE7bex+5jPCTpjmugboPE16opTWXMpRgyh9OyBv7yx+3d
         DI7LP3UHZKLBAGERLWom5+FICzt9mj90P1jjdM+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1n0GG92s9F-001R7g; Mon, 20
 Dec 2021 23:39:24 +0100
Date:   Mon, 20 Dec 2021 23:39:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sean Allred <allred.sean@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
In-Reply-To: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112202324110.347@tvgsbejvaqbjf.bet>
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wWCuufKO6IzB11s5f7lbTnGZ9VdcjkAxsPkl06FfbeAaRW19/Pj
 FPXKBIpngAcDdcJKj9kVZF0wulNcUHVeKTo7+9D5VD4Y/f8W5FnE/sX/BAYgSTv0idtiOwx
 VzrOgDPHRPFh2APJoQ/TEG6Pyvc/zzXQXlVNy1l5GoYYYMgRFC6XItR1jKckaamMRYudPr6
 DjXLrwYU2/AeqcFhbalfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JNlBRUu2dM=:njubScoJWIF4Nnn0L+qvcI
 GN+6rHXlqRA6Mrv1cbfAHWMU7bySXvgwz0W2HLiOMiwO7tTHktlQNrFHGLPVDESXgP5OoPK1d
 E7bjjdVNNvGDyAKpC/9TPJ+wZe/P8BVX0dJLHV1KMxQzFkkhb31rneNkZc93/H0S9CZtEj/yW
 0ZP5DynjaCVlM+K2FmrgrowVUNcSW1m5B94kQ+atHSR/K0tw3fuwskqHYdd+yzWMEz6Rij80D
 fO91eSZi5qkTdBjmWM6ymz7fiz4cVYHaNUZJOfHPmD6x97GT8HeEyCgEwIIj4/F9sTU2sMJzc
 SjNXGoHzkwQgAW4IXb3OP3/kM/ivAFi0tN8zL1d9xy92FxdzurCMbSh0asJ0aHqamUf5SAx8U
 7XX6oV7OFiSQ2A7hFUpYGzNuWCkPQXXjEokLdVIzM7vMhNhlKzzyQipJ/yF1IUSVS42/CGkFr
 dh/kLDx67xn1CKAd3jNxRtkw0x1jpHsJoxzRE7Meh6rB7NuDy/MjUT3wTnw0c5AsmgpkN5qVn
 vAOuGQqFMo7SWokThT5djOFHclXwnXzC/ckSOGG7kq6laaF48Q1anQCFIy3youp44Kg93P8Dn
 eqiCZu5lE0yiV2HTiAeiDXq91mODNjR5Hu7znZeQb5Rrwk6/XVSGEfm1vmTkMyJw99HfmKCEO
 gflpx1aXk9N3w46Xo8j37W0PTp9Qo10M4RK/pmok0mv1Rt0KaTN36CZnnkt8xFFnft2q0wMBg
 4J6n6bxGsQMDHJ/WAMqrm+J6AT0XhVNzNg/LfhvvQuVji42Z7Vca8M9P7FyWloQvfkNuTL1oG
 e7Edrz3SkGC49lWGCcw903y2zKAvfghd/NYIcahGcMJTGb9AL6jqnawZI6jVVfWQlWqJIzGxF
 j/q5aVtbR0D0R1VQ1qNLfYpNU4z6h3KqC2dZdvrQJz+9gQwNnd/1029Cnuv8KixczrsdrZcA9
 134aNaWNGGBSMBiO4NbYDSv/kMxUGG/5qEPuRzqR2CBBzoBw3ZTXXGtN0OlHZJJMHQQygWXTS
 cHTyBDJdxpiYgcx6EB1F1eRK8bp37xUMfaHz9OjsbZXus0ZAWIzTIduogCuGZHm9DJc08MhBW
 aRemlYtRl4vyjI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean,

On Sat, 18 Dec 2021, Sean Allred wrote:

> I've got a custom subcommand I'm distributing in my company to integrate
> with our bug-tracker. It's a pretty robust utility and has its own help
> function, but running `git foo --help` doesn't pass --help to my git-foo
> utility. I asked a question[1] about this scenario on the Windows fork
> and they directed me upstream.
>
> It sounds like `git foo --help` is internally consumed as `git help
> foo`, which forwards requests to info/man/web handlers per config.
> Being on Windows and knowing my peers as I do, the vast majority of my
> users won't be familiar with info or man. The HTML documentation used
> by the web handler is in a Git4Win-controlled installation directory
> that I'd really rather not touch/maintain. I really just want `git foo
> --help` to call `git-foo --help`.
>
> What's the best way to go about this?
>
> In the event the best next step is to start a patch, does it sound
> reasonable to simply not perform this `git foo --help` -> `git help
> foo` transformation for non-builtins? Or, while I don't relish the
> idea, would some kind of config option be needed?

I think you might need to be a bit more careful than just looking whether
the command in question is a built-in or not. It could be delivered as a
script or executable inside `libexec/git-core`. So maybe check that,
something like this:

=2D- snip --
diff --git a/git.c b/git.c
index c802dfe98004..d609f90cc117 100644
=2D-- a/git.c
+++ b/git.c
@@ -688,6 +688,33 @@ static void strip_extension(const char **argv)
 #define strip_extension(cmd)
 #endif

+static int is_in_git_exec_path(const char *command_name)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	if (!command_name)
+		return 0;
+
+	strbuf_addf(&path, "%s/git-%s", git_exec_path(), command_name);
+	ret =3D !access(path.buf, X_OK);
+
+#ifdef STRIP_EXTENSION
+	if (!ret) {
+		/*
+		 * If `command_name` ended in `.exe`, strip it, otherwise
+		 * append it.
+		 */
+		if (!strbuf_strip_suffix(&path, STRIP_EXTENSION))
+			strbuf_addstr(&path, STRIP_EXTENSION);
+		ret =3D !access(path.buf, X_OK);
+	}
+#endif
+
+	strbuf_release(&path);
+	return ret;
+}
+
 static void handle_builtin(int argc, const char **argv)
 {
 	struct strvec args =3D STRVEC_INIT;
@@ -697,8 +724,11 @@ static void handle_builtin(int argc, const char **arg=
v)
 	strip_extension(argv);
 	cmd =3D argv[0];

+	builtin =3D get_builtin(cmd);
+
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
-	if (argc > 1 && !strcmp(argv[1], "--help")) {
+	if (argc > 1 && !strcmp(argv[1], "--help") &&
+	    (builtin || is_in_git_exec_path(argv[0]))) {
 		int i;

 		argv[1] =3D argv[0];
@@ -714,7 +744,6 @@ static void handle_builtin(int argc, const char **argv=
)
 		argv =3D args.v;
 	}

-	builtin =3D get_builtin(cmd);
 	if (builtin)
 		exit(run_builtin(builtin, argc, argv));
 	strvec_clear(&args);
=2D- snap --

Of course, this might break existing users' setups where they ship a Git
command together with a manual page.

A potential remedy against that would be, as you say, a config option.
Maybe defaulting to the manual page if `help.format` is `man`, otherwise
defaulting to passing `--help` to the command.

Ciao,
Dscho

>
> Best,
> Sean Allred
>
> [1]: https://github.com/git-for-windows/git/discussions/3553
>
