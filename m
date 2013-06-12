From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] finish_copy_notes_for_rewrite(): Let caller provide commit message
Date: Wed, 12 Jun 2013 10:27:53 -0700
Message-ID: <7v8v2f5jdy.fsf@alter.siamese.dyndns.org>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 12 19:28:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umoq0-0004R8-9b
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 19:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230Ab3FLR14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 13:27:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388Ab3FLR1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 13:27:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3522512D;
	Wed, 12 Jun 2013 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q6XBc4HizbvgQV8s62NilJ54uMc=; b=MGT7+H
	gbiPgR1737POD08ube0eDlFqZbcMrT3f1p1YCpD5q2ygR3X69UJTfYNw4svEdY+i
	sQz62UIcH+xUE06r5e1JdiaG/et3c7a24b1ctqyYAK2xynFJ7zQ/9+Tcp/zTCjyM
	45SvwI5QEXtvVfx2rEI2UN3fyDkjiMVpJ5k20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyughd61oxkXBgFxslOyTmMIuODzfm2x
	Ku8+i2FNuk6MKn1iXZqP0wTEZHiR1CkX7WVh+vvJGnGBDtVjU+MUGuA5LxMevoV+
	xzUB40gOyyJumi/dtDi1XPBLD2j2l4J7Wn2NRCoRNy/gkPQJtspHGmikPqCxKKC5
	aRVG2kDkq3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D1EF2512C;
	Wed, 12 Jun 2013 17:27:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A1852512B;
	Wed, 12 Jun 2013 17:27:54 +0000 (UTC)
In-Reply-To: <1370995981-1553-2-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 12 Jun 2013 02:12:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A7D55D0-D385-11E2-9F61-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227659>

Johan Herland <johan@herland.net> writes:

> When copying notes for a rewritten object, the resulting notes commit
> would have the following hardcoded commit message:
>
>   Notes added by 'git notes copy'
>
> This is obviously bogus when the notes rewriting is performed by
> 'git commit --amend'.
>
> Therefore, let the caller specify an appropriate notes commit message
> instead of hardcoding it. The above message is used for 'git notes copy',
> but when calling finish_copy_notes_for_rewrite() from builtin/commit.c,
> we use the following message instead:
>
>   Notes added by 'git commit --amend'
>
> Cc: Thomas Rast <trast@inf.ethz.ch>
> Signed-off-by: Johan Herland <johan@herland.net>

Makes sense.  Thanks.
