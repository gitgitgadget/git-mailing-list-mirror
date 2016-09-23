Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362431F935
	for <e@80x24.org>; Fri, 23 Sep 2016 09:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938610AbcIWJIv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 05:08:51 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47148 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933536AbcIWJIs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Sep 2016 05:08:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 820502059C;
        Fri, 23 Sep 2016 05:08:47 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 23 Sep 2016 05:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=VZiXjb10JA3DKzz7tW09A/FgccE
        =; b=b29nbAooiA/RcGRRM5WT7iCGAP03FppXZicL2SI6pO+GtjrS8g/Wppo4qPi
        v3SOKyYiQ4+w9pbZSD9voksc0igxMRbIw53WWiYGwgScl39BD4c7z22BuYj5ylhr
        QdX1SdZWPXzcT+VH4zGq34Gt07oK+Rdak2zJatjkdkiGmI5E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=VZiX
        jb10JA3DKzz7tW09A/FgccE=; b=QbJ0AyBw9EI1tuw0j3q8AHgwYH9mx3eUcHc/
        PqurHn0+DQLqsWMOTlpjnhjyWJVkm2SD2qKMhLAxCtfB1ojLxUozAYFsLkaur+t7
        GVhs7rMEXTurDKa9FkvdrZc1vfMAwGp8hLRmBqUOjLEFpDrpLX/o7Kh4EEexj6P4
        AQhvWRk=
X-Sasl-enc: EcO9ORtK8ttvZ7Qksx3/vaJeMhHcYqoZl/UKup41nnjQ 1474621727
Received: from treetowl.lan (c-73-53-70-213.hsd1.wa.comcast.net [73.53.70.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E4BACCEA3;
        Fri, 23 Sep 2016 05:08:47 -0400 (EDT)
Received: by treetowl.lan (Postfix, from userid 1000)
        id 57C2B1C4048; Fri, 23 Sep 2016 02:08:46 -0700 (PDT)
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com
Subject: [PATCH v3 1/2] gitweb: remove unused function parameter
Date:   Fri, 23 Sep 2016 02:08:45 -0700
Message-Id: <20160923090846.3086-1-ian@iankelling.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
References: <2a5aead0-d521-85eb-f304-7091683d8b40@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ian Kelling <ian@iankelling.org>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33d701d..6cb4280 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3913,7 +3913,7 @@ sub blob_contenttype {
 # guess file syntax for syntax highlighting; return undef if no highlighting
 # the name of syntax can (in the future) depend on syntax highlighter used
 sub guess_file_syntax {
-	my ($highlight, $mimetype, $file_name) = @_;
+	my ($highlight, $file_name) = @_;
 	return undef unless ($highlight && defined $file_name);
 	my $basename = basename($file_name, '.in');
 	return $highlight_basename{$basename}
@@ -7062,7 +7062,7 @@ sub git_blob {
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
 	my $highlight = gitweb_check_feature('highlight');
-	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
+	my $syntax = guess_file_syntax($highlight, $file_name);
 	$fd = run_highlighter($fd, $highlight, $syntax)
 		if $syntax;
 
-- 
2.9.3

