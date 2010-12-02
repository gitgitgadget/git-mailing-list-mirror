From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cherry.txt: Change symbol marks in graph.
Date: Thu, 02 Dec 2010 09:25:37 -0800
Message-ID: <7vy688rsry.fsf@alter.siamese.dyndns.org>
References: <1291267093-29855-1-git-send-email-jari.aalto@cante.net>
 <m31v604nc0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:26:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POCuq-00033h-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118Ab0LBRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:25:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab0LBRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3454037A9;
	Thu,  2 Dec 2010 12:26:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QTyfou5D0AdgBObA+QAp9+W4e6o=; b=DD9m19
	TuigfBlzQntnQc5pFgXb+AZQQaTK0XFubx0P7EXiygC1XLep32DhUIdZ4EQ3GRHS
	jg2HjEc6s4NIWo6DQy6DEAQ6ZQ+a6izDhA8KczyL0kKrDZJbU36/FmGWsLVf7PRP
	gFRGawySNSPnz93H5FA8aV/rmGFclBg8cBJe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J66Zm7sX3fvG6/xhf1T41qMt9xE/NQeo
	0LXSPNLprF38QM3dTaVZ43XqTO+je8OmwmwLJ6mhy7jXSeVKvUdYsXLzQGxd+TG8
	QXhRsoPJXSgAOOoJ45e/EPLkq2JtI5GJFS6dANw69iamr5YNTNlOXRBuWE9y5A31
	ulr+SRo1kHo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01F6137A4;
	Thu,  2 Dec 2010 12:26:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BED3379E; Thu,  2 Dec 2010
 12:25:58 -0500 (EST)
In-Reply-To: <m31v604nc0.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 02 Dec 2010 00\:00\:13 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D3BBB3A-FE39-11DF-AF44-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162711>

Jakub Narebski <jnareb@gmail.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> From: Jari Aalto <jari.aalto@cante.net>
>> 
>> The common commit were marked with a minus sign (-), but that is
>> usually interpreted as something less or substracted. Use natural
>> equal sign (=). Commits that are not in upstream were marked with plus
>> sign (+) but a question mark (?) is visually a litle more striking
>> (erect) in context where all other signs are "flat". It also helps
>> visually impared to see difference between (* ... ?) as opposed to
>> similar signs (* ... +).
>
> Reading comprehension FAIL.  The graph in question uses '+' and '-' because
> that is what 'git cherry' *output( uses ('+' included, '-' excluded).  They
> are very natural in git-cherry output (diff-like).

Well, cherry's output is not "diff like".  '+' is what you need to keep,
as opposed to '-' that marks a commit that needs to be dropped from your
side.  If it were "diff like", '+' would have been spelled with a single '
', but then commits on the other side you do not have need be included
with '+' mark.  However, 'git cherry' is not trying to produce a diff
between branches; it does not matter what extra stuff the other side
contains.

I however do agree with your conclusion; '=' is not "natural" in the
context of 'git cherry' at all.  "You need to drop this" comes more
natural with '-'.

And obviously, the illustration in the documentation uses the same +/-
that appear in the program's output.

So any change along the line of Jari's patch would be a dis-improvement.
