From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Subject: [PATCH] Add option --no-tags
Date: Tue, 29 Oct 2013 11:44:06 +0100
Message-ID: <CAMXp-VP9DDJ-L=e=7=-bO+ZFVRMVz-PAs0gGv8Q7RrZ-OWof9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 11:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb6mV-0003L4-0b
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 11:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab3J2KoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 06:44:09 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45440 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab3J2KoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 06:44:07 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so13926527iec.10
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aldebaran-robotics.com; s=google;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ZtOH+eYBtqH44LXGuQgIV3UVpIH09kL3+UhAh3duCOY=;
        b=nXtcXMG5ASHrJRiJgEvAtWJFteECePCqfTu0LUpGfWbOaVD2tHAWiWD+mL+utS+bhn
         zVJielxIp2Ori2ED5VE6MXF6hki05UF47NI7oc9hUXdvU3GeLPWxItUF8QLRIS6PZoXO
         JXSeR+bPWMYE+Ulb3y0eEwq7Se/UbXqF5fuio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=ZtOH+eYBtqH44LXGuQgIV3UVpIH09kL3+UhAh3duCOY=;
        b=eITbIP0oQaPE6Hx0zI2/je3/vIOeVnqFZw57XOrfNVd2SIIFgHwiQkR/h2lDfbrsAX
         EjbWhvENArQtLA2E/0P7zLXoiINqicx8YV2rlJHtfdiKKsfqWqLw26pHklMwMHXphyl1
         qKAgUiftDzpTZQQggmWx/OqFHP3BWtbSe7KrDCFR0z30vrQdc4lZuuvpOMJ1+EwhuJGS
         7F2t6dtGkaHt4ZaeTDvIvQltazEE6ITa09E8u8ZYACNj58PkUjAMxA8JynnQ7CVjR8zy
         VCPe1vk88wpIpBbFtt9yXOP6Y+Vs6D748gCtAS82ufny6fo5UD2VqBIpKprk97IobZ2l
         3hQQ==
X-Gm-Message-State: ALoCoQlblt2htHLZ5Ue9HPxv7mfUt2B0tjf635Xql9lQJ/n71emf0eFR5qjZRma/r1FHGG0zIIg9
X-Received: by 10.43.63.15 with SMTP id xc15mr33490icb.67.1383043446482; Tue,
 29 Oct 2013 03:44:06 -0700 (PDT)
Received: by 10.64.25.165 with HTTP; Tue, 29 Oct 2013 03:44:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236921>

>From 1cbc2c49454581a67cce09ada1386dac4ffa2828 Mon Sep 17 00:00:00 2001
From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Date: Tue, 29 Oct 2013 11:31:10 +0100
Subject: [PATCH] Add option --no-tags

---
 gitk-git/gitk | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5cd00d8..d6f5e07 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -156,7 +156,7 @@ proc unmerged_files {files} {

 proc parseviewargs {n arglist} {
     global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
-    global worddiff git_version
+    global worddiff git_version no_tags

     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -167,6 +167,7 @@ proc parseviewargs {n arglist} {
     set origargs $arglist
     set allknown 1
     set filtered 0
+    set no_tags 0
     set i -1
     foreach arg $arglist {
     incr i
@@ -183,6 +184,9 @@ proc parseviewargs {n arglist} {
         set origargs [lreplace $origargs $i $i]
         incr i -1
         }
+      "--no-tags" {
+        set no_tags 1
+      }
         "-[puabwcrRBMC]" -
         "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
         "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
@@ -6394,13 +6398,16 @@ proc drawtags {id x xt y1} {
     global headbgcolor headfgcolor headoutlinecolor remotebgcolor
     global tagbgcolor tagfgcolor tagoutlinecolor
     global reflinecolor
+    global no_tags

     set marks {}
     set ntags 0
     set nheads 0
     if {[info exists idtags($id)]} {
-    set marks $idtags($id)
-    set ntags [llength $marks]
+      if {$no_tags < 1} {
+        set marks $idtags($id)
+        set ntags [llength $marks]
+      }
     }
     if {[info exists idheads($id)]} {
     set marks [concat $marks $idheads($id)]
--
1.8.4.2
