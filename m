From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Wed, 19 Dec 2007 19:09:14 +0100
Message-ID: <20071219180914.GB3015@steel.home>
References: <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com> <20071218222032.GH2875@steel.home> <Pine.LNX.4.64.0712182239500.23902@racer.site> <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com> <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org> <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com> <Pine.LNX.4.64.0712191334460.23902@racer.site> <20071219150510.GB13942@coredump.intra.peff.net> <56b7f5510712190940g2a377f4tfe3ca897561ed446@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J53MT-0005yI-QB
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 19:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXLSSJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 13:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbXLSSJS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 13:09:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:35610 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbXLSSJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 13:09:17 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a72E=
Received: from tigra.home (Fc89a.f.strato-dslnet.de [195.4.200.154])
	by post.webmailer.de (klopstock mo44) (RZmta 14.6)
	with ESMTP id j03c89jBJEmtKQ ; Wed, 19 Dec 2007 19:09:14 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5FE80277AE;
	Wed, 19 Dec 2007 19:09:14 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 147C456D22; Wed, 19 Dec 2007 19:09:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56b7f5510712190940g2a377f4tfe3ca897561ed446@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68927>

Dana How, Wed, Dec 19, 2007 18:40:04 +0100:
> If there were additional /./ or /../ patterns in the result,  I think it
> would be more useful (e.g. for script writers who forgot to run
> their file arguments thru something like "readlink -f") for them
> to be squashed out (e.g. in Perl:
>   s#/(\./)+#/#g;
>   s#/([^/]*[^./][^/]*/\.\./)+#/#g;
> ).  But this is something that could be added later if desired to
> the interpretation of all paths,  and so seems like a different issue.

This is what the pathexpand in pathexpand-patch does.
