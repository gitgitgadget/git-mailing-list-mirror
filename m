From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 0/9] port tag.c to use ref-filter library
Date: Thu, 25 Jun 2015 15:25:41 +0530
Message-ID: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 11:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z83tN-0003aI-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 11:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbbFYJ4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 05:56:16 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33617 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbFYJ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 05:56:11 -0400
Received: by obpn3 with SMTP id n3so43841647obp.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=SzbNMbxe0VzWdlusr//v100kK7fndet4CpH4bIdiunw=;
        b=WND+dT5xtAVTQw/l9MKdrc2hnM0Dhi9rC2/Mu5GaPzOJJ4rAa/nCYgk/HnkWXg/T66
         lONK9GuiFI5dARlciGXaNy+Luljm9N9iNY6DOrhh4eRq+a937cCrJXx5DRoljLPJQw+A
         nzU68RHM6fpm64/m87j5Hwh3hTYOsDeSTC8MhgyGOw/C4lhHXCH36XztL613UVPWucsL
         27FFdVnNuqAX9iEOjKoTXXrg3TzcJTfM/X7Mi+Phxw0TlaexP+OqOfg+92bgtfJowFPL
         3z45xp+wwlEtv5OJGAGIamJlB069iyrt4INMqJvkynUDpwmqyPstHhrqHAONVUuJFhK3
         bq2w==
X-Received: by 10.60.52.174 with SMTP id u14mr39617605oeo.9.1435226170579;
 Thu, 25 Jun 2015 02:56:10 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 25 Jun 2015 02:55:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272654>

This is part of the GSoC project to unify the commands `git tag -l`,
`git branch -l`
and `git for-each-ref`.

This is a follow up to
http://article.gmane.org/gmane.comp.version-control.git/272641 which
is still in the 6th iteration.

This ports over tag.c to use ref-filter APIs and adds --format,
--sort, --merged and --no-merged options to the same.

 Documentation/git-tag.txt |  39 ++++++++++---
 builtin/for-each-ref.c    |   3 +-
 builtin/tag.c             | 362
++++++++++++++++++++------------------------------------------------------------------------------------------------
 ref-filter.c              | 100 ++++++++++++++++++++++++++++----
 ref-filter.h              |   7 ++-
 t/t7004-tag.sh            |  51 ++++++++++++++---
 6 files changed, 233 insertions(+), 329 deletions(-)

-- 
Regards,
Karthik Nayak
