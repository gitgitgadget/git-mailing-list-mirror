Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06081F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031813AbeBNWWW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:22 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52204 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031778AbeBNWWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so25584379wmd.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db+KAPZUk/EyX1yaxtiyWvALVmiLIG+qRFQURlOqF80=;
        b=gDUE3IJzpNhnWZdBneVrT/aPQBMT967x11bgaoDmedJ+Q4G8eo0FNJDHLqOtCC0mXF
         1TIQ7rkvFgqUugeDDp10iwdIm3S5UP+BDTsTRSDPZXVu3IE2BDPvPvwXGVjCUkQS5Z1u
         NzHrMSRMTAZlh8GZETWegLECf2pIYniMkygFUV+Oc89EhxpcG3FSgken8r5z+AR/RyYC
         68cDg7B3X0X25BuFr/Hv8s954Vns4Q1/rDujbfPEfQaqiDWu0onNJg87tjd9RtumvLz+
         x6INrIfpNdWwMkj2tFjrYRz5hNI0t+vrlkoLFO+qJ51hxq0jtt41lQTBsfJyOloo8RpU
         uTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db+KAPZUk/EyX1yaxtiyWvALVmiLIG+qRFQURlOqF80=;
        b=LI9EO0uXFyqvOLh7FHh0AOMK2QByiHMe05ePbqm0fy7HsctIybrn7k5hK0cNLjoAnc
         nl68yZV/o+3jZk0Xz6AQ+Maz7tZ5vvHMW7QgoatCb2PXNJhM1VK6t4H595QtaYxm1Gqs
         wic+8XGAcWXFn6qQeXi2QQ+k5AmZrsvk063W7fJSjWjfjQSlNi6Y9fjqUPGN36uahTsp
         enA397vfCaQOD/ChRNOOqxz5imoN3YawB/4Utf4GU+05B078KHsz1FRNy9Y8/HxkZh9s
         Dov96Y72J8wjYShHa0o2xiUxIciHoVeYD2wkbWG9PgWk2wD9EhPsiQS8EA9P0mu+/F/N
         bnPw==
X-Gm-Message-State: APf1xPAAtmhBo/vzfZYebyz6THCbusFblS57U49VgkGuZ+S59b8It+1s
        OQy6SRUbx4jxf8RqFw2CNLIOpTHa
X-Google-Smtp-Source: AH8x224k3pWdkLdJZSEj8FEH0su+7QeQcw62fk5EU1L7INN8aFnQg8KonY0W/IoyBBwt1QBDuwABHA==
X-Received: by 10.28.184.82 with SMTP id i79mr421240wmf.6.1518646934673;
        Wed, 14 Feb 2018 14:22:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] git-send-email: unconditionally use Net::{SMTP,Domain}
Date:   Wed, 14 Feb 2018 22:21:44 +0000
Message-Id: <20180214222146.10655-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Net::SMTP and Net::Domain were both first released with perl
v5.7.3, since my d48b284183 ("perl: bump the required Perl version to
5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's no
reason to conditionally require this anymore.

This conditional loading was initially added in
87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",
2006-06-01) for Net::SMTP and 134550fe21 ("git-send-email.perl - try
to give real name of the calling host to HELO/EHLO", 2010-03-14) for
Net::Domain, both of which predate the hard dependency on 5.8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 85bb6482f2..69bd443245 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1143,10 +1143,9 @@ sub valid_fqdn {
 sub maildomain_net {
 	my $maildomain;
 
-	if (eval { require Net::Domain; 1 }) {
-		my $domain = Net::Domain::domainname();
-		$maildomain = $domain if valid_fqdn($domain);
-	}
+	require Net::Domain;
+	my $domain = Net::Domain::domainname();
+	$maildomain = $domain if valid_fqdn($domain);
 
 	return $maildomain;
 }
@@ -1154,17 +1153,16 @@ sub maildomain_net {
 sub maildomain_mta {
 	my $maildomain;
 
-	if (eval { require Net::SMTP; 1 }) {
-		for my $host (qw(mailhost localhost)) {
-			my $smtp = Net::SMTP->new($host);
-			if (defined $smtp) {
-				my $domain = $smtp->domain;
-				$smtp->quit;
+	require Net::SMTP;
+	for my $host (qw(mailhost localhost)) {
+		my $smtp = Net::SMTP->new($host);
+		if (defined $smtp) {
+			my $domain = $smtp->domain;
+			$smtp->quit;
 
-				$maildomain = $domain if valid_fqdn($domain);
+			$maildomain = $domain if valid_fqdn($domain);
 
-				last if $maildomain;
-			}
+			last if $maildomain;
 		}
 	}
 
-- 
2.15.1.424.g9478a66081

