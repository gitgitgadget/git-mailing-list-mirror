Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6E71F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeACFHk (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:07:40 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43965 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeACFHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:07:39 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so507396ita.2;
        Tue, 02 Jan 2018 21:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A5fMCDqAZ9cb8Oenwrmq7Bw9eJBj6JAgVvfvneL6tDk=;
        b=QOzXOYEFOdA98f3vj43FdIsF9vKE93wgZTMuqFL3sMt6KVZ03lPT+/Ar0j0E+kLxOI
         59NU2P/NTTo4V2rWHPAID9F0X8Z39yNShpGXUCsCh6FOmjVwzCC4D8C5FD2Gyb1DJpnX
         IJJXDOZGvnCGLVxgk62/cIByfvLKfBpRTu7LKPA0emtrSKzoEc4N0YI38ZJPZHkod2qw
         DpQNODt8I+2Abo0wp+ONCXZn/AEyjmOuUt1IZi5YvkMKjTwPohiJZ8ccTpf90Hcxf5Hj
         aVdqP5QC8DCK/JN2crPL3P0U+OQJL5A+ULuYpeXDT3HaLHkercFUJ414keC8g8DcOmBl
         1SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5fMCDqAZ9cb8Oenwrmq7Bw9eJBj6JAgVvfvneL6tDk=;
        b=lURm1t+OttDF9e/qcLcd5LJoLWP43/UsQI5Ea3VTgvULAlnWRe+dI7G1BsYNg0+s6U
         xGk0FRlWdAUl5d3WgBvE2PpOKtz6ERTtU1peyxw8ykDH9HZJf6Jr1BVcT1KjnBn7KAhb
         IAkBoYfUNbjckqiS+jMgMS3IuExPI7a+vOeBnX4DbEJiF8nfrdJChILc1VVKdQga3jFj
         ec/IdcdunAoEVBvterwyV57ipxXh0+jY9qV4YLIHU53O0lA1fSIZ1LhB4C8Kut9t6Sbq
         MYT3smXpsFeixiq3uXCca84FBvHWyEl8CCNF94H96m/z6TGYGqL+mOO3flW+TF7rj8WZ
         oLXw==
X-Gm-Message-State: AKGB3mLcd/zJTiFyaJXuPSW8fdD0DPArGQXziBk9WCQ4d39vcOtHsaHY
        JxESprrbnTdPktsF2G5/e9E=
X-Google-Smtp-Source: ACJfBosgidOmLiQArjAFuny4B8P7T7BXymSBD+dHpdVXjM1LKsmNe31HtmgvljPfDsql6o6axr67iQ==
X-Received: by 10.36.73.233 with SMTP id e102mr557511itd.114.1514956058120;
        Tue, 02 Jan 2018 21:07:38 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v19sm223771ite.4.2018.01.02.21.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 21:07:37 -0800 (PST)
Date:   Tue, 2 Jan 2018 21:07:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180103050730.GA87855@aiede.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

Bryan Turner wrote:

> Our test environment is still on Ubuntu 12.04 LTS (it's a long story,
> but one I doubt is unique to us), which means it's using OpenSSH 5.9.
> ssh -G was added in OpenSSH 6.8 [1], circa March 2015, which means the
> "auto" detection "fails" and chooses "simple" instead of "ssh". But
> OpenSSH 5.9 _does_ support -4, -6 and -p. As a result, commands which
> have been working without issue on all previous versions of Git start
> to fail saying
>
> git -c gc.auto=0 -c credential.helper= fetch --force --prune --progress ssh://localhost:64281/repo.git +refs/*:refs/*' exited with code 128 saying: fatal: ssh variant 'simple' does not support setting port

Hm, that's not expected.  git-config(1) says:

	By default, Git determines the command line arguments to use
	based on the basename of the configured SSH command
	(configured using the environment variable GIT_SSH or
	GIT_SSH_COMMAND or the config setting core.sshCommand). If the
	basename is unrecognized, Git will attempt to detect support
	of OpenSSH options by [...]

So my first question is why the basename detection is not working for
you.  What value of GIT_SSH, GIT_SSH_COMMAND, or core.sshCommand are
you using?

> I know Ubuntu 12.04 LTS is end-of-life, but 14.04 LTS, which is
> running OpenSSH 6.6 [2], has the same issue. The following is from a
> fully patched 14.04.5:
>
> bturner@ubuntu:~$ cat /etc/*ease | head -4
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=14.04
> DISTRIB_CODENAME=trusty
> DISTRIB_DESCRIPTION="Ubuntu 14.04.5 LTS"
>
> bturner@ubuntu:~$ ssh -V
> OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.8, OpenSSL 1.0.1f 6 Jan 2014
>
> bturner@ubuntu:~$ ssh -G -p 7999 localhost
> unknown option -- G

It's good you caught this flaw in the detection.  Would something like
the following make sense?  If so, I can resend with a commit message
and tests tomorrow or the day after.

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 64c1dbba94..75eafd8db6 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -2118,8 +2118,8 @@ ssh.variant::
 	unrecognized, Git will attempt to detect support of OpenSSH
 	options by first invoking the configured SSH command with the
 	`-G` (print configuration) option and will subsequently use
-	OpenSSH options (if that is successful) or no options besides
-	the host and remote command (if it fails).
+	OpenSSH options if that is successful or a conservative set of
+	OpenSSH-style options if it fails.
 +
 The config variable `ssh.variant` can be set to override this detection.
 Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
diff --git i/connect.c w/connect.c
index c3a014c5ba..3784c2be53 100644
--- i/connect.c
+++ w/connect.c
@@ -941,10 +941,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 
 	if (flags & CONNECT_IPV4) {
 		switch (variant) {
-		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
 			die("ssh variant 'simple' does not support -4");
+		case VARIANT_AUTO:
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -953,10 +952,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		}
 	} else if (flags & CONNECT_IPV6) {
 		switch (variant) {
-		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
 			die("ssh variant 'simple' does not support -6");
+		case VARIANT_AUTO:
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -970,10 +968,9 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 
 	if (port) {
 		switch (variant) {
-		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
 			die("ssh variant 'simple' does not support setting port");
+		case VARIANT_AUTO:
 		case VARIANT_SSH:
 			argv_array_push(args, "-p");
 			break;
@@ -1026,7 +1023,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 				 VARIANT_SSH, port, flags);
 		argv_array_push(&detect.args, ssh_host);
 
-		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
+		variant = run_command(&detect) ? VARIANT_AUTO : VARIANT_SSH;
 	}
 
 	argv_array_push(&conn->args, ssh);
diff --git i/t/t5601-clone.sh w/t/t5601-clone.sh
index 0f895478f0..0224edc85b 100755
--- i/t/t5601-clone.sh
+++ w/t/t5601-clone.sh
@@ -365,6 +365,11 @@ test_expect_success 'OpenSSH variant passes -4' '
 	expect_ssh "-4 -p 123" myhost src
 '
 
+test_expect_success 'OpenSSH passes GIT_PROTOCOL envvar' '
+	git -c protocol.version=1 clone [myhost:123]:src ssh-v1-clone &&
+	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
+'
+
 test_expect_success 'variant can be overridden' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/putty" &&
 	git -c ssh.variant=putty clone -4 "[myhost:123]:src" ssh-putty-clone &&
@@ -377,19 +382,32 @@ test_expect_success 'variant=auto picks based on basename' '
 	expect_ssh "-4 -P 123" myhost src
 '
 
-test_expect_success 'simple does not support -4/-6' '
+test_expect_success 'variant=simple does not support -4/-6' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
-	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple
+	test_must_fail git -c ssh.variant=simple clone -4 "myhost:src" ssh-4-clone-simple
 '
 
-test_expect_success 'simple does not support port' '
+test_expect_success 'variant=simple does not support port' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
-	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-simple
+	test_must_fail git -c ssh.variant=simple clone "[myhost:123]:src" ssh-bracket-clone-simple
+'
+
+test_expect_success 'old OpenSSH passes -4 and -p' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/old" &&
+	git -c ssh.variant=auto clone -4 "[myhost:123]:src" old-ssh-clone &&
+	expect_ssh "-4 -p 123" myhost src
 '
 
-test_expect_success 'uplink is treated as simple' '
+test_expect_success 'old OpenSSH does not pass GIT_PROTOCOL envvar' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/old" &&
+	git -c protocol.version=1 -c ssh.variant=auto clone "[myhost:123]:src" old-ssh-protocol-v1 &&
+	expect_ssh "-p 123" myhost src
+'
+
+test_expect_success 'uplink is treated as old OpenSSH' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
-	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	git -c protocol.version=1 clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	expect_ssh "-p 123" myhost src &&
 	git clone "myhost:src" ssh-clone-uplink &&
 	expect_ssh myhost src
 '
@@ -405,8 +423,8 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
 	test_when_finished "rm -f \"\$TRASH_DIRECTORY/uplink\"" &&
 	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
 	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
-	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
-	expect_ssh "-p 123" myhost src
+	git -c protocol.version=1 clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
+	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
 '
 
 test_expect_success 'plink is treated specially (as putty)' '
