From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 10:21:30 +0300
Message-ID: <20090716072130.GH5256@nokia.com>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
 <4A5EA598.5050801@garzik.org>
 <7v3a8xb0lz.fsf@alter.siamese.dyndns.org>
 <4A5ECC09.3010405@garzik.org>
 <20090716064802.GG5256@nokia.com>
 <4A5ED41F.5010502@garzik.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: ext Jeff Garzik <jeff@garzik.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752102AbZGPHX3@vger.kernel.org Thu Jul 16 09:24:09 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752102AbZGPHX3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLK4-0003nS-TX
	for glk-linux-kernel-3@gmane.org; Thu, 16 Jul 2009 09:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZGPHX3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 16 Jul 2009 03:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbZGPHX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jul 2009 03:23:29 -0400
Received: from smtp.nokia.com ([192.100.122.230]:25841 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZGPHX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jul 2009 03:23:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n6G7LVX1026226;
	Thu, 16 Jul 2009 10:22:00 +0300
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 10:22:01 +0300
Received: from mgw-da01.ext.nokia.com ([147.243.128.24]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 10:21:33 +0300
Received: from nokia.com (esdhcp04340.research.nokia.com [172.21.43.40])
	by mgw-da01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n6G7LPKj018279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 16 Jul 2009 10:21:28 +0300
Content-Disposition: inline
In-Reply-To: <4A5ED41F.5010502@garzik.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Jul 2009 07:21:34.0563 (UTC) FILETIME=[0C9BBB30:01CA05E6]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123375>

On Thu, Jul 16, 2009 at 09:17:51AM +0200, ext Jeff Garzik wrote:
> Felipe Balbi wrote:
> > On Thu, Jul 16, 2009 at 08:43:21AM +0200, ext Jeff Garzik wrote:
> >> Junio C Hamano wrote:
> >>> Jeff Garzik <jeff@garzik.org> writes:
> >>>
> >>>> Is there some sort of guide to the new best practices for handling
> >>>> trees such as git.kernel.org, where one pushes into "foo.git"
> >>>> directly, and there is no checked-out source code at all?
> >>> I think old repositories will be helped if you add
> >>>
> >>> 	[core]
> >>>         	bare
> >>>
> >>> to their foo.git/config files.
> >> Thanks.  What about cloning new repositories?  Real world example:
> >>
> >> Local workstation has /spare/repo/cld/.git repository, with checked-out 
> >> working tree.
> >>
> >> I want to publish this tree to the world via a *.kernel.org-like system, 
> >> so my task is to
> >>
> >> 	scp -r /spare/repo/cld/.git remote.example.com:/pub/scm/cld.git
> >>
> >> but if I do this with scp, then future pushes to 
> >> remote.example.com:/pub/scm/cld.git emit the warning about updating the 
> >> currently checked-out branch -- even though there are no checked-out 
> >> files.  The checked-out files were not copied in the scp.
> > 
> > how about you create the bare repository on the kernel.org-like server
> > and then push cld to it ?
> 
> You mean use 'git init-db', like this?
> 
> 1) remote: cd /pub/scm ; mkdir cld.git ; GIT_DIR=cld.git git init-db
> 
> 2) local: cd /spare/repo/cld ; git push --force --all \
> 	remote.ex.com/pub/scm/cld.git
> 
> I suppose that would work...

yes, exactly :-)

-- 
balbi
