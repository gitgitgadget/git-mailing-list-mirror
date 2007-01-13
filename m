From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sat, 13 Jan 2007 16:42:15 +0000
Message-ID: <200701131642.16824.andyparkins@gmail.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 13 17:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5m0K-0004Ou-U0
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbXAMQpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbXAMQpI
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:45:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:33731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422711AbXAMQpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 11:45:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1021210uga
        for <git@vger.kernel.org>; Sat, 13 Jan 2007 08:45:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iuDYlIobICymK6ad+LFLw1Vb2on3HobaaN6uVEUvYiiaMu+y6ft/OatJLZkeutXg3PFmoWOg68sqsvWdDR6IIicAN7SNvybkfOHqptO7Gq8ZrTgGfnj+vNPi4f/zU+/kBulvpu0V6383DVZpR5y/t1wTvBbsqmYJ6i5F2lSsZpk=
Received: by 10.78.118.19 with SMTP id q19mr1243675huc.1168706704939;
        Sat, 13 Jan 2007 08:45:04 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 33sm2480308hue.2007.01.13.08.45.01;
        Sat, 13 Jan 2007 08:45:01 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36758>

On Friday 2007, January 12 20:56, Junio C Hamano wrote:

> This may not actually be what we want to do.  These commands are
> inherently whole-tree operations, and an inexperienced user may
> mistakenly expect a "git pull" from a subdirectory would merge
> only the subdirectory the command started from.

You're right it might be confusing at first, however, I still think it's the 
right thing to do.

Here's my reasoning: for a while, with subversion as a user you feel all warm 
inside that commands only work on the current subdirectory, so "svn update" 
would only update the current subdirectory to the latest revision.  Of course 
as git users we all see the horrendous potential errors that behaviour can 
induce.  It creates subdirectories with mixed versions from the repository - 
absolute disaster pends.

Git is of course far more sensible, if you checkout in a subdirectory the 
whole working directory changes, meaning everything is always nicely in sync 
and really does represent a snapshot at any time.

Now; once you (as a new user) accept that git checkout should (and does) 
checkout the whole working directory regardless of where you are, then by 
extension every other working-directory-wide command should do the same.

Phew.  I'm too noisy.  What a verbose way of saying
   fromAOL("me too");


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
