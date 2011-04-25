From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: unify documentation of test function args
Date: Mon, 25 Apr 2011 12:31:24 -0700
Message-ID: <7vzknei0vn.fsf@alter.siamese.dyndns.org>
References: <4DB4010B.6080804@debugon.org>
 <7v62q2l3ft.fsf@alter.siamese.dyndns.org> <4DB5BDBE.308@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QERVT-0002uB-Ey
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 21:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762Ab1DYTbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 15:31:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758629Ab1DYTbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 15:31:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65B715BA5;
	Mon, 25 Apr 2011 15:33:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qijUk1UHX/Z/WYVt3+1AcBxa2tw=; b=spijqW
	09aA1w3NuBjdZ+Oasg+M5O7GpOKotuRxfRy1KSZYdpPRlT4Tv88amHBYyCQT674X
	3OrzgyLESDe2G+Hth/jXsSKkhtT2I8mlal/mxuKhLp0515PZZkXT9BVOirTP1sn7
	cmp+H3Bna/cH0ez1eU+2lEWKXkk8u5YPuOgv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FLcpkkHXONKgN6ZFFQk3lCzJWRVwA75c
	QbISqi7LddlmrB5s81R5F5m8KztEEuUYT5CgPf/OeEeo+6XLhRMwa6xgPANvG1h5
	0Dxs0s7O13+Xlg9GVg/3NUCow4UTknWheh/3H5zBEqWCYYDtslZn4m58eCIvLG4R
	cKwwkfkzqxc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37D3F5BA4;
	Mon, 25 Apr 2011 15:33:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 594415B9D; Mon, 25 Apr 2011
 15:33:28 -0400 (EDT)
In-Reply-To: <4DB5BDBE.308@debugon.org> (Mathias Lafeldt's message of "Mon,
 25 Apr 2011 20:30:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6DF2C3A-6F72-11E0-89C6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172040>

Mathias Lafeldt <misfire@debugon.org> writes:

> Ah, okay. Is this true for test_expect_code too? It also has a git command
> in the example, but it says <command>, not <git-command>:
>
>  - test_expect_code <exit-code> <command>

I think that one is Ok as there is no git specific hacks in the semantics.
It is a straight "Run this command, and make sure you get this exit code".

The "must-fail" is really a special case in that we just do not expect any
failure, but expect a controlled failure.  Currently we only catch segv,
but we should anticipate that we will reject other types of uncontrolled
failures in the future, and keeping the function "git-only" makes it
easier to manage.
