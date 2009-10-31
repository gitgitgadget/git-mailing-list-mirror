From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Fri, 30 Oct 2009 19:09:17 -0700
Message-ID: <7vfx90co1e.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031014441.GH5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 03:09:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N43PN-000733-3e
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 03:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630AbZJaCJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 22:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757621AbZJaCJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 22:09:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbZJaCJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 22:09:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B32788CE20;
	Fri, 30 Oct 2009 22:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bKOH0wMidTIQoqieo2OeuLuwPXY=; b=VzOzMl
	csJoNyRRrJTSoQu5mB3WLwR/FgtR0OpstzD0C9E61f2ujUagEfi3jowu8hoDM+t8
	4vUKBBPXYnb4EGnfz8REFGPyysz7MTz2JGQFY3JrpZmKoWJgDhQGm02g6dfWyuxr
	m9Wh37WxZXKFEB5i5U1coBZ9lI0ijHt9viLcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YnvXSw8U+GeyiTtZcGSQ9okwGxs2XhBQ
	/1TuLdt3xxs08XZFnTjEwc6ktDgZXLP5j1ulNl900/hdqQoZqWzCyJuA8bRywAlL
	tPfFpripW8aRLZvnShIEfUHzBLewLKbGLqUHQ5VcYoOpD7ayNXlGeyenEbG2Q66S
	ajLTdguZx5s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F85C8CE1E;
	Fri, 30 Oct 2009 22:09:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC8578CE1D; Fri, 30 Oct 2009
 22:09:18 -0400 (EDT)
In-Reply-To: <20091031014441.GH5160@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 20\:44\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69A06A5A-C5C2-11DE-AA11-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131825>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +test_expect_success 'does editor have a simple name (no slashes, etc)?' '
> +
> +	editor=$(TERM=vt100 git var GIT_EDITOR) &&
> +	test -n "$editor" &&
> +	simple=t &&
> +	case "$editor" in
> +	*/* | core_editor | [A-Z]*)

Hmm, what are the latter two cases designed to catch?
