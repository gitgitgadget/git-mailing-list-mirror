From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Wed, 08 Jun 2011 17:43:20 -0700
Message-ID: <7vzklrzvfb.fsf@alter.siamese.dyndns.org>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172030.GC22111@sigill.intra.peff.net>
 <7vk4cv29oe.fsf@alter.siamese.dyndns.org>
 <20110609001150.GA19715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUTLZ-00052V-OH
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab1FIAnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:43:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1FIAng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:43:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CCD9562C;
	Wed,  8 Jun 2011 20:45:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ApDITVXdhJRRx1c7mFgTKM3oyOU=; b=wDPsZp
	Yxsl4EY8/+uCZrYJQLgCcIQFhNYz5p1BDyWpxWAZ97JB7jdwmXz1T2LxX7s7pTDd
	OLKBoBTEgaoU+PcXYxHxUBlVKHxgLArhRVvX1VF+FRJY3f4b5WlTq+XfTdHP+FRn
	8O7RmnFcEe1hz0Q5ME6wfpm/JlD54wQ4VRJVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=waT+RmYVZxN4E8Md+m7R9pBMSFN/wB/V
	1rPpszORqscOYi4LjltJTbh6gVgDpLC2NiWOPKANfIC4LZ7Hq1F19KV8sFWpBTYp
	DG56qdDv7gtSYQ0mPY6CMjU5RHaqh4eMlk639xUpDgNsaoacq9VXTfGcLvco98Ip
	iALLa+qHhTE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0E83562B;
	Wed,  8 Jun 2011 20:45:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD6A7562A; Wed,  8 Jun 2011
 20:45:30 -0400 (EDT)
In-Reply-To: <20110609001150.GA19715@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 8 Jun 2011 20:11:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB7544E8-9231-11E0-9CD9-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175479>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 08, 2011 at 04:19:29PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > The third test demonstrates a bug in git's side of the
>> > helper code when the upstream has added new refs without us.
>> 
>> without us knowing, you mean?
>
> I guess it depends what you mean by knowing. The bug is shown when the
> remote has a ref that we don't; we try to feed the name of that ref to
> fast-export, which of course doesn't work, because we don't have
> anything by that name.
>
> So in that sense, no, we don't know about the ref. But it is not about
> us knowing about the remote having the ref; the problem is that we _do_
> know that the remote has that ref, and assume we have a matching one.

Ok, I think I understood what the sentence wanted to say ("the upstream
added new refs. We do not have them yet", right?); it was just I found the
phrase "... without us" didn't sit well there to my ears.
