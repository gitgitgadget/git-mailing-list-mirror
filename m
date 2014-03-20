From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Thu, 20 Mar 2014 10:36:20 -0700
Message-ID: <xmqqbnx0zsa3.fsf@gitster.dls.corp.google.com>
References: <1395300220-7540-1-git-send-email-zhaox383@umn.edu>
	<vpqd2hh5j7k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yao Zhao <zhaox383@umn.edu>, mhagger@alum.mit.edu, peff@peff.net,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:36:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgtK-000573-7R
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbaCTRg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:36:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbaCTRgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 13:36:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B48376DB7;
	Thu, 20 Mar 2014 13:36:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5wWUBlwlnKnMPNi8R4y6YFfCyoU=; b=YPaD+h
	uXoQxGPRWSycAJM9YNvjdiGir7vHd1poO82rp8Y1+yM8UOirJk0GSIBP6xKCIOn0
	3sxhoXMs7rXrB3n2XfUbE3bb0RiGQuuiEfF0K8FUGqk0ZT/jPEQGV5fpMnSWmWcb
	TA6sw9y3pEwz1rb5HyipqFo5DRp31TWOeYZTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KH4+iPeYbhQHI/8nyhvIP56/2fVfZQtL
	GcrpckReO6i9HvygFu3Zn//pCZMZuqK+I9G/U2s9iKS2FD9u3fx9sIO8hrn5V/82
	vzFlHTiCWotaaUwWSwX0YJdzz3EcxL17ieABAd0anSEjD207FnmHCf/EHN4qp+lO
	hZKMS0o+mZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6706176DB6;
	Thu, 20 Mar 2014 13:36:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79A8476DB2;
	Thu, 20 Mar 2014 13:36:22 -0400 (EDT)
In-Reply-To: <vpqd2hh5j7k.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	20 Mar 2014 10:10:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 276207A6-B056-11E3-9D8F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244563>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Why?
>
> (In general, explaining why you chose something is more important than
> explaining what you chose)

Good educational comment.  Thanks.

> A tree (AST, Abstract syntax tree) can be interesting if you have some
> source-to-source transformations to do on the configuration files (i.e.
> edit the config files themselves).
>
> For read-only accesses, I would find it more natural to have a
> data-structure that reflects the configuration variables themselves, not
> the way they appear in the config file.

... and one important thing that was left unsaid is that the
read-only accesses happen far more often than updates, so the data
structure must be optimized for the read-only look-up case.
