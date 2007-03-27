From: David Lang <david.lang@digitalinsight.com>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 09:00:08 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703270858080.15345@qynat.qvtvafvgr.pbz>
References: <1174825838.12540.5.camel@localhost> 
 <20070326220302.GH22773@admingilde.org><7vfy7rvct2.fsf@assigned-by-dhcp.cox
 .net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWFRr-0007n2-BN
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbXC0R1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933980AbXC0R1D
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:27:03 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46394 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933084AbXC0R1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:27:01 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 27 Mar 2007 09:27:01 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 27 Mar 2007 10:26:29 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43289>

On Tue, 27 Mar 2007, Linus Torvalds wrote:

> - walking the *global* object list is simply not possible. You need to
>   fsck every single subtree individually, and fsck the superproject on
>   its own, *without* recursing into the subprojects. And you need to be
>   able to clone the superproject and only one or two subprojects, and
>   never see it as one "atomic" big repository.

you can do a fsck to make sure that all needed objects are available on each 
project individually, but a prune/gc _does_ need to go through the global object 
list to find out what objects aren't needed anymore (otherwise, how do you know 
if the object isn't needed by another thing sharing the same object store?)

David Lang
