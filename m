From: Luke Diamand <luke@diamand.org>
Subject: git-p4, RCS keywords
Date: Tue, 12 Jul 2011 07:50:36 +0100
Message-ID: <4E1BEEBC.8060909@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWnt-00013h-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab1GLGul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:50:41 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42310 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1GLGuk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:50:40 -0400
Received: by wwg11 with SMTP id 11so2814122wwg.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 23:50:39 -0700 (PDT)
Received: by 10.217.1.197 with SMTP id n47mr3811101wes.28.1310453439336;
        Mon, 11 Jul 2011 23:50:39 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id n17sm5959946wed.40.2011.07.11.23.50.37
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 23:50:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176934>

A bit of an ancient topic now, I'm afraid, but back in May I was 
attempting to find a way to get git-p4 to cope with RCS keyword 
expansion causing merge conflicts.

http://marc.info/?l=git&m=130492741320889&w=2

I've given up trying to make this work.

I had thought that I had a scheme that could plausibly work. git-p4 
detects when a merge would fail. At this point, look for RCS keywords in 
the file, and strip them out. For an edit that's easy, for a deletion 
it's a bit trickier.

I then discovered that the third way RCS keywords can cause grief is if 
a user copies a file containing expanded RCS keywords into their git 
repo. My scheme then gave some very weird results!

Maybe this is now the complete list of ways in which RCS keywords can 
mess you up, but I'm not sure. We've got ~9.5k files in our repo with 
RCS keywords. I think it's easier and safer just to go through and turn 
off ktext everywhere. I've actually only seen two or three merge 
conflicts caused by this problem in this time (not sure how many commits 
that is, but it must be in the hundreds).

I'm not saying it's not possible, just that my approach isn't going to work.

Who invented RCS keyword expansion anyway? They need a good talking to!

Luke
