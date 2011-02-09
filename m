From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint-1.7.0 v2 0/2] fast-import: introduce "feature notes"
 command
Date: Wed, 9 Feb 2011 15:46:38 -0600
Message-ID: <20110209214638.GA16716@elie>
References: <20110202045826.GC15285@elie>
 <20110202050735.GE15285@elie>
 <201102022047.55152.trast@student.ethz.ch>
 <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 22:46:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnHsD-0001DG-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 22:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1BIVqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 16:46:48 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44975 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab1BIVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 16:46:47 -0500
Received: by qyj19 with SMTP id 19so1786332qyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yBlcbQiO940MIkaKkKpJu6GqwJEoZHXwQALffoF2zhY=;
        b=MYoY9m0C+FwfM5r+XjBAcT1X7e+0Q9K9Zlc7FRnMySE3hL1XnymFwBWzCpLnYBMwQt
         7IVkAJ4toTpXOQYdu++63L5ylO03U2Q2tcxtSjygFAK1Xk9UTsgv2m1JLKruxy2sBNnD
         POHM2kXFViCQZ0den3NU30WJ3gw4vHUS5PN54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wh5/MZN6ed3tJD4BysaC4L5yyaYxVPRqPGIvaWvZO6CB3hPTGQ1PqU43Kgsqm+bL5w
         JuwO7hvl2nst3z8hJ74nJJuqNiB8/BesevJcGHURGD+rTEHrA5636MDjtBWJvYdjAuF7
         yG79jF1Vpsa1LEhBweAM1aZ/yP8pSsxYIYzp4=
Received: by 10.229.186.7 with SMTP id cq7mr4756667qcb.239.1297288006878;
        Wed, 09 Feb 2011 13:46:46 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id s10sm481812qco.35.2011.02.09.13.46.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 13:46:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166445>

Sverre Rabbelier wrote:

> Perhaps we can submit a patch to maint to have it (the
> oldest git that supports the 'feature' command) recognize 'feature
> notes' though?

Thanks, both.  Here's a series based against v1.7.0.9 to do that
(since 1.7.0.y is the oldest series with support for 'feature'.)

For ease of patching, patch 1 backports a related documentation tweak
from v1.7.4-rc0.  Patch 2 introduces the "feature notes" command
itself.

Jonathan Nieder (2):
  fast-import: clarify documentation of "feature" command
  fast-import: introduce "feature notes" command

 Documentation/git-fast-import.txt |   37 ++++++++++++++++++++-----------------
 fast-import.c                     |    2 ++
 t/t9301-fast-import-notes.sh      |    1 +
 3 files changed, 23 insertions(+), 17 deletions(-)
