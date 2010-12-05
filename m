From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 05 Dec 2010 11:54:00 -0800
Message-ID: <7v8w04vvvr.fsf@alter.siamese.dyndns.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <20101205073938.GB15233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aleksi Aalto <aga@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 05 20:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPKf3-0002F4-Qi
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 20:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab0LETyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 14:54:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0LETyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 14:54:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AE14345D;
	Sun,  5 Dec 2010 14:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRYhWh9GLCExFTsKYGOiDinXVQ0=; b=ZvLlm8
	Y5YYfS1UtZGbRzckpCaNGv2gctE/kwaq/dNW3CSUwE7j0y4IQ6qtBFGwA4tpkxz+
	xLg1xcCR/YOwlwekG/1TPmXp5GGbn/qzCN9Hqo6eWhmrZVWOu5nhnlnPkpjk1+Yr
	wj6efKXeIUHqtl9s6FTDPkS3CrwTTH2jvsbvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xoBscHCF6sVYq53cAVHKuKCyqyUUlIfc
	Vw31Vadjli1Q5RhtWrZ8pWEJgXW4TlBmbMQcUeHOEa6EmAjSpGRZ9qe+SXjK50MY
	tb3skIyx+o91t2dkjFbdXjV3YOVOsWQ6Cv1/ftWG0Ya85iYnlw0bnaRyG12RLAHt
	b7ndoJuZsic=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC9FC345C;
	Sun,  5 Dec 2010 14:54:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC270345B; Sun,  5 Dec 2010
 14:54:23 -0500 (EST)
In-Reply-To: <20101205073938.GB15233@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 5 Dec 2010 02\:39\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 77BA6ADC-00A9-11E0-A465-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162957>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:
>
>> * aa/status-hilite-branch (2010-11-18) 1 commit
>>  - status: show branchname with a configurable color
>> 
>> I am indifferent/uninterested; I don't see anything wrong with it, but I
>> do not find coloring the field particularly useful myself.
>
> I am not particularly interested, either, but FWIW, the gitcommit syntax
> highlighting that ships with vim does highlight this, so there are at
> least other people who think this is a good idea.

As you already know, when I say "'Meh' personally", I am not saying "I
want to forbid others to want it".

How does vim highlight the other parts of that particular line?  Does it
keep them intact, or paint them in some other color?

> However, I'm not sure about the default. The original patch defaulted to
> magenta. Your fixup defaults to "plain", but that is a regression
> (albeit a minor one) for people who have status.header set.

This patch is a regression for them either way, isn't it?  Except for
those who chose to use magenta to paint status.header, that is.

I had this suspicion that the class of people who choose a non default
status.header color and the class of people who choose plain there (or
have been happy with the default) expect different things.  The former
prefer louder output, different pieces of information painted in different
colors to help them chromatically distinguish them.  The latter (including
myself) favor subdued output, without too many colors distacting them
while reading the output.

This suspicion further led me to think that the former would want this new
feature to paint the branch name in a color different from status.header
color, while the latter would want it in plain.  So the default of "plain"
would be a win for both audiences.

Another thiking behind "plain" is that it avoids using "magenta" which we
didn't use in the default colored output from this command.  We have been
trying to make the default coloring not too loud, and keeping the number
of colors used low has been one way of doing so.
