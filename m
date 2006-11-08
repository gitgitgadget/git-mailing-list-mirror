X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christopher Faylor <cgf-use-the-mailinglist-please@sourceware.org>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 14:22:14 -0500
Message-ID: <20061108192214.GA21892@trixie.casa.cgf.cx>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com> <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 19:22:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
User-Agent: Mutt/1.5.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31155>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ght07-00059z-Mb for gcvg-git@gmane.org; Wed, 08 Nov
 2006 20:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161714AbWKHTWP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 14:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161716AbWKHTWP
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 14:22:15 -0500
Received: from pool-71-248-179-54.bstnma.fios.verizon.net
 ([71.248.179.54]:5542 "EHLO cgf.cx") by vger.kernel.org with ESMTP id
 S1161714AbWKHTWP (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 14:22:15 -0500
Received: by cgf.cx (Postfix, from userid 201) id 71D8013D48C; Wed,  8 Nov
 2006 14:22:14 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tue, Nov 07, 2006 at 02:55:01PM +0100, Alex Riesen wrote:
>>So the problem is probably memory fragmentation.
>
>probably.
>
>>You might have more joy if you allocated one HUGE chunk immediately on
>>startup to use for the pack, and then kept re-using that chunk.
>
>Well, it is not _one_ chunk. The windows/cygwin abomin...combination

I would like to ask you, once again, to exercise some adult self-control
when you feel compelled to answer questions about Cygwin.  If you need
to vent your frustration in some direction, I'd suggest getting a dog.
They can look very contrite when you yell at them even if they didn't
actually do anything wrong.

>may take an issue with this: it seem to copy complete address space
>at fork, which even for such a small packs I have here takes system
>down lightly (yes, I tried it).

Yes, Cygwin copies the heap on fork since Windows doesn't implement fork.

FWIW, Cygwin's malloc is based on Doug Lea's malloc.  It reverts to
using mmap when allocating memory above a certain threshhold.

cgf
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
