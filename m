From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 3/5] t4205, t6006, t7102: make functions better readable
Date: Fri, 05 Jul 2013 11:38:30 -0700
Message-ID: <7va9m07syh.fsf@alter.siamese.dyndns.org>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
	<77116508da1bf88e6035cbd657c401cf96b08cbb.1373024281.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:38:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvAtx-0003DR-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750Ab3GESie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:38:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607Ab3GESid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:38:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3FC2B11F;
	Fri,  5 Jul 2013 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/pPX5MtSbB/ftBVavDkq8daJWzc=; b=Najq3/
	Fw6ZIxZToIrQFx3RX99IYy35/7vAQ5/+QAKaZxzM6DLEPGXSXE2vPFzbnEbahRSn
	5pQldr0sDVZV7qGd581xhi3JLcZk8QdDMzPJz47V3BAyaNs4dejaj06YAIB1OxVV
	Y5eNRPpQma2otJ4R2MHxw/XJcvY2ov9yKI2AI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppLtlZL6O16qPdf+VfnLi5TZcFzyjiQq
	IWdIp/gJ0Tpkogd3aSaSYiW4LOl/BG2lAASfggiYH8KL2Yhk0YgDGTtgVMLh7O70
	S9DnIee/b1fjaql1tXGnePFojYTbF2UPipO9PXwKIVACTdDEgUpwJv+akFAXHl5U
	2t0VPlFPWEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3CD82B11B;
	Fri,  5 Jul 2013 18:38:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 330632B115;
	Fri,  5 Jul 2013 18:38:32 +0000 (UTC)
In-Reply-To: <77116508da1bf88e6035cbd657c401cf96b08cbb.1373024281.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Fri, 5 Jul 2013 16:01:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17DAF024-E5A2-11E2-8F01-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229675>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> -	msg=$(printf "modify 2nd file (ge\303\244ndert)")
> +	msg="modify 2nd file (ge\303\244ndert)"
>  	if test -n "$1"
>  	then
> -		msg=$(echo $msg | iconv -f utf-8 -t $1)
> +		print "$msg" | iconv -f utf-8 -t "$1"
> +	else
> +		print "$msg"
>  	fi
> -	echo $msg
>  }

I think I'll do s/print/&f/ before queuing this.

Thanks.
