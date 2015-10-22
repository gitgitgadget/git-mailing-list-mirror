From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Thu, 22 Oct 2015 12:11:23 -0700
Message-ID: <xmqqvb9yra5g.fsf@gitster.mtv.corp.google.com>
References: <1445485872-21453-1-git-send-email-max@max630.net>
	<1445485872-21453-3-git-send-email-max@max630.net>
	<xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
	<20151022145606.GD5722@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpLGy-0000ci-Us
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 21:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbbJVTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 15:11:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964927AbbJVTL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 15:11:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D53562522F;
	Thu, 22 Oct 2015 15:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oD1Suz1b5JPVsblt4iFm+e7Vv5c=; b=e9sfUM
	WYBOyEMQIgeIx0eb4Ujq/2b+z+IVLU2erb5g4rXCd15PfUgAaroX3T0iIEr1t/hI
	TG9EZHl1Z6IVraAaF440ogIKxcZ6qkpbw/rs+1QwMZt3oDlJNbIVMwJDtGBBqKuJ
	HKgE8bgnA5JMF8abntYCf8awL+UgCQqKE39uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SRmNYes+SB2nSLzLqxA7uQXukuIaLgf0
	vxRPNSsMpDyB+PG32gBly5wvXcaBiLQUhnJE9QYbX1vQy6MOs+7EztLbzCilGufC
	QqhiJOwRj2KhtQNSPhWJG1nX+/DNjCfLy1FBohpxAR11HkJsOIOF5gI1m20hS1vi
	qkA3Dbp1jCs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDC582522E;
	Thu, 22 Oct 2015 15:11:25 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 540C42522A;
	Thu, 22 Oct 2015 15:11:25 -0400 (EDT)
In-Reply-To: <20151022145606.GD5722@wheezy.local> (Max Kirillov's message of
	"Thu, 22 Oct 2015 17:56:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0842AF0-78F0-11E5-86C3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280071>

Max Kirillov <max@max630.net> writes:

> On Wed, Oct 21, 2015 at 09:25:37PM -0700, Junio C Hamano wrote:
>
>> The logic you implemented feels solid to me, at least at a first
>> glance.  What kind of gotchas are you worried about?
>
> The fact than arbitrary commit's children are unknown does
> not seem reliable to me. It more fits the "works by chance"
> description.

That's sad.
