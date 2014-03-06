From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 06 Mar 2014 15:39:43 -0800
Message-ID: <xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
	<xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
	<53183506.5080002@alum.mit.edu>
	<20140306155626.GB18519@sigill.intra.peff.net>
	<5318A537.4010400@alum.mit.edu>
	<20140306174803.GA30486@sigill.intra.peff.net>
	<08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
	<531904E1.6010606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhtH-00078n-IG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbaCFXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:39:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaCFXjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:39:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55D272776;
	Thu,  6 Mar 2014 18:39:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F87Pzp3Hnvrc0q26z9I3u8ZOJ1c=; b=rED9CM
	djBWVxCPZgqCvhZB38fqZhpLbny9AMqWrmAMI8qVoMyat+Yv35h5Ah5S1/q1cphV
	F9Wg853dI0HlWnWQao25jy153KvR/zSIjt0z4yAPO57Wo0WBx/3zxUFFIoYHpFnp
	cmJq4q1Q7m0frbN3RX5lWx5AB30X8cs3VQg9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ow/grgopp5fP2kVbvNP3hyuYTartB4eL
	2FgmqJFJu3PsS/UdNF/6s1uLwjv1w4/Cg97M0wQH8BpYQEQnBg1Xcl8J2NSdRbHY
	GirACHLc1qPKvDjE6qtLVTrfetBCySbF2cvleTwjT6IshA45aR3Ccu+7Hn7i+P5j
	WnVAjzrhn1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D063A72774;
	Thu,  6 Mar 2014 18:39:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F5372770;
	Thu,  6 Mar 2014 18:39:45 -0500 (EST)
In-Reply-To: <531904E1.6010606@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 07 Mar 2014 00:29:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 99761072-A588-11E3-88F3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243576>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I didn't mean to insult all Windows users in general.  I was only
> referring to the fact that since the default Windows command line is not
> a POSIX shell, even an experienced Windows user might have trouble
> figuring out how to execute a shell loop.  Putting this functionality in
> a git command or script, by contrast, would make it work universally, no
> fuss, no muss.

;-)

Be it graft or replace, I do not think we want to invite people to
use these mechansims too lightly to locally rewrite their history
willy-nilly without fixing their mistakes at the object layer with
"commit --amend", "rebase", "bfg", etc. in the longer term.  So in
that sense, adding a command to make it easy is not something I am
enthusiastic about.

On the other hand, if the user does need to use graft or replace
(perhaps to prepare for casting the fixed history in stone with
filter-branch), it would be good to help them avoid making mistakes
while doing so and tool support may be a way to do so.

So, ... I am of two minds.
