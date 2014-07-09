From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Error running 'git status' with Git version of current 'next' branch
Date: Wed, 9 Jul 2014 09:10:49 +0200
Message-ID: <CAN0XMOKmbQ_adDjUH3+o-RRm0pcQpH=fH9zDTe4=+b_aU_0GoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:10:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4m1n-000569-Kj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaGIHKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 03:10:51 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:54562 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaGIHKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:10:50 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so2145797wiv.15
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4GAf4xFc3CBNQnXOcqy0VUG3QK19Ita+i5uM4XPMZVw=;
        b=o71pOutw2lnlsg9PLZOXEyPUqraATfFSrK4WZmD/E8eMtxzo96mE+31Gxqd05e/iIk
         YYcpvsifkdDYAvRyW2UKa2epcyj85bj0nkJAkm5/S3hyY5h0YGVjpkXYfflG1f70QzhQ
         ypO9zhGoxOr7lGYdQ+/dKxI0jSlDL6fXLB4hXPHsKHgsJbhiv2SgQMvZhYKRXoU7qJqE
         RwZ6lV7/F7uWlQpv4XJgBogesSZoRSEhF4Zd6kIO+UlXJHPjmUVShSxLlt10DtsJ5fhD
         bnfKt4hKx9Pd+ZYhnBi0PGHqQEmRyAzEncYzvj28GiGC1eFSSupVKs+peo+eczUVDzQd
         XZVg==
X-Received: by 10.180.79.38 with SMTP id g6mr9120797wix.61.1404889849084; Wed,
 09 Jul 2014 00:10:49 -0700 (PDT)
Received: by 10.194.203.199 with HTTP; Wed, 9 Jul 2014 00:10:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253073>

Hi,

I'm getting the following error when calling 'git status' on one of
my projects.

git: dir.c:739: last_exclude_matching_from_list: Assertion `x->baselen
== 0 || x->base[x->baselen - 1] == '/'' failed.
Aborted (core dumped)

I'm using the current 'next', git version 2.0.1.664.g35b839c
I have bisected it to commit d3ccb7d (dir: remove PATH_MAX limitation).

Here's a simple script to reproduce it:

mkdir tmp
cd tmp
git init
mkdir -p foo/foooooooooo-bar/foooobar/foo/bar/foo/foobar/foooooooo/baaaaaar/fooooo
echo /foo >foo/.gitignore
git status

Ralf
