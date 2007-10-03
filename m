From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 04:08:09 -0700
Message-ID: <7v8x6kfobq.fsf@gitster.siamese.dyndns.org>
References: <20070927130447.GH10289@artemis.corp>
	<7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
	<buoprzwn5qm.fsf@dhapc248.dev.necel.com>
	<20071003073554.GA8110@artemis.corp>
	<buobqbgmv6z.fsf@dhapc248.dev.necel.com>
	<83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
	<20071003104943.GA3017@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id25c-0004YC-6E
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbXJCLIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 07:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbXJCLIT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:08:19 -0400
Received: from rune.pobox.com ([208.210.124.79]:41432 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbXJCLIT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 07:08:19 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id ECD7B140D3F;
	Wed,  3 Oct 2007 07:08:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AC2C1140D4B;
	Wed,  3 Oct 2007 07:08:33 -0400 (EDT)
In-Reply-To: <20071003104943.GA3017@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Wed, 3 Oct 2007 12:49:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59822>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> So it all comes down to case (2) mistakes being much harder to fix
> than case (1) mistakes. Therefore, we should change the default, sinc=
e
> doing so makes it safer.

I am not convinced.

I've seen many new people alias "rm" to "rm -i" for this (I'd
say "false") reasoning to "default to safer", and end up
training their fingers to say "y" without thinking.

Also mistakes can cut both ways.  Pushing out what you did not
intend to is what you seem to be worried about more.  But not
pushing out enough and not noticing is an equally bad mistake.

People also argue for "default per user".  I am not really
convinced on that point either.

You, an expert, will get asked for help by somebody, walk up to
his shell prompt, and try to help and teach him by showing you
type, and then you suddenly notice the command does not work as
you expect because he set the default differently (because he
read that configuration option on some web parge).  And we will
be in such a cumbersome to diagnose situation _very_ often if we
have per-user default on many things.
