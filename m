From: Daniele Segato <daniele.segato@gmail.com>
Subject: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Thu, 25 Jul 2013 15:45:10 +0200
Message-ID: <51F12BE6.80606@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 15:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Lr7-0005UR-0C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 15:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab3GYNpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 09:45:17 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37814 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab3GYNpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 09:45:15 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so1640819wgh.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=F9mJmJT8beQ9wx+TtIRhoykImI7YdQJe9MBAgjgYZRw=;
        b=DWE0Sm1iga5rUjU1W7mh7LlDk/0tHbqbW96tL/5KLobDRETfsa0RJh6QqQ3o39pNQ4
         Risgf8WC80ZgycVN/Rdmo265bTZinyfOKRgCjw7XsXfEJcRcwUXQi4P8HOcrbIxBD/Vo
         BEcaU6hyj+xkQH/qxJaTfllIZCfa4f8Osm2LpGPLszT1qwpbHWVoi74+ALmfAPvT6jsE
         tLeWqakL327dhkBQwnNrU2KoGw7DBJA4pgvykwEb3/FMxuQ2ZUiCmTDWkCGIzOvyr1kY
         8f9bzDUjYIMjmkK9oKtj/XtxAnQ1fjcd/wXOenDie2avtlV2nZy+NQr6WrdS6C8mMzSw
         N43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=F9mJmJT8beQ9wx+TtIRhoykImI7YdQJe9MBAgjgYZRw=;
        b=GDKEW59YALn5pyfR8/UhDg5/g64PymI3lYJbIzclbzS3VX5wFK5i97KbjC5DJqY1HM
         K4gHrh8kEbl4bNWOtDBLYy5vQ2FGrcM9XOnyRlFbf9kn9scs3Jt7RQ9ccPxZoSBrYptg
         oc83ydYaBAr0cVtpVPYECyXny3nhO6bsfG+ccpq4Uc8/s3nQ53+BEEzEHEF3EUPq2iIe
         PFgOJjpKjUrhNmGcj+SDXpBXbn3HjJqIoqEtGa6rwUSvdxZNmL7doncVwt/TLPocB7pZ
         WmRpBxAhYPUsJBNHD9ZFV5zsFRxeTOmwUNBqdM61MnODgXf0gXXwbuYs4sEAK+3+dHuf
         Kyzg==
X-Received: by 10.180.38.37 with SMTP id d5mr2171455wik.37.1374759914052;
        Thu, 25 Jul 2013 06:45:14 -0700 (PDT)
Received: from [192.168.88.89] (2-229-44-241.ip195.fastwebnet.it. [2.229.44.241])
        by mx.google.com with ESMTPSA id s19sm3849768wik.11.2013.07.25.06.45.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 06:45:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231134>

 From d0f4eca712e7cf74286bfab306763a8a571b6c95 Mon Sep 17 00:00:00 2001
From: Daniele Segato <daniele.segato@gmail.com>
Date: Thu, 25 Jul 2013 15:33:18 +0200
Subject: [PATCH] git-tag man: when to use lightweight or annotated tags

stress the difference between the two with suggestion on when the user
should use one in place of the other.

Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
---
  Documentation/git-tag.txt |    4 ++++
  1 file changed, 4 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 22894cb..48f5504 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -36,6 +36,10 @@ are absent, `-a` is implied.
  Otherwise just a tag reference for the SHA-1 object name of the commit 
object is
  created (i.e. a lightweight tag).

+Annotated and Lightweight tags are not the same thing for git and you 
shouldn't
+mix them up. Annotated tags are meant for release while lightweight 
tags are
+meant to tag random commits.
+
  A GnuPG signed tag object will be created when `-s` or `-u
  <key-id>` is used.  When `-u <key-id>` is not used, the
  committer identity for the current user is used to find the
-- 
1.7.10.4
