From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 10/23] pack v4: tree object encoding
Date: Tue, 27 Aug 2013 12:52:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271250540.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-11-git-send-email-nico@fluxnic.net>
 <xmqqtxibdtpy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMV1-0005Cz-7S
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab3H0QwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:52:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62420 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab3H0QwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:52:05 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700DZ286ST090@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 12:52:04 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 065752DA052D; Tue, 27 Aug 2013 12:52:04 -0400 (EDT)
In-reply-to: <xmqqtxibdtpy.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233115>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > This goes as follows:
> >
> > - Number of tree entries: variable length encoded.
> >
> > Then for each tree entry:
> >
> > - Path component reference: variable length encoded index into the path
> >   string dictionary table which also covers the entry mode.  To make the
> >   overall encoding efficient, the author table is already sorted by usage
> >   frequency so the most used names are first and require the shortest
> >   index encoding.
> 
> s/author table/tree path table/, I think. The reason why it is a
> good idea to sort these tables by use count applies equally to both
> the author table and the tree path table, though.

Exact.  This was a cut and paste mistake.


Nicolas
