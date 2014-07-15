From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 12:10:57 -0700
Message-ID: <xmqqlhruv3ni.fsf@gitster.dls.corp.google.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	<xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	<20140713173356.GA8406@sigill.intra.peff.net>
	<20140713183629.GA19293@sigill.intra.peff.net>
	<xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
	<1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
	<xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
	<1405445234.2577.0.camel@jekeller-desk1.amr.corp.intel.com>
	<xmqq7g3ewkp8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"peff\@peff.net" <peff@peff.net>,
	"sunshine\@sunshineco.com" <sunshine@sunshineco.com>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 21:11:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7888-0002Tl-0b
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 21:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbaGOTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 15:11:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60584 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932760AbaGOTLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 15:11:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44BA329C96;
	Tue, 15 Jul 2014 15:10:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mSPnRieTr41ROMRLOWOwfW8aFSA=; b=BmdDUv
	ldq6pVdomRGXInkNe0dSJmlY0DK0yHk8NziD45cz13J8ha+DGO0k5Jwp6fAueCts
	3X/E/afO1I2aI7IZB1yHLFwAmknbtyzKCQrC+/7wQvfI2gMOOcyyd78OvtbvAleN
	SHgLgXz8A1GqMv938g74X8YegcCfl9069wGNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNTVIxGS/hJbFvE79Dpo3ynp+qpPFLYq
	odmLuYGGazmffR5COAYRfOqyPqHqYfMp+a1xWy8fa5+k208a8fDcE9dPulY9/pY+
	u4B9oC9JtZDf9D/sBCrDmvu8mllygqjf/kUBv8dtP26EfgGX9tltqyQhZrtULR3K
	zKpXmeS0DNg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3834529C95;
	Tue, 15 Jul 2014 15:10:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB7B229C88;
	Tue, 15 Jul 2014 15:10:40 -0400 (EDT)
In-Reply-To: <xmqq7g3ewkp8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 15 Jul 2014 11:17:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B663F08C-0C53-11E4-AE5F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253585>

Junio C Hamano <gitster@pobox.com> writes:

> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>
>> On Tue, 2014-07-15 at 09:03 -0700, Junio C Hamano wrote:
>> ...
>>> >> Yes, that is fun.
>>> >> 
>>> >> I actually think your "In 'version:pefname' and 'wersion:refname',
>>> >> we want be able to report 'pefname' and 'wersion' are misspelled,
>>> >> and returning -1 or enum would not cut it" is a good argument.  The
>>> >> callee wants to have flexibility on _what_ to report, just as the
>>> >> caller wants to have flexibility on _how_.  In this particular code
>>> >> path, I think the former far outweighs the latter, and my suggestion
>>> >> I called "silly" might not be so silly but may have struck the right
>>> >> balance.  I dunno.
>> ...
>> I agree. But what about going back to the older setup where the caller
>> can output correct error message? I'm ok with using an enum style
>> return, to be completely honest. I would prefer this, actually.
>
> Depends on which older setup you mean, I think.  The one that does
> not let us easily give more context dependent diagnoses that lets us
> distinguish between version:pefname and version:refname by returning
> only -1 or an enum?

In case it was not clear, I do not think -1 or enum is a good idea.
