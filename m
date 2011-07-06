From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Wed, 06 Jul 2011 10:24:57 -0700
Message-ID: <7vpqlnmidy.fsf@alter.siamese.dyndns.org>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 19:27:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeVsJ-0003bY-NG
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab1GFR04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 13:26:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab1GFRZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 13:25:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 358054CF2;
	Wed,  6 Jul 2011 13:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=98YLpkv6aM9ssffJe0KnulgK5GQ=; b=AkRLyi
	a63I+SSx/DVt8zGBJ5402AepbHk3ztBPRsnS2NcO88nQhA9n50UGrO+R/yyfoi3K
	ozpBKT2bAr76Dm/VEvNqpOJepfhdLnwLuIz63Xd7q8ylm6LfzIPhgWtL0f/KEh7f
	1Aau1atZ8LSdbLpuJpqebulDXO2DIczXgyiaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4gehsGLZCQuK+2/4AW09npzErwYgCEN
	fjjUUaZuLVxKxWGxn+ibaE/lle9wWHcelfVz5wqG8MZu/Xfg8fn+UQBytssRTL91
	8jOAiGhU+4jsWkurPm8q+fmnTPsBuhEJWKd6mgynMqvAQqJBZ3QHqSMlQwV10fkC
	FCMjiC94IsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D83E4CF1;
	Wed,  6 Jul 2011 13:25:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8B3974CF0; Wed,  6 Jul 2011
 13:24:59 -0400 (EDT)
In-Reply-To: <20110705231604.GC12085@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jul 2011 19:16:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E029B97C-A7F4-11E0-ADC4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176715>

Jeff King <peff@peff.net> writes:

> I'm not all that happy with the advice, though. It's pretty technical
> and specific. I'm not sure whether it would be helpful to most users or
> not.

Yeah, Michael's rewording makes it fuzzier by saying "exists, unable to
execute, maybe git-%s is broken?".

I notice that we do not give the path to the file that implements the
command. Perhaps we should walk the $PATH after we see this failure to
pinpoint which one is to be inspected (I vaguely recall a weatherbaloon
patch to a similar effect)?
