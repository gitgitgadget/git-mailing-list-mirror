From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Sat, 04 Aug 2007 23:02:01 -0700
Message-ID: <7vbqdmh63q.fsf@assigned-by-dhcp.cox.net>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
	<7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
	<20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
	<7v643vj316.fsf@assigned-by-dhcp.cox.net>
	<8c5c35580708040441ue1c3ef8qc022912a5af4883e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, "Sven Verdoolaege" <skimo@kotnet.org>,
	git@vger.kernel.org, "Eran Tromer" <git2eran@tromer.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 08:02:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHZC4-0004DW-TA
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 08:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXHEGCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 02:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXHEGCF
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 02:02:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41751 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbXHEGCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 02:02:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805060202.JJZW2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 02:02:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y6211X0071kojtg0000000; Sun, 05 Aug 2007 02:02:02 -0400
In-Reply-To: <8c5c35580708040441ue1c3ef8qc022912a5af4883e@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 4 Aug 2007 13:41:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54956>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 8/4/07, Junio C Hamano <gitster@pobox.com> wrote:
>> As we explicitly allow
>> submodule checkout to drift from the supermodule index entry,
>> the check should say "Ok, for submodules, not matching is the
>> norm" for now.  Later when we have the ability to mark "I care
>> about this submodule to be always in sync with the superproject"
>> (thereby implementing automatic recursive checkout and perhaps
>> diff, among other things), we should check if the submodule in
>> question is marked as such and perform the current test.
>
> Yes, this sounds like a sane plan (and a good explanation of the
> current semantics: maybe something to include in the release notes for
> 1.5.3?)

The submodule Porcelain is a new thing in 1.5.3, so we would
need a good description of what the current rules are and what
our vision for future enhancement will be.

I am not certain however the above is the accurate description
of the current design and the direction we would want to go,
though.  Somebody needs to sanity check me.
