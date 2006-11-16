X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 03:47:31 -0800
Message-ID: <7vslgjaa0c.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 11:48:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 16 Nov 2006 03:11:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31574>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkfiq-0002wm-TS for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031172AbWKPLrd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031176AbWKPLrd
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:47:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16379 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1031172AbWKPLrc
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:47:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116114732.OCXV21630.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 06:47:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nPne1V00M1kojtg0000000; Thu, 16 Nov 2006
 06:47:39 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
>
>> [hanwen@haring y]$ git pull ../x
>> fatal: Needed a single revision
>> Pulling into a black hole?

Having said all that, I happen to think that this particular
case of pulling into void could deserve to be special cased to
pretend it is a fast forward (after all, nothingness is an
ancestor of anything), if only to make new people's first
experience more pleasant.

Working from nothingness is something not usually done in
everyday work, so from practical and technical point of view it
does not add much _real_ value to the people who actually uses
the system, but nevertheless, new people typically start
learning the system from either cloned repository (which I
believe is covered by the existing tools fairly well) or
emptiness (which bitten us here in a bad way), and making the
first experience more pleasnt to new people have a positive
value of flattening the learning curve.

So please consider that this is classified as a bug.
