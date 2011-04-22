From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL
Date: Fri, 22 Apr 2011 08:06:26 -0700
Message-ID: <7vvcy6tjf1.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
 <7vtydrutbq.fsf@alter.siamese.dyndns.org>
 <08195d5d-bd90-49d3-a1a6-63be0d833110-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 17:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDHwQ-0001s7-5q
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 17:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab1DVPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 11:06:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1DVPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 11:06:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E95CA530E;
	Fri, 22 Apr 2011 11:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+cc2akgztT6VopNy6k3cLxQ2/Y=; b=NtDngp
	XZ78pWo36smkOqPdMDkGFqN307aSwNyetgKVB/TD3NgUBhiSHnRvPtEZCaDLiaTT
	HxiNgscngQbws4lND18vcMpqejBUE8h6wYQhKidQ3T5qFyFek16qEEmA0Ns18TvQ
	5r4g7JWzy0hOmJbGngzyjceiVeOGUGXF6l4lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c02ZgmeMdeQE1yo7TVvnJPFVQhunHDCW
	SQgn9VF/1l0NdGzKYk10iXHlhBiKdUCX8MyXaD8/l3kUdQm52XCfrZROiVeGLRd5
	PhoeyssFxkpa+uek8FqZGWkpal2GQHuuoeMhvWH0fRhbDNpr6/D3MtfYj1wY5cZt
	sXhlHX1KzqY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3E18530C;
	Fri, 22 Apr 2011 11:08:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC3D6530B; Fri, 22 Apr 2011
 11:08:29 -0400 (EDT)
In-Reply-To: <08195d5d-bd90-49d3-a1a6-63be0d833110-mfwitten@gmail.com>
 (Michael Witten's message of "Fri, 22 Apr 2011 14:36:13 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 636B1FF8-6CF2-11E0-8B43-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171937>

Michael Witten <mfwitten@gmail.com> writes:

> Allow me to restate what I think you are saying:
>
> How about having [the still deprecated] --date=local (that is, DATE_LOCAL)
> option produce the old behavior, but have every combination of date mode
> options that does not involve DATE_LOCAL always emit the time zone.
>
> In other words, all of these do not emit a time zone:
>
>   --date=local
>   --date=local --time-zone=local
>   --date=local --time-zone=default   # --time-zone is ignored for simplicity.

Yeah.  It is even plausible to extend --date further so that we can
express things like

    --date='%a %b %d %H:%M:%S %Y'
    --date='%a %b %d %H:%M:%S %Y %z'

The former would be equivalent to --date[-format]=local, the latter would
be equivalent to --date[-format]=default.

Or something like that [warning: without morning caffeine yet] :-) 
