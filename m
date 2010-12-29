From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Tue, 28 Dec 2010 16:34:06 -0800
Message-ID: <7vlj39to1t.fsf@alter.siamese.dyndns.org>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino> <7vipydwp50.fsf@alter.siamese.dyndns.org>
 <4D1A7B42.1050907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 29 01:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXk1V-0001fj-JA
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 01:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab0L2AeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 19:34:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab0L2AeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 19:34:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7CF13655;
	Tue, 28 Dec 2010 19:34:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ea40pza4y33iS9SQrORQj2v6zaI=; b=S4RAjd
	5IKmaiHR4vhMKrFq/Pj3I5P/4+AXpartolWQ0xrp4NNynevZ7/OTGS8a+bFAZnqK
	RxbuahraNpEPd2S6PQ8fA/XPJZrslnvmFGWMKqFnpWJJLqlZHkx5GT03d05QFfZD
	GNLUzBMoONQKoVnB5OS6wzx6/kL30Q1uiE7zk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VmfZkRCUI/XnejaWoQxFjdj2pbNxksKG
	NQVYwJ2lPOXluG0m9pXgOlTM+zAMNxPxuvaryx3ywRLE4aChQ9O4MKxBfF8uqsBI
	OFJCgeHNTq1to1+1gEpgrzLbVX+s4brk2ZJJr7JKvbyHXTJFOXpR1c30NYBKDXHC
	jgIyOEvOeys=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82A2F3651;
	Tue, 28 Dec 2010 19:34:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99760364C; Tue, 28 Dec 2010
 19:34:41 -0500 (EST)
In-Reply-To: <4D1A7B42.1050907@web.de> (Jens Lehmann's message of "Wed\, 29
 Dec 2010 01\:05\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71A8458C-12E3-11E0-B372-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164299>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> But doesn't this change only affect the case where the submodule is
> freshly cloned, so there is no chance of losing local changes?

My fault, for not looking at the surrounding context.

> (But AFAIK the patch doesn't really fix the issue, please see [1] and
> Jonathan's followup)
>
> [1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/772659/focus=163242

I think we queued the later round just uses "checkout -B"; shouldn't that
work?
