From: larsxschneider@gmail.com
Subject: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Wed, 13 Apr 2016 07:49:31 +0200
Message-ID: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
Cc: mhagger@alum.mit.edu, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 07:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqDgT-0000s7-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 07:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbcDMFtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 01:49:45 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36775 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964813AbcDMFto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 01:49:44 -0400
Received: by mail-wm0-f48.google.com with SMTP id v188so154280959wme.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SsHWXcZuDXXmYJrm1A8GryRTwH6Pv2q5rVt0L40bUrU=;
        b=rXHPyGJ2gMyyOoxH4vxoJGHNf/ShBmUf+HuHLhj/ofisswjFvcWEjusJoZeLeKqUdm
         TG7+NOsLAo5t8xN1ZEaLl46vS6ovYBqZnFRIU/MvAko17Fe9P1j+oQ0ORJiPuiVy5Hvh
         OuIMHnQ96sGr7ybcxVKmz6bkAwrAiMMM9U4RF4mNO/LCz8Z+QhJzNMnEgqPNLHa4t8GH
         UuAMbG5IgF/nVELho/EXcHWLRAWkYae13YI/Bq2TuqC6xDjjN2HN9sptuh2I4FRxakWp
         srzH8otaRuQBfWXGuz0Fc/ymOGkNCG3Yb2NYJLC8dkwT4lQVgp1Ox3nQH3trOG+qrbL4
         TXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SsHWXcZuDXXmYJrm1A8GryRTwH6Pv2q5rVt0L40bUrU=;
        b=RQ0y4wkwUwC1IUCrZHkaSBjUwtAh6C4tIWYGbOI3KpoeVlXLYXjOPtsxTU915S0y2c
         raTFKMHVPEGUx7R2wwPwlvpNqZgp0LwmqH2hRisko6f3qtHha9lS6gE5GlYCNPjn9wfB
         NNPaFEWQIFlTO1xoqT5T3dl1nHN6aLTEcqUAClCmJPNcibpNFV9JCbJr4AtfK0h9uC+o
         1kBorZcmJVroIXHOMuALYJqMZZZHhwa4v7Lz1FC96KH/pQ8PGDuD5si28kCAGqHOTSDv
         LH8DAAdEjVE9Xau8U1nMkVl/2qGLn4W/aZB9kgt9fEw2+MJZgVsDmf9TgowI8vFsvAjw
         TbqQ==
X-Gm-Message-State: AD7BkJLmjwRbS8FNB3BFIVqqKCf7tPq2FUG4UxaVYuCbtHZxI4RzTDqpRR4uUpGHKKrGOQ==
X-Received: by 10.28.104.131 with SMTP id d125mr27171061wmc.99.1460526583216;
        Tue, 12 Apr 2016 22:49:43 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA361.dip0.t-ipconnect.de. [80.139.163.97])
        by smtp.gmail.com with ESMTPSA id w202sm26094657wmw.18.2016.04.12.22.49.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 22:49:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291371>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/SubmittingPatches | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 98fc4cc..79e9b33 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -63,10 +63,43 @@ t/README for guidance.
 When adding a new feature, make sure that you have new tests to show
 the feature triggers the new behaviour when it should, and to show the
 feature does not trigger when it shouldn't.  Also make sure that the
-test suite passes after your commit.  Do not forget to update the
-documentation to describe the updated behaviour.
+test suite passes after your commit.
 
-Speaking of the documentation, it is currently a liberal mixture of US
+We recommend to use our CI infrastructure to ensure your new feature
+passes all existing tests as well as your new tests on Linux, Mac, and
+(hopefully soon) Windows.  Follow these steps for the initial setup:
+
+ (1) Sign in to GitHub: https://github.com
+     Please sign up first if you haven't already, it's free.
+
+ (2) Fork https://github.com/git/git to your GitHub account
+     Details: https://help.github.com/articles/fork-a-repo/
+
+ (3) Go to Travis CI: https://travis-ci.org
+
+ (4) Press the "Sign in with GitHub" button
+
+ (5) Grant Travis CI permissions to access your GitHub account
+     Details: https://docs.travis-ci.com/user/github-oauth-scopes
+
+ (6) Go to your Travis CI profile page: https://travis-ci.org/profile
+
+ (7) Enable Travis CI builds for your Git fork
+
+After the initial setup you can push your new feature branches to your
+Git fork on GitHub and check if they pass all tests here:
+https://travis-ci.org/<Your GitHub handle>/git/branches
+
+If they don't pass then they are marked "red". If that happens then
+click on the failing Travis CI job and scroll all the way down in the
+log. Find the line "<-- Click here to see detailed test output!" and
+click on the triangle next to the log line number to expand the detailed
+test output (example: https://travis-ci.org/git/git/jobs/122676187).
+Fix the problem and push an updated commit to your branch to ensure
+all tests pass.
+
+Do not forget to update the documentation to describe the updated
+behaviour of your new feature. It is currently a liberal mixture of US
 and UK English norms for spelling and grammar, which is somewhat
 unfortunate.  A huge patch that touches the files all over the place
 only to correct the inconsistency is not welcome, though.  Potential
-- 
2.5.1
