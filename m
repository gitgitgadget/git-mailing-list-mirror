From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 08:47:35 -0800
Message-ID: <7v7hridmjc.fsf@alter.siamese.dyndns.org>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100116203557.95340c00.rctay89@gmail.com> <20100116134656.GA4504@Knoppix>
 <20100116233043.26a5636d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 17:48:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWBoU-0006fM-Ik
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 17:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab0APQrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 11:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124Ab0APQrq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 11:47:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0APQrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 11:47:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02B1D91235;
	Sat, 16 Jan 2010 11:47:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bAHY/d16WM7TnaTuvaS4m+k4Bgo=; b=vI7XT8
	UFHvZeDgrZ+knTwNvQ1HpMqMkNjW/eFQ8hAJU47MXxruYlZBtfB7eJ55h+d7eyGE
	Sqm2Y/xeT9R26QFZu+OXILGhAEg6oxAYCi/yNCslcqjWoY2dYPHBSU3cQZQ1Hz7w
	X2vldzDy8+zhQC4tHpzUkcWAXD9AfW3gbSa/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HiyNHlqm28JCdDQXPUIb04F5iUP9EPqG
	bYLP2KArLvi8nhJvGpoJ5lUKiMrD6p520xMV7Sl0XwXraVbycfN3kOGh0tvkVtKb
	vu0AiTCotvPyJ+dn1cFxFBDZM3n8TB+dJut0M8R8M1N89Rvvwnv6XTHgB44wnVxy
	SH9x2IfFRtE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C215C91231;
	Sat, 16 Jan 2010 11:47:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12D059122D; Sat, 16 Jan
 2010 11:47:36 -0500 (EST)
In-Reply-To: <20100116233043.26a5636d.rctay89@gmail.com> (Tay Ray Chuan's
 message of "Sat\, 16 Jan 2010 23\:30\:43 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC4F9420-02BE-11DF-A4A2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137234>

Tay Ray Chuan <rctay89@gmail.com> writes:

> +		switch (ref->status) {
> +		case REF_STATUS_NONE:
> +		case REF_STATUS_UPTODATE:
> +		case REF_STATUS_OK:
> +			; /* no-op */
> +		default:
> 			continue;
> +		}

Could somebody document what these values (and what "struct ref" has in
general) mean in the transport API documentation?
