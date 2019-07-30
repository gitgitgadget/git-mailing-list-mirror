Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34901F462
	for <e@80x24.org>; Tue, 30 Jul 2019 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfG3AN5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 20:13:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfG3AN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 20:13:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so55363859wme.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk0l0Q8S60cM0AMSHZj0q27ONKOhcFUfTgw13p9URIc=;
        b=NgXJ+PENZmofthMJ9i3poiqKlWjBnWR1XmcVEWpdCpZ2RNpqa6u2MP16vwmgr7mk36
         auG/av6w2JOnA6Qmwu+D8JvHr5QGOyQVKyp/wID277mAZBcBqHn/aTk8hS1mefWTavcU
         TmuG7Vmr9f7LOjOHlXiJPoo31HX8ECtD+mSgye4/l1As0Q7mHQ/rrvwKZYcXmvPrl/Fx
         VDL+s+6tvi81smvpSBvg+KEr1MW7G/MglK6LJARN5iH+5cZvznOWt9FF9OZvKZcKRp5s
         B3rCM+QUKh6ycUXVA7lysL8H7ebf9vX8uJD5WkDVoc5jcU6kgFJGgTziWTsocARgc890
         o6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk0l0Q8S60cM0AMSHZj0q27ONKOhcFUfTgw13p9URIc=;
        b=Xc6dDnOom3E5h1stT4F5BwKIfPrYPU5SjGFXj2fUR27rrSUUm5zk4rBj14qGfMxJ9W
         dnSi4XXDqzHW4cp1DbwspI77WOxB2mXCOglatM8V8ferntqYioKyQcaaa6x4pR/5qWg1
         JtwDXYBUuMS3fFXUOFUsn8uu7m2EKiz2M4p+X/2wQaoMYiuMqhsh2yWXLNfZCtW0/Wvm
         3Thhdt943GSUOYLu20RQMgIQffSdg6zwaf1sysZGb1XCcmfQ0QKuNUYkraOjVMCyBNj0
         QQ6j8SwuAxTQWUudgLApWIGzCpzCrBLRN05tgSVKem3ZzeA9U5kpejUUW9/FwKhptLIq
         /B6w==
X-Gm-Message-State: APjAAAUT56bTFH0Cvo1Sjun4G+P8Y8uwqyXTDfG2VivLtYXD6hCHwX7s
        TA4inZdIhluYfcmxNPgjZ+ygljioSvSgsMX0y/C77BenAQxuR8YH0ONevtxl6ICVU3boXnXQswh
        MwUoIuBOT5t47ptpdPqw9+rtyWxEsAJtnA2/dp5fU9XheXZ21/+2l0zrUbp43fMhi72EWOexhi2
        i7o0Jo2OJn3OO5CDk=
X-Google-Smtp-Source: APXvYqwGk8/Q9/D4g0GKx3r44gWRIs+o9bWgfbl09AOmdffqT10LvKOi4dq0zWcKPLltn+63Ymu+RQ==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr166367wma.23.1564445634269;
        Mon, 29 Jul 2019 17:13:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o20sm160672764wrh.8.2019.07.29.17.13.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 17:13:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH] send-email: Ask if a patch should be sent twice
Date:   Tue, 30 Jul 2019 01:13:52 +0100
Message-Id: <20190730001352.7477-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was almost certain that git won't let me send the same patch twice,
but today I've managed to double-send a directory by a mistake:
	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`

[I haven't noticed that I put the directory twice ^^]

Prevent this shipwreck from happening again by asking if a patch
is sent multiple times on purpose.

link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
Cc: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 git-send-email.perl | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5f92c89c1c1b..0caafc104478 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -33,6 +33,7 @@
 use Net::Domain ();
 use Net::SMTP ();
 use Git::LoadCPAN::Mail::Address;
+use experimental 'smartmatch';
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -658,6 +659,17 @@ sub is_format_patch_arg {
 	}
 }
 
+sub send_file_twice {
+	my $f = shift;
+	$_ = ask(__("Patch $f will be sent twice, continue? [y]/n "),
+		default => "y",
+		valid_re => qr/^(?:yes|y|no|n)/i);
+	if (/^n/i) {
+		cleanup_compose_files();
+		exit(0);
+	}
+}
+
 # Now that all the defaults are set, process the rest of the command line
 # arguments and collect up the files that need to be processed.
 my @rev_list_opts;
@@ -669,10 +681,19 @@ sub is_format_patch_arg {
 		opendir my $dh, $f
 			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
-		push @files, grep { -f $_ } map { catfile($f, $_) }
+		my @new_files = grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
+		foreach my $nfile (@new_files) {
+			if ($nfile ~~ @files) {
+				send_file_twice($nfile);
+			}
+		}
+		push @files, @new_files;
 		closedir $dh;
 	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
+		if ($f ~~ @files) {
+			send_file_twice($f);
+		}
 		push @files, $f;
 	} else {
 		push @rev_list_opts, $f;
-- 
2.22.0

