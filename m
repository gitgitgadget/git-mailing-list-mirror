From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 07 Jan 2014 14:27:28 -0800
Message-ID: <xmqqmwj7bf73.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
	<20140107205618.GA28102@sigill.intra.peff.net>
	<xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
	<20140107212432.GD28102@sigill.intra.peff.net>
	<xmqqr48jbg6j.fsf@gitster.dls.corp.google.com>
	<20140107221719.GE28102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:27:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0f7a-0007Y6-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbaAGW1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:27:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbaAGW1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:27:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5748614C5;
	Tue,  7 Jan 2014 17:27:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6D5P75uZhvYoGxAwMVjXaS8Di/o=; b=tcwHIt
	SQmq3z1+mAGhPHAfVOp5OCE8p4r5N0kpoC0uxPB+EDzwb+0pyax7P1FiTQgi0fde
	5Vup31AbjrpPl8N3/YpTxsJPnmUBTGEIXXBW3x2ZSdsnh3HBSWXcwV56khg+yOUH
	C+jzbYQigUeOiaGmXIDpy9oPtfzQL6Fngv9k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eo4IQN2j8vJ2SVET7xnAfbkjini6nwcb
	EQH6pkZeN6pHClbyl3wtTjhb8YQCe7Rxs2yGfxpqrI7K0wjHlVS5+sRWKBwS87lq
	1CYp/SUGDW3I9bs3RKdoHnf6ZghxmfZVQnpnzLjN9IYE1bE500H0ODjzXbu27Lz1
	QCkOI8XNP+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C121F614BE;
	Tue,  7 Jan 2014 17:27:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96746614B9;
	Tue,  7 Jan 2014 17:27:31 -0500 (EST)
In-Reply-To: <20140107221719.GE28102@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 17:17:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E602F28C-77EA-11E3-A6E2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240175>

Jeff King <peff@peff.net> writes:

> And even in a centralized workflow, I see "upstream" creating problems.
> E.g., you fork a feature branch in the centralized repo; it should not
> get pushed straight back to "master"! And that is why we invented
> "simple", to prevent such things.

Oh, don't get me wrong.  I personally wouldn't imagine forking
'topic' from the shared 'master', call the result perfect and push
it directly back to the shared 'master'.  But the 'upstream' setting
was added exactly to support that.

In such a case, I would have 'master' that is forked from the shared
'master', 'topic' that is forked from my 'master', and pushing back
would be a two-step process, first updating my 'master' in sync with
the shared 'master', merging 'topic' into it to make sure the result
is sane and then push it back to the shared 'master'.  And in that
set-up, 'upstream' would work fine as the upstream of my 'master' is
the shared 'master', even though 'current' or even 'matching' would
work just as well.  So in that sense, I do not see 'upstream' as so
broken as you seem to be saying.

One gap in that line of thought might be that I am sane enough not
to attempt "git push" while I am on my 'topic', though.
