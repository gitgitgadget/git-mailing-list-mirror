From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 10:51:31 -0800
Message-ID: <7vpqqrke30.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
 <20110216100622.GA12971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpmTi-0006eU-RM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab1BPSvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 13:51:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab1BPSvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 13:51:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 095414FBC;
	Wed, 16 Feb 2011 13:52:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pD9I2Ubf7OSRa2iMNyRJZhj0qaQ=; b=OcdlhG
	Rc7C55SkUWprYF+JBTE9IvlX4khqqwFsKlq7sGtnjWkxsjWiCXhgFMXJxMc5jEks
	iqTDFBxDh1Lyk/fnTqcuvcJjly2Rgq4qC5aOSDQVKrNDotp9+uZVyBWEAqkenXPb
	iZneNFceLe2BmYsJRytTdMXUH+T51c9nt+Ht0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XAKjzWjW2CPx484BHNyBlSfLuv22vIzV
	4AArDRdqAsYwRv/iTE7EqKamp4maCDrJFMWY2Wte6eyfSsy+JsBFWW8suOAhHuFu
	BpbbcA/n2ZE3efnuhQSBJPqwP5+ieBFfUNlluu4RpWzFaSthGQE+Ug2xyGVYE0sJ
	wDRtrlPQPv8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABD9A4FB9;
	Wed, 16 Feb 2011 13:52:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36B8C4FB6; Wed, 16 Feb 2011
 13:52:39 -0500 (EST)
In-Reply-To: <20110216100622.GA12971@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 16 Feb 2011 05\:06\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F259A32E-39FD-11E0-9D90-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166985>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 16, 2011 at 09:58:52AM +0000, Sverre Rabbelier wrote:
>
>> On Wed, Feb 16, 2011 at 09:54, Jeff King <peff@peff.net> wrote:
>> > So? Your question was whether index state is precious. If it's precious,
>> > shouldn't we be keeping a history of it?
>> 
>> I don't think it's quite _that_ precious, but the only operation that
>> I regularly use that can blow away my carefully constructed index as
>> side effect of doing something else is `git commit -a`.
>
> OK, so how precious is it? :)

The world is not that black-and-white, but is full of different shades of
gray.

If you made mistakes with a second "git add", you can "reset --mixed"
everything away and restart from scratch.  The same thing can be said for
a mistaken "git commit -a" that can be "reset HEAD^" (or --amend).  So
there is not much difference at the technical level.

I don't think this is primarily about "protecting the index".  It is more
about making the user feel better.  Compared to a mistaken second "add", a
mistaken "commit -a" feels like a lot heavier point-of-no-return.
