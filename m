From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 03 Sep 2008 13:59:17 -0700
Message-ID: <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809032036270.32295@pollux>
 <20080903191217.GA31195@coredump.intra.peff.net>
 <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
 <20080903203616.GB32223@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KazSp-0007kw-QB
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYICU7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYICU7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:59:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbYICU7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 16:59:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8ADC5B771;
	Wed,  3 Sep 2008 16:59:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 150095B76F; Wed,  3 Sep 2008 16:59:19 -0400 (EDT)
In-Reply-To: <20080903203616.GB32223@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 3 Sep 2008 16:36:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FE21EEE-79FB-11DD-985B-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94852>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 03, 2008 at 01:10:12PM -0700, Junio C Hamano wrote:
>
>> I agree with the above reasoning.  If we go with surrounding parenth=
eses,
>> it might even make sense to include a SP _before_ the opening parent=
hesis,
>> so that "%h %s%d" expands to either of these:
>>=20
>>    $ git show -s --pretty=3Dformat:'%h %s%d' v1.6.0^0 v1.6.0^1
>>    ea02eef GIT 1.6.0 (refs/tags/v1.6.0)
>>    373a273 Merge git-gui 0.11.0
>
> Isn't that what you argued against in Dscho's version of the patch?
>
>     http://mid.gmane.org/7v1w5exfwb.fsf@gitster.siamese.dyndns.org

Yeah, but unlike Linus, I am not infallible.  Also, I can change my min=
d.

If the concensus is that we do the simpler variant _now_ and leave
extending it for later, I think it is Ok to pick any one reasonable
default/simple format, and including the parentheses (with leading SP)
would be one reasonable default, certainly more reasonable than not
including the parentheses at all.

The background is somewhat different, too.

Back then I didn't think anybody but Dscho was interested in including
decorate in --pretty=3Dformat in half-baked form.  Ren=C3=A9 is comment=
 was to do
more flexible but complex variant.  I didn't see many people wanted to
have it in "limited but usable for simpler needs" form.

It wasn't that urgent, as opposed to this round more people seem to be
interested in having it even in a limited form.  And I knew Dscho was v=
ery
much capable of doing the "going whole nine yards" version, instead of =
a
simple-limited one.  "If we can afford to spend time to get it right in
the first round why not?" was part of the reasons behind my objection.
