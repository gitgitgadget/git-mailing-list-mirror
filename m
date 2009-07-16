From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 09:48:02 +0300
Message-ID: <20090716064802.GG5256@nokia.com>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
 <4A5EA598.5050801@garzik.org>
 <7v3a8xb0lz.fsf@alter.siamese.dyndns.org>
 <4A5ECC09.3010405@garzik.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: ext Jeff Garzik <jeff@garzik.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752796AbZGPGtv@vger.kernel.org Thu Jul 16 08:50:28 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752796AbZGPGtv@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKnR-0000I8-W9
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 08:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZGPGtv (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 02:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZGPGtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 02:49:51 -0400
Received: from smtp.nokia.com ([192.100.122.230]:18976 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbZGPGtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 02:49:50 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n6G6lrgQ013160;
	Thu, 16 Jul 2009 09:48:29 +0300
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 09:48:14 +0300
Received: from mgw-da01.ext.nokia.com ([147.243.128.24]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 09:48:05 +0300
Received: from nokia.com (esdhcp04340.research.nokia.com [172.21.43.40])
	by mgw-da01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n6G6lvYx018107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 16 Jul 2009 09:47:59 +0300
Content-Disposition: inline
In-Reply-To: <4A5ECC09.3010405@garzik.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Jul 2009 06:48:05.0857 (UTC) FILETIME=[5F538510:01CA05E1]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123369>

On Thu, Jul 16, 2009 at 08:43:21AM +0200, ext Jeff Garzik wrote:
> Junio C Hamano wrote:
> > Jeff Garzik <jeff@garzik.org> writes:
> > 
> >> Is there some sort of guide to the new best practices for handling
> >> trees such as git.kernel.org, where one pushes into "foo.git"
> >> directly, and there is no checked-out source code at all?
> > 
> > I think old repositories will be helped if you add
> > 
> > 	[core]
> >         	bare
> > 
> > to their foo.git/config files.
> 
> Thanks.  What about cloning new repositories?  Real world example:
> 
> Local workstation has /spare/repo/cld/.git repository, with checked-out 
> working tree.
> 
> I want to publish this tree to the world via a *.kernel.org-like system, 
> so my task is to
> 
> 	scp -r /spare/repo/cld/.git remote.example.com:/pub/scm/cld.git
> 
> but if I do this with scp, then future pushes to 
> remote.example.com:/pub/scm/cld.git emit the warning about updating the 
> currently checked-out branch -- even though there are no checked-out 
> files.  The checked-out files were not copied in the scp.

how about you create the bare repository on the kernel.org-like server
and then push cld to it ?

-- 
balbi
