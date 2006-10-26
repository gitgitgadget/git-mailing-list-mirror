X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: stg mail
Date: Thu, 26 Oct 2006 16:06:15 +0200
Message-ID: <20061026140615.GA19268@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home> <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org> <20061026091925.GD13780@diana.vm.bytemark.co.uk> <tnxac3j4c6c.fsf@arm.com> <20061026105841.GB16372@diana.vm.bytemark.co.uk> <b0943d9e0610260457m780dd7d4t95fe36130cbdf551@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 14:06:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0610260457m780dd7d4t95fe36130cbdf551@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30221>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5sE-0006yI-Q9 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 16:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161415AbWJZOGT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161414AbWJZOGT
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 10:06:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:27919 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1161405AbWJZOGS
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 10:06:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd5s8-00057E-00; Thu, 26 Oct 2006 15:06:16 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-10-26 12:57:50 +0100, Catalin Marinas wrote:

> On 26/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Hmm. So now I know why you haven't taken my "stg email" patches. I
> > guess I'll have to fix 'stg import' then. :-)
>
> That's one of the reasons (and I didn't have time to document myself
> before giving a proper reply). The other is that Gnus (and gmail)
> doesn't display the messages properly - it shows a lot of "=3D20".

Hmm, this sounds like a mistake in my code, since one would expect
those two to be able to handle QP-encoded bodies properly. In fact, if
they didn't, all mails from me would look like that to you, since mutt
seems to QP-encode mails that I send.

I only viewed the mails in mutt, and they looked fine there.

> Is it possible not to affect the body (or make it optional)?

The vger mail server breaks 8bit encoded mails (which was what stg
mail generated previously), at least if they don't stick to ascii. So
if the body contains non-ascii stuff (such as my name in the sign-off
line), we do need the encoding. I could certainly do the QP-encoding
conditionally on there being non-ascii characters, though, and use
7bit or whatever it's called otherwise.

> People only using "patch" to apply the diffs would have problems
> with this encoding.

People feeding the raw email to patch would have this problem, yes.
But with the "8bit" encoding not working on all mail servers, there is
no way around this for non-ascii patches. But as I said, we certainly
could avoid QP-encoding pure ascii patches.

--=20
Karl Hasselstr=F6m, kha@treskal.com
