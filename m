From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Fri, 19 Apr 2013 10:25:46 -0700
Message-ID: <7vbo9a3011.fsf@alter.siamese.dyndns.org>
References: <20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
	<20130418172714.GA24690@sigill.intra.peff.net>
	<7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
	<7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
	<20130418214427.GA10119@sigill.intra.peff.net>
	<7vobdb4hii.fsf@alter.siamese.dyndns.org>
	<20130419043142.GA5055@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTF4P-0007TP-HM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3DSRZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:25:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707Ab3DSRZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:25:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D676215528;
	Fri, 19 Apr 2013 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNNOCnCHHrKp6r1/3TPSIS7TpIo=; b=UGTjDh
	W1cswvS6AFfZPqepeVsm3ZoxR3j5mbGWXsRIHfIP+zgE2kk8jKHsO0CoOsa8dHSl
	Xs+tvJZrYlTroUFtwDJQZzXm0Fz5CCMTG32VEWHffPOKRJ0ZPrxr8awWRmBLFbe4
	14HMCjuGLx6BkUvAzsasHDFsD+ggLz5CvVTuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PklUpdMCw/5lrFq1Fh90wvYMAuMhKZ2M
	gIWl5pFMZMmof1YxqDuOlpUteSXx8pDQpy1XMQFIh8367KdD70usNKXVVuqSY1UD
	BJ7XVXmOHxWC6flmDT5zEaycJ1f714tjwB2dUylQfvTnp8c5JWiDU4xk7YkYKRnL
	R1oN3UgKvo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA37715527;
	Fri, 19 Apr 2013 17:25:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3514915526;
	Fri, 19 Apr 2013 17:25:51 +0000 (UTC)
In-Reply-To: <20130419043142.GA5055@elie.Belkin> (Jonathan Nieder's message of
	"Thu, 18 Apr 2013 21:31:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EB11B34-A916-11E2-91F1-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221781>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
>>     behaviour will change in Git 2.0 with respect to paths you
>>     removed from your working tree.
>>
>>     * 'git add --no-all <pathspec>', which is the current default,
>>       ignores paths you removed from your working tree.
>>
>>     * 'git add --all <pathspec>' will let you also record the
>>       removals.
>>
>>     The removed paths (e.g. '%s') are ignored with this version of Git.
>>     Run 'git status' to remind yourself what paths you have removed
>>     from your working tree.
>>
>> or something?
>
> That looks good. :)

I think the direction may be good but the above is too tall to be
the final version. of the message.  Somebody good at phrasing needs
to trim it down without losing the essense.
