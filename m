From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 37/38] pack v4: introduce "escape hatches" in the name and
 path indexes
Date: Thu, 05 Sep 2013 17:48:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051744490.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-38-git-send-email-nico@fluxnic.net>
 <alpine.LFD.2.03.1309051445140.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 23:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHhPq-0005Pq-86
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab3IEVse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 17:48:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9145 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3IEVsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 17:48:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSO004NW9WXYM50@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 17:48:33 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 0267A2DA0547; Thu, 05 Sep 2013 17:48:33 -0400 (EDT)
In-reply-to: <alpine.LFD.2.03.1309051445140.14472@syhkavp.arg>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233995>

On Thu, 5 Sep 2013, Nicolas Pitre wrote:

> On Thu, 5 Sep 2013, Nicolas Pitre wrote:
> 
> > If the path or name index is zero, this means the entry data is to be
> > found inline rather than being located in the dictionary table. This is
> > there to allow easy completion of thin packs without having to add new
> > table entries which would have required a full rewrite of the pack data.
> > 
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> 
> I'm now dropping this patch.  Please also remove this from your 
> documentation patch.

Well... I couldn't resist another little change that has been nagging me 
for a while.

Both the author and committer time stamps are very closely related most 
of the time.  So the committer time stamp is now encoded as a difference 
against the author time stamp with the LSB indicating a negative 
difference.

On git.git this saves 0.3% on the pack size.  Not much, but still 
impressive for only a time stamp.


Nicolas
