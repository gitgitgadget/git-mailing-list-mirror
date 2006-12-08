X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 08 Dec 2006 14:34:28 -0800
Message-ID: <7v1wnaggp7.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
	<7vr6vagja6.fsf@assigned-by-dhcp.cox.net>
	<200612082301.57037.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 22:34:46 +0000 (UTC)
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612082301.57037.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Fri, 8 Dec 2006 23:01:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33762>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsoIm-0007nf-Vk for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761228AbWLHWeb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761226AbWLHWeb
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:34:31 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54971 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761228AbWLHWea convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:34:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208223429.CVVV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 17:34:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wNZs1V00S1kojtg0000000; Fri, 08 Dec 2006
 17:33:53 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 08 December 2006 22:38, Junio C Hamano wrote:
>> "Santi B=E9jar" <sbejar@gmail.com> writes:
>>=20
>> > On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
>> >> Clarify the meaning of branch.*.merge option and add a similar
>> >> branch.*.localmerge option, which can be used to specify a local
>> >> tracking branch to be merged by default.
>>=20
>> I am not so sure about the "localmerge" stuff anymore.
>>=20
>> What convenience would it buy us (including but not limited to
>> new people), and if there is any, would that outweigh the
>> potential confusion factor to have two different configuration
>> variables that do exactly the same thing whose sole difference
>> is which side of the fetched branch namespace it uses to specify
>> the merge source?
>
> I just came up with a concrete patch.
> I am not saying that this is the only true solution.

I admit that I do not use branch.*.merge and I do not know what
people find lacking in what Santi did in late September with
commit 5372806.  What problem are we trying to solve (not a
rhetorical question -- I am truly lost here)?  Is it only a
confusion between remote and local, or is there something that
cannot be expressed with the current scheme?

> Actually, Jakubs one with allowing arbitrary refspecs is nice.
> The only problem is that it is not consistent which refspec
> shortcuts otherwise, or?

Actually I had a quite opposite reaction about allowing src:dst
notation there.  Does it solve any real problem?  It is unclear
to me.  On the other hand, it gives a false impression that it
can be used instead of remote.*.fetch to copy the remote branch
into local tracking branch, and raises other questions such as
what should happen when you have both, i.e. src:dst is given to
both remote.*.fetch and branch.*.merge, and they do not agree.
Which means it only adds to the confusion.

So I do not think it is worth spending brain cycles talking
about that particular one; it does not even have a patch to=20
implement it.

But you have a concrete patch, and if it is fixing a real
problem, then that is worth talking about.  I just do not know
if a problem exists, other than that people can get confused and
write local tracking branch name by mistake when it should be
remote branch name.
