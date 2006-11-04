X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Sat, 04 Nov 2006 04:03:38 -0800
Message-ID: <7vk62bxvtx.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
	<20061103094655.GA16721@diana.vm.bytemark.co.uk>
	<200611031815.49553.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 4 Nov 2006 12:03:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30922>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgKFT-0001M4-FJ for gcvg-git@gmane.org; Sat, 04 Nov
 2006 13:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965337AbWKDMDk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006 07:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965343AbWKDMDk
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 07:03:40 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31146 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S965337AbWKDMDj
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006
 07:03:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104120338.LXWS18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 07:03:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ic3H1V0021kojtg0000000 Sat, 04 Nov 2006
 07:03:17 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 03 November 2006 10:46, Karl Hasselstr=F6m wrote:
>> Hmm. How about changing the meaning of "remote" slightly? Like this:
>
> That's not good, as it changes existing config meaning.
>...
> Other option: Introduce "fetchonly" line which ignores the original
> fetch lines in the remote section.
>
>        [remote."gitster"]
>                url =3D gitster.example.com:/home/junio/git.git/
>                fetch =3D heads/master:remotes/gitster/master
>                fetch =3D heads/next:remotes/gitster/next
>        [branch."master"]
>                remote =3D gitster
>                fetchonly =3D heads/master:remotes/gitster/master
>                merge =3D remotes/gitster/master

That is a regression in that now I need to fetch twice (in the
above example, in reality four).

