From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 10:58:51 -0500
Message-ID: <n2z47RdNjxVbPeRfgJuY54nJrfzDfn43bzv8HoH6cEuAzQ6fB1MaBg@cipher.nrlssc.navy.mil>
References: <871vm0k6jm.fsf@meyering.net> <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com> <87ocp4imul.fsf@meyering.net> <20090921134427.GA20567@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, Alex Riesen <raa.lkml@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 17:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MplI8-0004iP-Kx
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 17:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZIUP6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 11:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbZIUP6y
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 11:58:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52108 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZIUP6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 11:58:54 -0400
Received: by mail.nrlssc.navy.mil id n8LFwqoA013066; Mon, 21 Sep 2009 10:58:52 -0500
In-Reply-To: <20090921134427.GA20567@sigio.peff.net>
X-OriginalArrivalTime: 21 Sep 2009 15:58:52.0068 (UTC) FILETIME=[6A146640:01CA3AD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128892>

Jeff King wrote:
> On Mon, Sep 21, 2009 at 01:00:34PM +0200, Jim Meyering wrote:
> 
>>> We have (had?) people trying to support Git on HP-UX and SunOS.
>>> Do these count?
>> I had my doubts, but have just confirmed that Solaris 10's
>> /usr/bin/tr is still doing it the SYSV way:
>>
>>     $ echo foo | LC_ALL=C /usr/bin/tr a-z A-Z
>>     foo
>>
>> There, you have to use /usr/xpg4/bin/tr to get the expected behavior:
>>
>>     $ echo foo | LC_ALL=C /usr/xpg4/bin/tr a-z A-Z
>>     FOO
>>
>> So you're right.  Thanks!

By the way, modern git inserts /usr/xpg4/bin into PATH before /usr/bin on
Solaris.  So /usr/xpg4/bin/tr should always be used on that platform.

-brandon
