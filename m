Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCAE1FAE2
	for <e@80x24.org>; Sun,  4 Mar 2018 11:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeCDL1X (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 06:27:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42029 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeCDL1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 06:27:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id k9so14353084wre.9
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/qb/c/nHl3s0f7tBGOarwE26aVCg/B6Oo6buXqx2t8=;
        b=TBn1jIwTe4NPRCgp+BgioFtMK+RXdjSXDGhetcXllTT5jQYURWmxQIxRjFQt0rSFDH
         gMXE80sQTcSwyhdplfZ9MV63o3GdRFNjbqGGg6F5NL4zBqmKZQ13bk37Ugr26bETaXTS
         rRs1kKu0Wggdn9qUpu5L4CySUgsWNLkO5kcKI9P11802OkSJ56pIvdokUFFk/UTanZTm
         XDQ9FmJnb6sp3H5H0+m7eyHTMixe1bcJ+CG6YZ4TXcu3t8u7aj9XTUcwjvMvb5AX+6HG
         CGNn/ur/eA0V2MimIsTjtSbwuwSpLeW2V7kUpQjQIcEx7r43vFQos8Tz8w9IgFM1ymY6
         LQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/qb/c/nHl3s0f7tBGOarwE26aVCg/B6Oo6buXqx2t8=;
        b=iH42vJDIWzDldwtUIqv3BB+OVRws9yaYNan5apy/NxUq8dgE7Y4A5rbidFIG2ltNr2
         sGSgr/ExWhDUMmvufuUdiv7dERYXszZye71M8Q4L9kNGTk11eIpG9i0J3KSkIZsDM34S
         b+vHeJqidc0rznvM8rLQovicZN7LPBbjX8VBJy9ifxJ8Zj1ZfY/acHqRqi+ksKsDSsq3
         xmGClwLxtTiHCMDGNWTFfWMIlESQE0Cft+MEG7seieIIipJmVhLVLIzDZo1OuTADqqio
         7wCYQ2eglkrv9LiaqZbcIRpnLK4cHI2g8G+Y9AkPLAqzzEN5CjXSjrcLVxXLR7T2nL16
         wdiw==
X-Gm-Message-State: APf1xPB9jTIli358hKIjkTAcY9fM2EaWfF6UCLg/ZPSnqC7Df/81giQw
        IH/JN/QCwEUv6BGQAjNLFj8R9A==
X-Google-Smtp-Source: AG47ELsLPhICcaPf8m+XoVZPhN7IkrhJVPFpqxPpuDhAHDbClFXegISFGsbzcKGfvvreQnD2DGWTEg==
X-Received: by 10.223.185.82 with SMTP id b18mr9419865wrg.180.1520162840522;
        Sun, 04 Mar 2018 03:27:20 -0800 (PST)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:5fe:bb85:ada6:d63b])
        by smtp.gmail.com with ESMTPSA id o94sm16684005wrc.7.2018.03.04.03.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Mar 2018 03:27:19 -0800 (PST)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 2/2] git-svn: allow empty email-address in authors-prog and authors-file
Date:   Sun,  4 Mar 2018 12:22:37 +0100
Message-Id: <20180304112237.19254-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304112237.19254-1-asheiduk@gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The email address in --authors-file and --authors-prog can be empty but
git-svn translated it into a syntethic email address in the form
$USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
is explicitly set to the empty string, the commit does not contain
an email address.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 perl/Git/SVN.pm | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index bc4eed3d75..b0a340b294 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1482,7 +1482,6 @@ sub call_authors_prog {
 	}
 	if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
 		my ($name, $email) = ($1, $2);
-		$email = undef if length $2 == 0;
 		return [$name, $email];
 	} else {
 		die "Author: $orig_author: $::_authors_prog returned "
@@ -2020,8 +2019,8 @@ sub make_log_entry {
 		remove_username($full_url);
 		$log_entry{metadata} = "$full_url\@$r $uuid";
 		$log_entry{svm_revision} = $r;
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email //= "$author\@$uuid";
+		$commit_email //= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = canonicalize_url(
 			add_path_to_url( $self->svnsync->{url}, $self->path )
@@ -2029,15 +2028,15 @@ sub make_log_entry {
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email //= "$author\@$uuid";
+		$commit_email //= "$author\@$uuid";
 	} else {
 		my $url = $self->metadata_url;
 		remove_username($url);
 		my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
 		$log_entry{metadata} = "$url\@$rev " . $uuid;
-		$email ||= "$author\@" . $uuid;
-		$commit_email ||= "$author\@" . $uuid;
+		$email //= "$author\@" . $uuid;
+		$commit_email //= "$author\@" . $uuid;
 	}
 	$log_entry{name} = $name;
 	$log_entry{email} = $email;
-- 
2.16.2

