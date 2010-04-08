From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Wed, 07 Apr 2010 22:05:12 -0700
Message-ID: <7vochu8rg7.fsf@alter.siamese.dyndns.org>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 07:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzjvm-0004cs-3L
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 07:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab0DHFFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 01:05:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab0DHFFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 01:05:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47EC4A9177;
	Thu,  8 Apr 2010 01:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4I/vMWLmIG1njGTG0wUUArYUSHM=; b=WT+DGC
	oFpeiAVf3V3o4Sjo/NhfXX6IAxmZgoBhwtYc/VQQWdCSwBSb0QEXx4EzlQXB1vXj
	VsPXxFtmI3zLbfVbkmw9efjvZCbbAjGJFdZ+7PZT7qbpFyBq9fTdjycWuQXWZc1H
	Kuu+Rx2HrXw/hA+aR9tvE7s0ZYxMCaHDI7ywg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOYEA1TKr4SRrBQjAcPmnt2l4fFwuzFR
	t0ogRT7zB6FzJiag/QxAGucpxQIIOYTIU4StKKDOFflKK6vhIJkzkO8eQxPLNJf+
	bQrNPchtLs0rkIpViSXLdl7YVcigZ1QVT/7o2HMDhhtOINwruexxiLTqp7rTJtQO
	QxxBvQQ8i8Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CE33A9174;
	Thu,  8 Apr 2010 01:05:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12E83A9171; Thu,  8 Apr
 2010 01:05:13 -0400 (EDT)
In-Reply-To: <1270699083-5424-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu\,  8 Apr 2010 11\:58\:03 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 539F507C-42CC-11DF-B055-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144315>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Instead of breaking execution when no remote (as specified in the
> variable dest) is specified when git-ls-remote is invoked, continue on
> and let remote_get() handle it.

Shouldn't it default to "branch.$current.remote", not "origin", though, as
ls-remote to inspect is most closely related to "git pull"?
