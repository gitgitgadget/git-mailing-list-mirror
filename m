From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 09:21:01 -0700
Message-ID: <xmqq7gf479jm.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<201308290932.18199.mfick@codeaurora.org>
	<521F6CF0.6040905@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 18:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4y8-0005H0-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 18:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab3H2QVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 12:21:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab3H2QVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 12:21:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482C03D94B;
	Thu, 29 Aug 2013 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RjMZEJfKj7LOHSkTC+ZtTILDEqI=; b=dQzVPr
	SOErwtLgMYeVeuUs0ZHRd0w4QI+HHHK4gvgcvvGATonT30fnjTZH788PD8Tk5cb7
	i7yE+4RQ9Imb8Xs2JC5P0gEFf19kMraBQtHAxLGwGitX2vOsLbIF9YswyXboUM6X
	VM/LCFxOpzRfqcsOnhwUenLCtVLKcY+kELns4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IuGQEFDMFMMtDHO92MFr7lYG5p45c5mX
	YkC0rznNqf9fboB5zzVq8EswwKmFg+uno7rm0KUrq5+eqW6vrM+Nm+i9MdQmKZ8X
	e30KQDylhZvsntCXRFjq53UirS3EkbjdgxwbXQrlheGxC4Jg+YpAbktch+i3SJ40
	jwq95Kpxhto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F17F3D94A;
	Thu, 29 Aug 2013 16:21:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71CF33D946;
	Thu, 29 Aug 2013 16:21:04 +0000 (UTC)
In-Reply-To: <521F6CF0.6040905@kitware.com> (Brad King's message of "Thu, 29
	Aug 2013 11:46:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 008951B8-10C7-11E3-A5DE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233284>

Brad King <brad.king@kitware.com> writes:

> Nor should it in this case.  I was saying that the front-end
> needs to reject duplicate ref names from the stdin lines before
> trying to lock the ref twice to avoid this message.

How about trying not to feed duplicates?
