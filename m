Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FA51F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdKJNW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:22:28 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40774 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdKJNW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:22:27 -0500
Received: by mail-wm0-f68.google.com with SMTP id b9so2709878wmh.5
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUWsmMrrVZMEMyDjDfgFuoBvIJqwhzHotoFP2YzW1uw=;
        b=jHuN4qlgzrhSIYW7iIDNZrpqAbqQEn27O0bWUslf0UaWRlSjWlClOAZCsVbaMM8QL4
         PV+68SZU7FiPmAZ+qYIt+aQmCFrm2C/H+Pp1HDytCdjQWyJKwLM0sMWOqmKcwlWAZCaY
         A4/VVspUztaA5G8aNwoJ4ggjWl786pGy344JvA2DNG+iu3IbixRhC8vHxTYf9FRAjmlD
         VKxREFa7Su9tZ8It/walbWFhX8EjCI2sLjcVKdq+dQU37DSocssGAudrrFFucSVMORfb
         UFzJ1ZGjD/WPSCiesgml4ham8YfuCo01YdO5lqi2inYBVk03dx4FdNInX9tVQhb793Pe
         Nq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUWsmMrrVZMEMyDjDfgFuoBvIJqwhzHotoFP2YzW1uw=;
        b=qN5UceLnCBIZhfPGte3KM5XSfIgTSQIBV/YylG9S2u4QZN46O9eC/WCV2aU30M67LG
         2vy/YCcSJ372VRvy+0hfp1WPfaOE2TfM4OhpmAjI/d9aPvn52rNOcAPw/g57hiOgm8je
         QbeQYJR/awfM1R0mtvncmYgKR+KldsQzbs1eDkNncJ/cY9FWfyYwkCf94gNKIFKRk5ml
         2zUVSCIvT1h+lDkyc398AXJSYlU3tnVuVfDBMVuPBFnQ/c1StIdlrCxEQWjjX587kYzf
         7FczqRUpSyMip7TMCJm2lzHm9Rjv9Fmx8v60ZtHuzLjNUZopVB5CKccHBVfmI9G3hLIH
         DbfQ==
X-Gm-Message-State: AJaThX7bBXOBGc+nz0vVBqiXjfl2VV8Uudt79gR/XPeBHIYbNRe3DGZb
        JUyqvyv7DtPe5nquhw4HNOw+d/E9
X-Google-Smtp-Source: AGs4zMYBePvFOuOakG4tSa47kIEbujbQqM9SNXHiZ+4mv3O/CTMORG0p/BbGSeX+/638qvSew6BWUg==
X-Received: by 10.28.54.89 with SMTP id d86mr209816wma.101.1510320145474;
        Fri, 10 Nov 2017 05:22:25 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:22:24 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/8] t0021/rot13-filter: fix list comparison
Date:   Fri, 10 Nov 2017 14:21:53 +0100
Message-Id: <20171110132200.7871-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since edcc8581 ("convert: add filter.<driver>.process
option", 2016-10-16) when t0021/rot13-filter.pl was created, list
comparison in this perl script have been quite broken.

packet_txt_read() returns a 2-element list, and the right hand
side of "eq" also has a list with (two, elements), but "eq" takes
the last element of the list on each side, and compares them. The
first elements (0 or 1) on the right hand side lists do not matter,
which means we do not require to see a flush at the end of the
version -- a simple empty string or an EOF would do, which is
definitely not what we want.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ad685d92f8..4b2d9087d4 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -55,6 +55,20 @@ sub rot13 {
 	return $str;
 }
 
+sub packet_compare_lists {
+	my ($expect, @result) = @_;
+	my $ix;
+	if (scalar @$expect != scalar @result) {
+		return undef;
+	}
+	for ($ix = 0; $ix < $#result; $ix++) {
+		if ($expect->[$ix] ne $result[$ix]) {
+			return undef;
+		}
+	}
+	return 1;
+}
+
 sub packet_bin_read {
 	my $buffer;
 	my $bytes_read = read STDIN, $buffer, 4;
@@ -110,18 +124,25 @@ sub packet_flush {
 print $debug "START\n";
 $debug->flush();
 
-( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
-( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+packet_compare_lists([0, "git-filter-client"], packet_txt_read()) ||
+	die "bad initialize";
+packet_compare_lists([0, "version=2"], packet_txt_read()) ||
+	die "bad version";
+packet_compare_lists([1, ""], packet_bin_read()) ||
+	die "bad version end";
 
 packet_txt_write("git-filter-server");
 packet_txt_write("version=2");
 packet_flush();
 
-( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+packet_compare_lists([0, "capability=clean"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([0, "capability=smudge"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([0, "capability=delay"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([1, ""], packet_bin_read()) ||
+	die "bad capability end";
 
 foreach (@capabilities) {
 	packet_txt_write( "capability=" . $_ );
-- 
2.15.0.132.g7ad97d78be

