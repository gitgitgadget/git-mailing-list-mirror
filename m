From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.0.2
Date: Sun, 07 Mar 2010 21:13:17 -0800
Message-ID: <7vbpez4cr6.fsf@alter.siamese.dyndns.org>
References: <7vy6i3epg0.fsf@alter.siamese.dyndns.org>
 <1268020281.6298.5.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 08 06:13:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoVHZ-00081D-9H
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 06:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769Ab0CHFN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 00:13:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0CHFN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 00:13:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 541A0A0F9F;
	Mon,  8 Mar 2010 00:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/T9hVlIvGrya1Vn68Dm7Q0XPd94=; b=Gfh4Ox
	ahAwi3Evnny8dpYU+676gAwNWq8heKDKNzjkocywayW7c6/MY+sT/cyirNPE7nej
	dP4SlwtoFDqDOZ/FkVX5OOTiEp5da9M7VdzXaOtee+DwXRCBU6BEaBTYXZcm3H6x
	/X+K7muQj6GCH4knycFcp10b97bRhovn8suLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjJgBERblOavWdjQkYj3S19dS4I3ogYL
	Uz3P6MEvXyXJXxf8s95CIhrGjn7pCua5RUTMXF7xjfYmcuE9ozv6I8861tviJlxW
	YKt0kutx0dCei+KeA19bQuNyred0XLAnh9H3XHAuho76pwhUC12n3PPe7tvYJjQq
	PKOJO05E5cI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5C6A0F9E;
	Mon,  8 Mar 2010 00:13:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0D04A0F9B; Mon,  8 Mar
 2010 00:13:18 -0500 (EST)
In-Reply-To: <1268020281.6298.5.camel@marge.simson.net> (Mike Galbraith's
 message of "Mon\, 08 Mar 2010 04\:51\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 505257B6-2A71-11DF-BE7B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141751>

Mike Galbraith <efault@gmx.de> writes:

> On Sun, 2010-03-07 at 14:29 -0800, Junio C Hamano wrote:
>
>>  * "git bisect -- pathspec..." did not diagnose an error condition properly when
>>    the simplification with given pathspec made the history empty.
>
> Would that be what led to this somewhat less than perfect tip bisection
> result?

The bugfix was about the case where there was no change between the bad
and good commit with respect to the given pathspec, so I suspect your case
was irrelevant.

Your case probably was coming from that you originally suspected one of
the commits that touch tools/perf was a culprit, but because that initial
suspicion was wrong, bisection didn't find anything useful.
