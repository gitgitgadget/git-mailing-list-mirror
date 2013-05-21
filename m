From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: barf when user tries old:new
Date: Tue, 21 May 2013 09:32:42 -0700
Message-ID: <7v7gisqonp.fsf@alter.siamese.dyndns.org>
References: <1369098165-8727-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 18:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UepUX-00065s-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 18:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab3EUQcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 12:32:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab3EUQcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 12:32:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8E1420D00;
	Tue, 21 May 2013 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TQYlPJNHYgNaa6UXLnk9ugO5HRs=; b=NvzLly
	toBXfS81+UKSX97QDDKU0rr5xzNPUAsjew3a6+4qHbz3gC12UpEZ0I6AXOXvcdXj
	nletMadAoENlGZlwO5i+nth6oGe8lPyHBp1E1ZGMFLHX7jg7Kj+cZeWtiSdfFcCt
	L2nedFbY4sjQXR79g5TFn3yjOLPvdhzMUIBLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hoEKSFFiUZd0HRgc/JLAS0K24Y8SwJ4a
	WJqfOoxyN1++RNjE2bFa4jZdwHZWuXxh5Dtlg3kkfpg4gwbbsmDpgXQxWGRXaw/T
	+0VJU8UcggUmfNn4wUPg6g2wYU4cFai63mxVPNQBfZGJZ7CYVwrUfc+4TDUwmTII
	6tcEdSGy998=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C108220CFF;
	Tue, 21 May 2013 16:32:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41A2020CFD;
	Tue, 21 May 2013 16:32:44 +0000 (UTC)
In-Reply-To: <1369098165-8727-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 20 May 2013 20:02:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10570E96-C234-11E2-BE2D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225038>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise with certain remote helpers (the ones that support 'export'),
> the users will be pushing to the wrong branch:
>
>   git push topic:master
>
> Will push the topic branch, as if the user typed:
>
>   git push topic
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> I won't
> bother rationalizing if this makes sense for 'master'

As this is a change to an old code/behaviour that was with us with
many released versions, it hardly is for 'master' during -rc period.

I think your dry-run one (the reroll) is a good fix but for the same
reason I'd rather see us apply after 1.8.3 final.
