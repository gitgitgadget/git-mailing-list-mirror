From: "John Rigby" <jcrigby@gmail.com>
Subject: Problems with branches
Date: Fri, 26 Jan 2007 16:51:07 -0700
Message-ID: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 00:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAaqf-0001ZU-71
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXAZXvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXAZXvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:51:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:42943 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXAZXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:51:08 -0500
Received: by nz-out-0506.google.com with SMTP id s1so818662nze
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 15:51:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FkDUFoHgwI9WdhtARRU76uZIDF6C06NqEq8gFpllLQ5HoFvIZLJx6imB7mjiN0r6BQ+7DDw3jYOV8P0KV//GXjEB+v+K3eRgAWTu0HLl22xr/qxpB+SB5efALBmLpHIkaLt2sQTsl5JJaLrz9W1Uiot0tIKbXIld+lD4sO198qI=
Received: by 10.114.204.3 with SMTP id b3mr104539wag.1169855467262;
        Fri, 26 Jan 2007 15:51:07 -0800 (PST)
Received: by 10.114.156.18 with HTTP; Fri, 26 Jan 2007 15:51:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37904>

I'm having trouble doing something so simple that it is in the
tutorial but for some reason it does not work for me.
The following script does basically the same thing that is
outlined in the "Managing branches" section of the tutorial.

mkdir foodir
cd foodir/
git-init-db
echo bar > bar
git-add bar
git-commit -m "Initial bar"
git-branch mybranch
git-branch
git-checkout mybranch
echo bar2 >> bar
git-commit -a -m "Added line bar2 to bar in mybranch"
git-checkout master
cat bar
echo bar3 >> bar
git-commit -a -m "Added line bar3 to bar in master"
git-commit -a
git-diff master mybranch
git-merge mybranch

Here is the output, everything seems fine until the git-merge
which complains "fatal: Needed a single revision":

+ mkdir foodir
+ cd foodir/
+ git-init-db
defaulting to local storage area
+ echo bar
+ git-add bar
+ git-commit -m 'Initial bar'
Committing initial tree ee314a31b622b027c10981acaed7903a3607dbd4
+ git-branch mybranch
+ git-branch
* master
  mybranch
+ git-checkout mybranch
+ echo bar2
+ git-commit -a -m 'Added line bar2 to bar in mybranch'
+ git-checkout master
+ cat bar
bar
+ echo bar3
+ git-commit -a -m 'Added line bar3 to bar in master'
+ git-commit -a
nothing to commit
+ git-diff master mybranch
diff --git a/bar b/bar
index 77914eb..46ffc55 100644
--- a/bar
+++ b/bar
@@ -1,2 +1,2 @@
 bar
-bar3
+bar2
+ git-merge mybranch
fatal: Needed a single revision
Usage: /home/jrigby/bin/git-merge [-n] [--no-commit] [--squash] [-s
<strategy>]... <merge-message> <head> <remote>+

Could some kind soul help me pull my head out?

Thanks
John
