X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:41:20 -0800
Message-ID: <7vr6w4lcpr.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151000460.2591@xanadu.home>
	<7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
	<200611151902.16358.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 19:42:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611151902.16358.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 15 Nov 2006 19:02:14 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31478>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQdh-0005xd-Fc for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030920AbWKOTli (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030942AbWKOTli
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:41:38 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22424 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1030920AbWKOTlg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:41:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115194136.VWOP7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 14:41:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n7hi1V00D1kojtg0000000; Wed, 15 Nov 2006
 14:41:42 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006, November 15 18:16, Junio C Hamano wrote:
>
>> I still think in the long run you would be better off giving
>> separate names to Porcelains because I am sure you are going to
>
> The problem I think with that is that the line between plumbing and porcelain 
> is not clear.

This is moot because we (at least tentatively) agreed not to do
"gh" or "ig" or whatever, but I do not understand why you feel
so.

If we had a separate Porcelain namespace (say "ng" for "new
git") you would know "ng-commit" is not a Plumbing and when you
are writing a Porcelain script you would stay away from using it
in your script.

In the longer term, when the new Porcelain UI Nico and friends
are designing matures, and if it makes everybody (including
existing users who learned git-* Porcelain-ish during 18-months
process) happy, we could gradually deprecate and eventually
remove the git-* Porcelain-ish over time, at that point we would
have a very clear line between plumbing and porcelain.

But that would not be a flag-day change.  During the transition
period you cannot mechanically tell if git-foo is a plumbing or
a porcelain just like you cannot do so now.
