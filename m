X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:32:44 -0800
Message-ID: <7vzmasld43.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 19:33:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611151858.51833.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 15 Nov 2006 18:58:50 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31476>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQVP-00043Q-Vh for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030937AbWKOTdD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030938AbWKOTdB
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:33:01 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31899 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1030937AbWKOTdA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:33:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115193259.TJOH97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 14:32:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n7Z51V00g1kojtg0000000; Wed, 15 Nov 2006
 14:33:06 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

>> But trying to rename "pull" (or the "git" name itself) is just going to
>> cause more confusion than you fix.
>
> I don't think so.  Mainly because the proposed new git pull would be a subset 
> of the existing git pull.  It's not changing function, it's just reducing in 
> function.

We usually use the word "regression" to refer to that kind of
change.

I think it makes a lot of sense having command x that does
essentially the same thing as the current fetch but with more
usability enhancements and more convention as built-in defaults,
and another command y that does what the current 'pull .' does
but with more usability enhancements and more convention as
built-in defaults.  I agree that kind of UI improvements would
make it easier to explain to new people.  Calling x "pull",
however, breaks the existing users and documents, and causes
confusion.  I really do not think you can argue with that.

That's why we are talking about using an uncontaminated word
"get".  I think it is a good effort.

>> aren't that complicated. There's no reason to rename them. We do have
>> other problems:
>
> That there are other problems doesn't negate these problems.

And I think Linus is right in pointing out that there are other
problems that are equally or even more pressing than _renaming_
to break things for existing users.

I personally do not think the current fetch/pull confusing, and
I do see real downside in _renaming_ them, but I am open to the
current get/put discussion because I think the new commands'
semantics may be designed to match newcomers' expectation better
(it's to match tools to newcomers instead of teaching them the
new language of the land) and I do not think that approach would
break existing users and documents.

For some things "matching tools to newcomers" would not really
work, though.  For example, I do not think you can get away with
hiding index forever if you want your users to do real work in a
workflow that involves merging and cherry picking.

