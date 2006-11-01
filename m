X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 00:07:16 -0800
Message-ID: <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
	<200610270827.17659.andyparkins@gmail.com>
	<20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	<20061027081545.GF29057@spearce.org>
	<81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
	<4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 08:07:31 +0000 (UTC)
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 1 Nov 2006 14:58:54 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30618>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfB87-0008SG-MN for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946690AbWKAIHT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946693AbWKAIHT
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:07:19 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13198 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1946690AbWKAIHR
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:07:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101080717.ZLAO2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 1
 Nov 2006 03:07:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id hL6w1V00R1kojtg0000000 Wed, 01 Nov 2006
 03:06:57 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 10/27/06, Junio C Hamano <junkio@cox.net> wrote:
>> On the other hand, I designed --index-info to be compatible with
>> ls-tree output (it is not an accident, it was designed).  In
>>
>>         git ls-tree HEAD frotz | git update-index --index-info
>>
>> "frotz" part does not have to be the exact path but can be a
>> directory name.  It means "revert everything in this directory".
>>
>> This is quite heavy-handed and you would probably want to run
>> update-index --refresh afterwards.
>
> I would prefer "git update-index --reset frotz" or "git checkout
> --index HEAD frotz". git ls-tree|git update-index is too cryptic for
> me and too long for my fingers.

Then perhaps you can use "git checkout HEAD frotz", which is the
simplest?

