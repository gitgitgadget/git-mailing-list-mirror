From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Submodule object store
Date: Mon, 26 Mar 2007 15:20:34 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost>
 <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de>
 <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyuX-0008EX-3p
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933784AbXCZXrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933757AbXCZXrd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:47:33 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:34163 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933784AbXCZXrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:47:33 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 26 Mar 2007 15:47:32 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 26 Mar 2007 16:46:43 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070326233603.GL22773@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43209>

On Tue, 27 Mar 2007, Martin Waitz wrote:

> On Mon, Mar 26, 2007 at 04:28:28PM -0700, Junio C Hamano wrote:
>> Martin Waitz <tali@admingilde.org> writes:
>>
>>> To make purge and fsck work we have the hard requirement that it
>>> must be possible to list all objects which belong to one submodule.
>>
>> I understand you would want to separate the ref namespace, but I
>> still do not see why you would want to have a separate object
>> store, laid out in a funny way.  Unless you are thinking about
>> using rsync to transfer object store, that is.
>
> I want to be able to list all objects which are not reachable in the
> object store, without traversing all submodules at the same time.
> The only way I can think of to achieve this is to have one separate
> object store per submodule and then do the traversal per submodule.

why do you want to optimize for the relativly rare fsck function rather then the 
more common read functions (which would benifit from shareing object that are 
identical between projects)?

David Lang
