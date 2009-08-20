From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test case for rev-list --parents --show-all
Date: Wed, 19 Aug 2009 21:13:58 -0700
Message-ID: <7v7hwzt94p.fsf@alter.siamese.dyndns.org>
References: <1250628954.114121983@192.168.1.201>
 <20090818211812.GL8147@facebook.com>
 <7vk5103chi.fsf@alter.siamese.dyndns.org>
 <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com>
 <7vhbw41g3f.fsf@alter.siamese.dyndns.org>
 <7v4os41frm.fsf@alter.siamese.dyndns.org>
 <20090819225547.GR8147@facebook.com> <20090819225852.GA21187@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Adam Simpkins <simpkins@facebook.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 06:14:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdz2Y-0007k8-0b
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 06:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZHTEOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 00:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZHTEOH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 00:14:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZHTEOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 00:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B614711B0E;
	Thu, 20 Aug 2009 00:14:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=golR67WIwTUICm+G4jAC822WAOc=; b=gv0yfGRbNJRGebKTuGi9uAv
	bKQ3GecmJtTeLNcoU1MZrXDrLWgp6GbO9W2CQtnGfWEhFtE2DaoJ7/3sMn/Ezhnm
	L7bWnHdGjSAo2XFzoVWIqSdfBZksYi6f5GM2jrhgcIikqX7udIl/K1GbOiavFufN
	DHV8uH6fasKPxWFjmfHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QCJZap3cCz9E6bQSoiHpk9SPTHvB6JQhYzplnFpEV+MP2nfNM
	GR0jDx13+/wMVySaeTGG0n8MXFePSCM9csoz7fMBlilMSK5w0Qfm8GZmKSxViQ1h
	0akJiuoRkrIrb7ik0KmWoCkzyzhf3XYBsZyKoj75X26JWnW80k1BKH9uXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A8011B0D;
	Thu, 20 Aug 2009 00:14:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0A5A11B0B; Thu, 20 Aug
 2009 00:13:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5318DB8-8D3F-11DE-8F65-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126608>

Adam Simpkins <simpkins@facebook.com> writes:

> This test case ensures that rev-list --parents --show-all gets the
> parent history correct.  Normally, --parents rewrites parent history to
> skip TREESAME parents.  However, --show-all causes TREESAME parents to
> still be included in the revision list, so the parents should still be
> included too.
>
> Signed-off-by: Adam Simpkins <simpkins@facebook.com>
> ---
>
> Looking through the code, I believe TREESAME commits are the only ones
> affected by my earlier bug in simplify_commit().

What I meant was actually a test for the graph part (i.e. the problem we
would see if we did not apply your update to graph_is_interesting()), but
protecting the simplify_commit() logic with test from breakage is a good
thing to do as well.

Thanks.
