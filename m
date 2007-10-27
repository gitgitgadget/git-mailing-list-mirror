From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bisect run: "skip" current commit if script exit code is 125.
Date: Fri, 26 Oct 2007 23:12:09 -0700
Message-ID: <7vabq5ulvq.fsf@gitster.siamese.dyndns.org>
References: <20071026053937.2831a89b.chriscool@tuxfamily.org>
	<A43880E9-E496-48AA-BC1C-2C98DFD12370@lrde.epita.fr>
	<200710270702.31923.chriscool@tuxfamily.org>
	<20071027052834.GA3115@hermes.priv>
	<20071027053305.GB3115@hermes.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Sat Oct 27 08:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IleuK-0001Az-2d
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 08:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXJ0GMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 02:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXJ0GMQ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 02:12:16 -0400
Received: from rune.pobox.com ([208.210.124.79]:59113 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbXJ0GMP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2007 02:12:15 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7C2EC150989;
	Sat, 27 Oct 2007 02:12:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E876C1508D9;
	Sat, 27 Oct 2007 02:12:32 -0400 (EDT)
In-Reply-To: <20071027053305.GB3115@hermes.priv> (Tom Prince's message of
	"Sat, 27 Oct 2007 01:33:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62463>

Tom Prince <tom.prince@ualberta.net> writes:

> On Sat, Oct 27, 2007 at 07:02:31AM +0200, Christian Couder wrote:
>> Le vendredi 26 octobre 2007, Benoit SIGOURE a =C3=A9crit :
>> > On Oct 26, 2007, at 5:39 AM, Christian Couder wrote:
>> > >
>> > > +The special exit code 125 should be used when the current sourc=
e code
>> > > +cannot be tested. If the "run" script exits with this code, the
>> > > current
>> > > +revision will be "skip"ped, see `git bisect skip` above.
>> > > [...]
>> >
>> Also there is:
>>=20
>> $ grep 77 /usr/include/sysexits.h
>> #define EX_NOPERM       77      /* permission denied */
>
> How about=20
>
> #define EX_TEMPFAIL     75      /* temp failure; user is invited to r=
etry */

Let's stop bikeshedding.  125 is as good as anything else.
