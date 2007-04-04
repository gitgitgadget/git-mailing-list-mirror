From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Partitioned packs
Date: Tue, 3 Apr 2007 18:16:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704031813100.21680@qynat.qvtvafvgr.pbz>
References: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 03:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYuYq-0004UD-Ar
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 03:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966263AbXDDBpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 21:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966262AbXDDBpP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 21:45:15 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:39360 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S966263AbXDDBpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 21:45:14 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 3 Apr 2007 18:45:14 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 03 Apr 2007 18:44:33 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43702>

On Tue, 3 Apr 2007, Chris Lee wrote:

> Date: Tue, 3 Apr 2007 18:36:44 -0700
> From: Chris Lee <clee@kde.org>
> To: git@vger.kernel.org
> Subject: Partitioned packs
> 
> I've been running some experiments, as hinted earlier by the
> discussion about just how much git-index-pack sucks (which, really,
> isn't much since the gaping memleak is gone now).
>
> These experiments include trying to see if there's a noticeable
> performance improvement by splitting out objects of different types
> into different packs. So far, it definitely seems to make a
> difference, though not the one I was initially expecting. For all of
> these tests, I did 'sysctl -w vm.drop_caches=3' before running, to
> effectively simulate a cold-cache run.

I wonder what order the packs ended up in. if git had to go through the wrong 
pack completely first before finding the pack that it needed, that coudl account 
for extra time.

is it worth makeing up single packs that order the three different types of 
object differently within the one pack to see what difference it makes to have 
to walk past all the blobs to get to the commits and trees?

David Lang
