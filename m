Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DB51F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeBYTrH (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeBYTrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id n7so19087625wrn.5
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SFjbhLghepNk/okzcY6yQ+AAqxxXqjwiJemTpnh9hME=;
        b=jAp1Q5APyW/1U8zDNxfiB5qdjjUTooKbdboEBGt9ucCdB4M8zePx7NImXtBoIswK94
         /V19icNh+VEusD/bwUI9Jau8bSDXEYKDNOfTxC3llZm09kkpXTUclM0/HOJKnGtkXYYr
         Qopw6WzVw0+SgKx0QWd+bLJ0knJAmqZfwRxXsMF95bS31DBGnq/x3028/k4XeUu52TVN
         YTwzMlSS19pq9xJE163mze7Ty0AAV3gghS7odXJBbvz9gjX/ehj0BTY5Pnu76df4b/Cz
         FXwrwdH1QnCOZqg27jRimB3ZtzxbbAW0TAs3A97gO7OjnFdz3FmEYHziegGgw0mWrJPH
         ElMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SFjbhLghepNk/okzcY6yQ+AAqxxXqjwiJemTpnh9hME=;
        b=Ov82Z9soRIuMWw9oL63Dc+GsMmXfF5Yobt8ZPzxWlF89DjAjAlysZVpL3UiukF4dOQ
         QqhhX0bsbx2olciE6qdpPZV6QoKjO3g8WJinvWKyQeS9FbeLimBa6eSYl9a20DR7xAiP
         jHCFsEwiE3I1rAcGesf+ifoo+YnWSNEULswxrvGY/ZPo0/H2UEoIB0C/KE04LS/jNnlg
         gOy+/Hx130MLjweg4To+ZQVi8vHI9aJIUME2p1aT8iscGnguuC6I141+KS8beV7SBRNm
         49kHNBeRVvJc2mJkTg4C+ERwMtWOai7v7loFXXNBUvlLVGoIj3BV/s/YYLL3zO0QLnIy
         fjHQ==
X-Gm-Message-State: APf1xPCEW5s+Ard5pG0SUwWVcp3HSFA2NXx3cHJ+4DSkThsj95u5ugKd
        Y8u2Kvs1cJKTkn64WQDV5ayN2vb1
X-Google-Smtp-Source: AH8x224PSksV29CQ8Mu7ise6kjpnumS4D3ApZA/ixmtkADa1fA0eKW3wvxjTUYH3lKbBQ5Lw8i+91g==
X-Received: by 10.223.161.144 with SMTP id u16mr7639111wru.137.1519588022068;
        Sun, 25 Feb 2018 11:47:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/13] Git.pm: hard-depend on the File::{Temp,Spec} modules
Date:   Sun, 25 Feb 2018 19:46:29 +0000
Message-Id: <20180225194637.18630-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since my d48b284183 ("perl: bump the required Perl version to 5.8 from
5.6.[21]", 2010-09-24), we've depended on 5.8, so there's no reason to
conditionally require File::Temp and File::Spec anymore. They were
first released with perl versions v5.6.1 and 5.00405, respectively.

This code was originally added in c14c8ceb13 ("Git.pm: Make File::Spec
and File::Temp requirement lazy", 2008-08-15), presumably to make
Git.pm work on 5.6.0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7ec16e6dde..151b0e7144 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -11,6 +11,8 @@ use 5.008;
 use strict;
 use warnings;
 
+use File::Temp ();
+use File::Spec ();
 
 BEGIN {
 
@@ -190,7 +192,6 @@ sub repository {
 		};
 
 		if ($dir) {
-			_verify_require();
 			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = abs_path($dir);
 
@@ -1289,8 +1290,6 @@ sub temp_release {
 sub _temp_cache {
 	my ($self, $name) = _maybe_self(@_);
 
-	_verify_require();
-
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
@@ -1324,11 +1323,6 @@ sub _temp_cache {
 	$$temp_fd;
 }
 
-sub _verify_require {
-	eval { require File::Temp; require File::Spec; };
-	$@ and throw Error::Simple($@);
-}
-
 =item temp_reset ( FILEHANDLE )
 
 Truncates and resets the position of the C<FILEHANDLE>.
-- 
2.15.1.424.g9478a66081

