From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 04 May 2011 08:47:30 -0700
Message-ID: <7vhb9afox9.fsf@alter.siamese.dyndns.org>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <4DC112A1.5090805@drmicha.warpmail.net>
 <20110504085014.GA9739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 17:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHeIl-0003jE-QK
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 17:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab1EDPrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 11:47:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1EDPrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 11:47:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1EC65B18;
	Wed,  4 May 2011 11:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3mPX17MNJUaLtXRIGk7miIeHcRw=; b=Mwt8i/
	apvqqrS2ukQeK3+qci7cUhmYKGRKY+qjeso1HKBonC0Iue/DLNOhmNaORmRpvFcr
	xEVVY4Q1F9bZCkEpB7OHSCe9LCvJSN0zQVLLH7r7/Cvt+SsZVWL0Lq8+Wo/+5omx
	iEn8Jxlk8EkerEbj7Ba1gzQbYAzbHXpAEIGgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nbj31VboxDplvMIj/1W5DLCgF01mZFC1
	/vLmI6aRkwPoBHryMYeEGYRfQhTI6oKP+D/kC3dGFGk0esDaWDBHyeLeqK5QJeZd
	cam9N4uSjaLlxzBIS8LraVdF4VR/65YCPTfa47A58S0Hp/bpyA6PFtPxk87OjMJi
	leG4ofu56jY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E2335B17;
	Wed,  4 May 2011 11:49:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 44BE55B13; Wed,  4 May 2011
 11:49:34 -0400 (EDT)
In-Reply-To: <20110504085014.GA9739@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 May 2011 04:50:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EA0B36A-7666-11E0-97B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172749>

Jeff King <peff@peff.net> writes:

> Check out some of the older scripts in contrib/examples. Several of them
> require_work_tree, but do not cd_to_toplevel immediately; instead, they
> do it much later for some specific bits.

Another datapoint I found was "clean".

It used to say "you have to be inside work tree" in the scripted version.
Imagine what builtin/clean.c does today?  It has NEED_WORK_TREE bit in the
command table in git.c and that bit means "We need to have a work tree
that we can later chdir to if we wanted to".
