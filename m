From: Nicolas Pitre <nico@cam.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 16:14:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702141603440.1757@xanadu.home>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
 <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
 <17875.30187.289679.417079@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRSh-0006T9-2O
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbXBNVOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXBNVOn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:14:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11895 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbXBNVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:14:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDH00BPK1OGPI00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Feb 2007 16:14:41 -0500 (EST)
In-reply-to: <17875.30187.289679.417079@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39749>

On Wed, 14 Feb 2007, Bill Lear wrote:

> So (hopefully this is helpful) I look in my public repo for this pack
> file:
> 
> % ls -l /repos/git/fus/objects/pack
> total 88420
> -r--r--r--  1 blear software    10376 Feb 14 10:06 pack-1a201381fe465cbf4d771aec681aff6e12648ea0.idx
> -r--r--r--  1 blear software   753437 Feb 14 10:06 pack-1a201381fe465cbf4d771aec681aff6e12648ea0.pack
> -r--r--r--  1 blear software    77360 Feb 13 10:57 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
> -r--r--r--  1 blear software 89576130 Feb 13 10:57 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> 
> and notice, it is different than the same pack on my just-cloned repo
> (that is, the second clone, that I used to reproduce the first
> failure):
> 
> % ls -l objects/pack/
> total 87632
> -r--r--r--  1 blear software    77360 Feb 14 12:50 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
> -r--r--r--  1 blear software 89548154 Feb 14 12:52 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> 
> and in my first-cloned repo:
> 
> % ls -l objects/pack/
> total 85992
> -r--r--r--  1 blear software    77360 Feb 13 10:18 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.idx
> -r--r--r--  1 blear software 87874337 Feb 14 10:00 pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> 
> The .pack files have the same SHA, but different sizes (don't know
> what that means).

The name of the pack corresponds to the list of objects it contains.  
The way those objects are packed can change the size and the raw content 
of the pack file, but they still should contain the equivalent data.  So 
this size difference is not a sign of problem.


Nicolas
