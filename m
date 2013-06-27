From: John Szakmeister <john@szakmeister.net>
Subject: Bug on OS X...
Date: Thu, 27 Jun 2013 06:17:52 -0400
Message-ID: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 12:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us9H4-0001Jp-25
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 12:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799Ab3F0KRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 06:17:54 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48803 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3F0KRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 06:17:53 -0400
Received: by mail-qa0-f42.google.com with SMTP id hu16so2337638qab.15
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=huuKiq0DqpuQF489DT5sJ3UoGUmNUgUZqbrnUBvbV4Q=;
        b=fdkGe7sNKHlGVFI3xOxX1C1WCqMMEGKYPGnUAoShyCm+0CwRtICilQ76KuRspyr4rT
         NFetoZl/HgrIYt5taSdQK/2bKLmJTj8XCjegsXx/QQvGy9SU91pY2/7L5PTj4SRK8PyA
         2UXn5ylE9296BbSMfX1cN11b1w8glcRLHSlCV0p3qnx3M4ChgA//6F84QyrBG32Ukrrs
         BVKGXIEb2c+rjZoUODYoZSbL1TyaO4x+bRODn2jtrdo7+Ey1xCpObIB9uPN3b6/VlOQN
         GLcYJ6RYHpVzxM45/TV1fWYtDrgUVoJD1CHqrHZKS3T5k/IBWQf5lVhRtWWsRJHYdSTA
         Rkbw==
X-Received: by 10.49.12.11 with SMTP id u11mr9937875qeb.21.1372328272427; Thu,
 27 Jun 2013 03:17:52 -0700 (PDT)
Received: by 10.49.116.205 with HTTP; Thu, 27 Jun 2013 03:17:52 -0700 (PDT)
X-Google-Sender-Auth: QJpw7SX_14u3PdbSep7DsnzCI48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229093>

I wanted to look at some OpenWRT bits this morning and ran into an
issue cloning the packages repository when setting up the package
feed.  The feeds script executes this under the hood:

   git clone --depth 1 git://nbd.name/packages.git feeds/packages

When trying to run the command directly on OS X, I see:
   :: git clone --depth 1 git://nbd.name/packages.git
   Cloning into 'packages'...
   remote: Counting objects: 4728, done.
   remote: Compressing objects: 100% (4013/4013), done.
   remote: Total 4728 (delta 158), reused 3339 (delta 94)
   Receiving objects: 100% (4728/4728), 3.85 MiB | 1.79 MiB/s, done.
   Resolving deltas: 100% (158/158), done.
   error: unable to find 9f041557a0c81f696280bb934731786e3d009b36
   fatal: object of unexpected type
   fatal: index-pack failed

I tried on Linux, and it succeeded.  I tested with both 1.8.2 and
1.8.3.1.  Unfortunately, I don't have time to dig through what's wrong
at the moment so I thought I'd put it out there for others.

Thanks!

-John
