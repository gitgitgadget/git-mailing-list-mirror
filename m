From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Wed, 14 Mar 2012 11:19:55 -0700
Message-ID: <7vfwdbqc38.fsf@alter.siamese.dyndns.org>
References: <4F5E3298.5030502@seap.minhap.es>
 <7vk42pr3c7.fsf@alter.siamese.dyndns.org> <4F5F41FF.4000204@seap.minhap.es>
 <7vy5r4wfru.fsf@alter.siamese.dyndns.org>
 <20120313220411.GA28357@sigill.intra.peff.net>
 <7v1uowt83u.fsf@alter.siamese.dyndns.org> <4F607CEF.5010209@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:20:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7snu-0006QV-0G
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761268Ab2CNST7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:19:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756182Ab2CNST6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:19:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FB9B78A6;
	Wed, 14 Mar 2012 14:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A+2fq4mjdSRSFrfEgjRHDWLSjn0=; b=V7PgsM
	yC8LyHMgayRAUBlKu7QbeFI18izXvmfCPljRZ1CtGjlh9knsj6hXML2AIWDBqC2r
	EZhB2vppcoUcR4zEI4dkLtUYMS7PKg7KxF47dm0lngkcg6pQAjYrCei5fobpNZVB
	/0ddqZ18BocS0H6J7zRZmAtCKs8W/+vJ5QDiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=haItOQAfsWsgQVZwN0p4b8TSVlj7d6l2
	JpAYP/caisfB+ItLRO010LagQHCXxqdrlmrgyAxfw0fND9s2nmoCEilY2M/psgLg
	dbS60rn3U1v1HR2cy0PA5pFSy7lYzANtF9p4v6TnciRlMf4+mMbvAD6VggFdy4Op
	4yuatzRd7To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 668BC78A5;
	Wed, 14 Mar 2012 14:19:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF69978A4; Wed, 14 Mar 2012
 14:19:56 -0400 (EDT)
In-Reply-To: <4F607CEF.5010209@seap.minhap.es> (Nelson Benitez Leon's message
 of "Wed, 14 Mar 2012 12:11:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DABD4CA-6E02-11E1-AEE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193141>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> After adding the proxy authentication support in
> http, the semantics of HTTP_REAUTH changed more to
> a retry rather than a re-authentication, so we
> rename it to HTTP_AUTH_RETRY.
>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
> Ok this is a new 5/5 patch that have HTTP_AUTH_RETRY as
> Junio suggested, is responding with this patch good or
> do I need to send a new re-roll just for this?

Heh, HTTP_AUTH_RETRY was not something I suggested ;-) The name comes from
your http://mid.gmane.org/4F5F41FF.4000204@seap.minhap.es message.

Regarding whether to re-send everything or only a selected subset, please
follow your best judgement, like you did this time.

In general, when you know that the participants in the discussion are
keeping closer eyes on the progress of the series, and they are likely to
understand what you mean when you say "I am replacing the last one in the
v3 series I sent earlier with this patch" when you send "[PATCH v4 5/5]",
it is appropriate to send only the updated one(s).

It makes only two small differences if I am or I am not among the
participants in the discussion.

 - When I happen to be involved in a topic and keeping closer eyes on it,
   an earlier iteration of it is likely to appear on 'pu', so you have one
   more clue to tell if it is OK to send just an update, compared to a
   series that is discussed only on the list without anybody tracking the
   most recent state of the series.

 - When I am not involved in a discussion, often I am sitting on the
   sideline (a recent example is the topic around svn-fe/fast-import
   regarding "ls" command on an empty path), letting the stakeholders in
   the series figure out the details and waiting for the final outcome of
   the discussion [*1*].  For such a topic, I may request a full resend of
   the final version when it is time for me to queue it.

Thanks.  I replaced the corresponding patch with this, after fixing the
subject line.

[Footnote]

*1* This happens when I have more confidence in them than in myself to
judge the best direction for the series.
