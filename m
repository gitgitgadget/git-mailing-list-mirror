From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (Ab)using filter-branch from a post-receive hook
Date: Sat, 14 Jul 2012 23:44:39 -0700
Message-ID: <7va9z15xrc.fsf@alter.siamese.dyndns.org>
References: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com>
 <7vipdp61fp.fsf@alter.siamese.dyndns.org>
 <CEAB8F11-05A4-46B4-A0B5-B51B14EAD536@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 08:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqIaJ-0007sQ-Qr
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 08:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab2GOGoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 02:44:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2GOGoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 02:44:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B600576C9;
	Sun, 15 Jul 2012 02:44:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQ18BzHNK955Lepfp1Sm7tcYNBo=; b=VOxdvA
	OCw238BJe7/yPjCvJqKWawg7qgmMSIfvzsWI0lPaP6G5o5BaTaBlQlGbAAfqw1Fz
	vrCzbyewGde2Sjr5Q9EWuHwhbolQ3cXCKDHjaJLsQZaLWVc9ivdrUet1jnykO45D
	zP3A0JgyXwxall12dgbKhsXKiWeh+J1OLdO98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sj6jnyezzy4EhJU1hoTkFVBKC66xFmyW
	IDcGiDziw6zI+Uad4Dt022MyAFIsngZvaoMXi0EPgquWAt66/QgAXq6qdfJyH0sT
	a6nlrTgk0CyX7beofCNkaa0OgzgwNpiNk1GpKUklkzDCHfbdqvBFbYMQ+YAjMB+o
	UNZRWZLyGdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D86476C8;
	Sun, 15 Jul 2012 02:44:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07AB176C7; Sun, 15 Jul 2012
 02:44:40 -0400 (EDT)
In-Reply-To: <CEAB8F11-05A4-46B4-A0B5-B51B14EAD536@wincent.com> (Wincent
 Colaiuta's message of "Sat, 14 Jul 2012 22:50:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DD5C578-CE48-11E1-B86F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201470>

Wincent Colaiuta <win@wincent.com> writes:

> On Jul 14, 2012, at 10:25 PM, Junio C Hamano wrote:
>
>> I did not see anything wrong doing what you described in the
>> post-receive, even though having the hook in the "scratch" felt
>> strange, as the "copying from authoritative" would also want to be
>> automated and the natural triggering mechanism to do so would be a
>> post-receive there.  What issues were you worried about?
>
> The part that I left out, to keep things simple, is that ...

I said "strange", not "wrong".  If it is undesirable to hook the
"authoritative" repository, it is perfectly fine to hook on the
receiving end.

So what issues were you worried about?
