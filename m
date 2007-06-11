From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: cache max revision in rev_db databases
Date: Mon, 11 Jun 2007 23:43:54 +1200
Message-ID: <466D357A.8070605@vilain.net>
References: <20070610091304.C3E0413A4F8@magnus.utsl.gen.nz> <20070610214753.GC12222@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 13:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxiK9-00073q-Az
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 13:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXFKLoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 07:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbXFKLoe
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 07:44:34 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:37657 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbXFKLoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 07:44:34 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 805ED13A4F0; Mon, 11 Jun 2007 23:44:31 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 2053913A400;
	Mon, 11 Jun 2007 23:44:20 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070610214753.GC12222@muzzle>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49846>

Eric Wong wrote:
> Sam Vilain <sam@vilain.net> wrote:
>   
>> Cache the maximum revision for each rev_db URL rather than looking it
>> up each time.  This saves a lot of time when rebuilding indexes on a
>> freshly cloned repository.
>>     
>
> It looks correct, but I'm not sure how often we can even hit this
> optimization to make it worth it.
>
> Any live repositories and benchmarks you've run this on?
> (without the rev-list => log patch applied, which would be a big
> performance improvement if all log messages were under 16k).
>   
It may not make a huge difference with the current code, but it might
with a different rev_db back-end with higher connection cost, and it
seemed like an obvious and innocuous enough memoization.

Sam
