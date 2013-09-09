From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table
 size
Date: Mon, 09 Sep 2013 15:56:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091553540.20709@syhkavp.arg>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
 <xmqq61u94zew.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1309091441540.20709@syhkavp.arg>
 <xmqqwqmp3jtj.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1309091507290.20709@syhkavp.arg>
 <xmqqob813i9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7ZS-0002yr-HK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab3IIT4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:56:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21531 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab3IIT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:56:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV007RYJDXXT50@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 15:56:21 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id CCE922DA0625; Mon, 09 Sep 2013 15:56:20 -0400 (EDT)
In-reply-to: <xmqqob813i9c.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234367>

On Mon, 9 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Do we know the actual number of objects to send during the capability 
> > negociation?
> 
> No, and that is not what I meant.  We know upfront after capability
> negotiation (by seeing a request to give them a thin-pack) that we
> will send, in addition to the usual packfile, the prefix that
> carries that information and that is the important part.  That lets
> the receiver decide whether to _expect_ to see the prefix or no
> prefix.  Without such, there needs some clue in the prefix part
> itself if there are prefixes that carry information computed after
> capability negotiation finished (i.e. after "object enumeration").

In this case, if negociation concludes on "thin" and "pack-version=4" 
then that could mean there is a prefix to be expected.


Nicolas
