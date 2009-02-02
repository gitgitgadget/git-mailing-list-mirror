From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Mon, 2 Feb 2009 01:50:42 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngockbi.vsa.sitaramc@sitaramc.homelinux.net>
References: <871vulda2r.fsf@gigli.quasi.internal>
 <slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
 <7vskmyt127.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 02:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTnz3-00027d-F6
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 02:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZBBBu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZBBBuz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 20:50:55 -0500
Received: from main.gmane.org ([80.91.229.2]:37016 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZBBBuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 20:50:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LTnxb-00076t-0u
	for git@vger.kernel.org; Mon, 02 Feb 2009 01:50:51 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 01:50:51 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 01:50:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108033>

On 2009-02-01, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> Reversing A and B is one thing, applying a sequence of
>> merges in a different order is quite something else.
>
> This point is true in theory but I haven't found it to cause problems in
> practice.  Textual conflicts between topics do happen, but it does not
> happen so often in overlapping areas across more than two topics that
> earlier resolutions to them cannot be reused by the rerere mechanism.

[snip]

> to force a merge order to the mainline can be used not only to deal with
> semantic conflicts but textual ones, too.  If two branches textually
> interact badly, you prepare a consolidated topic between the two, so that
> you can merge A alone, B alone, or A+B together to the mainline.
>
> If you end up merging A first and then want to merge B later (or the other
> way around, merge B and then A), and if the second merge to the mainline
> causes huge textual conflicts, you can instead merge the conslidated topic
> A+B to the mainline.

Thanks; great explanation.  I notice you blogged it too, and
similar to the "Never merging back" post, the message is: if
something is (or is likely to be) an independent feature, it
should have its own branch and be merged into others as soon
as it is known they need it.  (In that post, it was a random
crazy feature that one might normally dump into a customer
branch, here it's a bugfix B that you might naively dump
into feature A, but the basic logic is the same)
