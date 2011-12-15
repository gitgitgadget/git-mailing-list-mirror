From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] wrapper: supply xsetenv and xputenv
Date: Thu, 15 Dec 2011 09:38:11 -0800
Message-ID: <7vzketohvg.fsf@alter.siamese.dyndns.org>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
 <1323871631-2872-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, schwab@linux-m68k.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 18:38:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFGF-0005SA-GH
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 18:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005Ab1LORiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 12:38:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987Ab1LORiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 12:38:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE6B71DF;
	Thu, 15 Dec 2011 12:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fbmu3Qxg/A7msQMH2rSPgYT+qW0=; b=lSt/gC
	Q3ISpPCmnLCD0BSQFLsHYnhBSnXsr9/bpemASvf+tjd2MzSwfZBoyR58B/bkUQAY
	YgWLpGN/daVjjfzrkU3tksxJjaFgtyjbfCx/Htl5PaOjJ/iw0OvKYyKFUPkzatO6
	+AK4pTJXU22iXN8IyVRvtsU4MzQe2biOEz0XI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+7wMnR+BYp2emm6w/06A4uZOfYMx+AQ
	itrwZxswppzliOq4KzDYAq70P5uSSLEu9swWygggKe4B1fkW8ObGquo+TYI+EGtC
	usPCtsr4U8nNdWbU8ACI3ACcn71dvqt0ZSEhjp10vxnCC+ykyF2awjxDmRzEzJS2
	oRHo62AtkGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D8C71DE;
	Thu, 15 Dec 2011 12:38:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C09E71DD; Thu, 15 Dec 2011
 12:38:12 -0500 (EST)
In-Reply-To: <1323871631-2872-4-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed, 14 Dec 2011 15:07:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FB600BC-2743-11E1-AB00-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187214>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> +extern int xsetenv(const char *name, const char *val, int override);
> +extern int xputenv(const char *string);

Actually, putenv(3) takes "char *string".

I adjusted 3 & 4 locally before queuing, so there is no need for resend,
and judging from the later part of the discussion, it seems that it may be
better to use only the first two patches from this series after all.
