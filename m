From: david@lang.hm
Subject: workflow and repository orginization for tracking router configs
Date: Wed, 13 Jan 2010 10:26:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1001131013430.4866@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 19:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV7v0-0007BZ-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 19:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab0AMS0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 13:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756275Ab0AMS0E
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 13:26:04 -0500
Received: from mail.lang.hm ([64.81.33.126]:56817 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0AMS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 13:26:03 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o0DIQ1ZG020153
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 10:26:01 -0800
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136852>

I need to track router/firewall configs for several hundred to a few 
thousand devices.

For each device the config is a single file.

Each device is updated independantly of the others.

The configs diff well not only against prior versions but against each 
other.

The different devices are accessable (in many cases via serial ports) from 
different boxes (in different datacenters in many cases)

I need to data to be replicated across many locations

I want to be able to easily/quickly track changes to a particular device, 
and compare different devices against each other.


I am thinking that a DVCS like git may be a good fit for this situation. I 
can do commits on the boxes that can directly access the devices, and then 
do fetches/pulls between boxes to make sure that every box has the full 
history of every device.

The question is, what is the best way to orginize this data.

One approach is to have a seperate branch for each device.

   This has the advantage that each branch can have a new config committed 
independantly of the others, making pulls/fetches trivial

Another approach is to have one branch with a different file for each 
device.

   This is easy for people to understand, but it seems to me that it would 
make pulling from different boxes that updated different files an issue, 
as well as adding confustion over which commit is related to which device.


Any thoughts or suggestions on what people think would work well? (both 
from a usability and from an efficiancy point of view)


David Lang
