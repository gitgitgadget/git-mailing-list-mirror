From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] git-svn: give SVN::Git::Fetcher its own file
Date: Mon, 28 May 2012 01:57:23 -0500
Message-ID: <20120528065723.GC10976@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120528003901.GA11103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 28 08:57:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYttf-0002lM-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 08:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab2E1G5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 02:57:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42943 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2E1G5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 02:57:31 -0400
Received: by ghrr11 with SMTP id r11so1039986ghr.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GenoRVw5by0h4d5CMSmhmStotDXlf0uM+d4AV6Wdr68=;
        b=Y1HD5tpTujYcMvUcC9cl9W2MNp9lWK90VhIC3o+Wj/myZUHBGKyjXn1/ikW69pAEPP
         J35LwiHAR0Af4EKs/tbFq0328bhJFNQhaeSB5iQVS8hdst74k91VIUmA4CDRSqIOltxK
         C95UMXiS2Ga1Yr0oh7XNwUgQZiGeeI9TzK/ThcZD4iEKrGzudMg9IgFLXUu5/xlMOWu1
         I8Kp+1nK2xS1qsgypAs3vjedbNoymg64w4DDD6V4jbZjWcQn7TMkvO8WrTiwNYPNAyg2
         uhW2diqYSO2Yj8nF4eiMvOzA6LeGI1dR7YPDYZKfayRLddjxPLvB3GAqnvWzi4/SrmG1
         xmnA==
Received: by 10.42.123.66 with SMTP id q2mr3615692icr.52.1338188250398;
        Sun, 27 May 2012 23:57:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ut8sm5363921igc.8.2012.05.27.23.57.26
        (version=SSLv3 cipher=OTHER);
        Sun, 27 May 2012 23:57:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120528003901.GA11103@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198629>

Jonathan Nieder wrote:
> Eric Wong wrote:

>> Can we use this as an opportunity to start splitting git-svn.perl into
>> multiple .pm files?
>
> Not a bad idea.  I've included an example patch to sanity-check the
> approach below.
[...]
> Let's start with Git::SVN::Prompt.

And here's a more interesting one: SVN::Git::Fetcher.

Jonathan Nieder (2):
  git-svn: rename SVN::Git::* packages to Git::SVN::*
  git-svn: make Git::SVN::Fetcher a separate file

 git-svn.perl            |  551 ++-----------------------------------------
 perl/Git/SVN/Fetcher.pm |  602 +++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL        |    1 +
 3 files changed, 627 insertions(+), 527 deletions(-)
 create mode 100644 perl/Git/SVN/Fetcher.pm
