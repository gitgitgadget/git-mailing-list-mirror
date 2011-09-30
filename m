From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Fri, 30 Sep 2011 11:19:24 -0700
Message-ID: <7v1uuxq4er.fsf@alter.siamese.dyndns.org>
References: <20110928153935.GA7800@myhost>
 <7vsjngxphv.fsf@alter.siamese.dyndns.org> <20110928230809.GA1798@myhost>
 <7vk48sxn5g.fsf@alter.siamese.dyndns.org> <20110930132903.GA1622@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9hgM-0006E6-5u
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 20:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077Ab1I3ST2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 14:19:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755909Ab1I3ST0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 14:19:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF535AAD;
	Fri, 30 Sep 2011 14:19:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vz9KGXgFn/8Efvr1YFXeUSZBLNE=; b=Lta1dn
	/zwD+sOq2bV2fkt8TswUJsaj9Tl/qGSJmYcpx/fc5V+dPahv2UlqdkJsRJkBt++f
	c5yMpfkfT6TH1hdi+5V4XxQloE8Xu9Spsol+FCH92Uf3rB6x2nEZWZ59L8O6ut0F
	7qeSkVP0gPUzQi80bxzNYL2hZ/KrEHAjpeURE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bFNQMy5C4oKktEgo76YYgoYxBWV7e+C6
	maT1rsnTDUQ9znwIOKd6JZUBGSLz8asV3m38IsjtZDB+Jte8Qzqu24+VhG4C/aO3
	nuXGQs2lWfI/P3/aqdWFR+FPm0uRhkpLb6DXbR4N0j6cR06vC3bs+7B41MJpE1C/
	9cWOj+48qR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 443CC5AAC;
	Fri, 30 Sep 2011 14:19:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C970D5AAB; Fri, 30 Sep 2011
 14:19:25 -0400 (EDT)
In-Reply-To: <20110930132903.GA1622@myhost> (Pang Yan Han's message of "Fri,
 30 Sep 2011 21:29:03 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA8ADCCA-EB90-11E0-8498-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182498>

Pang Yan Han <pangyanhan@gmail.com> writes:

> Sorry for asking, but do I need to reroll this with the fixup in
> origin/ph/push-to-delete-nothing ? Is the commit message fine especially
> in light of the changes in the fixup?

If you think that the result of squashing the fix-up commit into your
patch looks OK, I do not think there is a need to reroll. The patch title
may need to be shortened, but other than that I do not see anything
glaringly wrong in the commit log message that I cannot amend out.

Thanks.
