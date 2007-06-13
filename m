From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 20:34:28 +0100
Message-ID: <200706132034.29934.andyparkins@gmail.com>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: David Watson <dwatson@mimvista.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyYcN-0007KB-Sk
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 21:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXFMTed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbXFMTed
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 15:34:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:41832 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXFMTec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 15:34:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so491557ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 12:34:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q4uNzT5ayFx3ZbiouEnJFsllOFmaR+T5OeOtCVa4OUJVuRCpVccwnqDZlsa42MFaq8QFCbhZK5Qa/Bh/0VIR2EawrTlWn+WqIS+iLciLMov7WsQ0pdGKLCaYXpZiuxBYtVineB5AY593bOgew1Mnsmx1KJcxgdjS5OdvX5+SPe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sXAfYJOw856DkgMYtstkQTRc9psNppJnFuXjnjoSdwN8nEDLIpWqsCaVGrB4ZriKp1aDuk7lIyCJZ/fdHc3IKw6rY/tvlcDNnSLjoKVp0gWHf5Xl/Ub9v36N+g1Ychlw+a9RHHyKQIu2ZO1/hQNHgrnExwfkbbR51+N6R3O1QFY=
Received: by 10.82.156.12 with SMTP id d12mr1764841bue.1181763270648;
        Wed, 13 Jun 2007 12:34:30 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id d23sm1130692nfh.2007.06.13.12.34.29
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 12:34:30 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50120>

On Wednesday 2007, June 13, David Watson wrote:
> I've got a problem, or maybe annoyance is more the proper term, that
> I haven't seen solved by any SCM system (at least not to my
> knowledge). Basically, I may make some changes, e.g. to a Makefile or
> somesuch, that I want to ignore when looking at what's changed from

So you want to tell git to track a file and then have it not track 
changes to that file?  Sounds crazy to me.  Don't put files in the 
repository that you don't want tracking.

What you want is an out-of-tree file for that sort of thing.  Why can't 
you just do

#!/usr/bin/make
-include Makefile.local

Rather than messing around with not tracking tracked files?

git does exactly that in it's own build process with a config.mak file, 
which lets you specify, say, an install directory that is obviously 
only valid for you.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
