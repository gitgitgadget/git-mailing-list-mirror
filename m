From: Kevin <ikke@ikke.info>
Subject: Error in documentation for @{-n} in gitrevisions
Date: Sat, 11 Jan 2014 18:34:21 +0100
Message-ID: <CAO54GHBRbVQWDjE70tEZY=nP==gtrqVvmx1JWYNkc_HOeDnYDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 11 18:34:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W22SQ-0006Zv-0j
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 18:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbaAKRen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jan 2014 12:34:43 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:62630 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbaAKRel convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jan 2014 12:34:41 -0500
Received: by mail-ig0-f174.google.com with SMTP id hk11so2004147igb.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2014 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BLKNWVYR+A64DrN/R8Y2lMzQeIc1XAoBZwp+ciTGzPY=;
        b=fOZ5/jS1dJhuhhEFiFUKHRsYCR7FTMIyzp6cLP5qr7jE1TnOjimc5T/Mm/2M3Dw82K
         F4fhGOVLPZ7lXzkHd+Q1yltrZNeWSmi/hGBsPXTdWtHPV6sApvvCeQ9ST9a4Dep8avFH
         2m6O39gFcc8XzRHhbKyM0gpEv/lnGaeNOASjOupCI4/zA0MLzYMQ1h4clO0HtOBL5aAG
         m2IgURmu9ugBNQ5xSrn2I8N026CskzxQNv/zdaScCJKIMrbyc5DibImGAEa3bawjZJdW
         q/+SdG5LQNVKA1UZbxYkDoopGhJ5gylo+J2PbMztI1zQ/AKtK8sw10/pwEVgRLkrmC4p
         kTgw==
X-Received: by 10.50.66.180 with SMTP id g20mr10329597igt.29.1389461681203;
 Sat, 11 Jan 2014 09:34:41 -0800 (PST)
Received: by 10.64.7.207 with HTTP; Sat, 11 Jan 2014 09:34:21 -0800 (PST)
X-Google-Sender-Auth: DjWOGvO6t4cmjDOE_hREuWf38Js
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240333>

While discussing the behavior of "git checkout -", I apparently was
confused because the documentation states:

  The construct @{-<n>} means the <n>th branch checked out before the
current one.

But experimenting with it, it also takes you back to previously
checkout commits.

  git-checkout-at-minus-one :: (master) =C2=BB git checkout origin/mast=
er
  Note: checking out 'origin/master'.
  HEAD is now at f8b2f0c... two

  git-checkout-at-minus-one :: (f8b2f0c) =C2=BB git checkout -
  Switched to branch 'master'

  git-checkout-at-minus-one :: (master) =C2=BB git checkout -
                                              Note: checking out
'f8b2f0c1419d1fe798159c2c2578d2dbe1323148'.
  HEAD is now at f8b2f0c... two

Either the documentation is wrong, and should be changed to "<n>th
branch/commit checkout out before the current one", or the behavior of
@{-1} is wrong.
