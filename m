From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing error message
Date: Thu, 14 Jun 2012 16:14:26 -0700
Message-ID: <7v395xebal.fsf@alter.siamese.dyndns.org>
References: <CABURp0qE+qJjyrhRFb8-gWucM0=3TpYwDBsnbCPrZNVe3QGQBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 01:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfJFJ-0002PR-S4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 01:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab2FNXOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 19:14:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab2FNXO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 19:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CE5F9383;
	Thu, 14 Jun 2012 19:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k3QFDhFlUgr39OGlelT90D6kO8s=; b=kUmjuQ
	Ef+pA6TvX5CbKQaxNx/w3guH0lBh7x13e9lHLz6G795NH9WcMn6MAu089gYFHKbM
	OTAxUQpyxJB1Zu54BXQxNWQfWxLySsgNkfZzPOadZIhSDWTnybNgDtW1oqeYNBT2
	lRQ0IK7y2i9KVXZlZ4AnHt2bL8z0aVZDBDRKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e7ppxOAOUlzsl5+4RzvpDmI1abO5HTdb
	vDahvEGmXUgbVF3rh6oDun2/Ekha6pw83t2an07Plxr1nQr5tYBQ7a5diw6ZG+tH
	tUvk4cZw023f55GyzNeHCRk+PxZSTV231T3x6or1VAJ5MRhFif7kMqgWYWKMpAs9
	8MmsEhBzMMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 741309382;
	Thu, 14 Jun 2012 19:14:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DCA99381; Thu, 14 Jun 2012
 19:14:27 -0400 (EDT)
In-Reply-To: <CABURp0qE+qJjyrhRFb8-gWucM0=3TpYwDBsnbCPrZNVe3QGQBQ@mail.gmail.com> (Phil
 Hord's message of "Thu, 14 Jun 2012 18:54:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B074CCDA-B676-11E1-ADFD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200034>

Phil Hord <phil.hord@gmail.com> writes:

> I messed something up during a rebase in a moved file (probably
> because I had rename detection turned off).  So now I want to fix it.
>
> I think I have the commit amended right, but to be sure I want to diff
> the old file and the new file.
>
>   $ git diff newfile HEAD^:oldfile
>   fatal: Path 'oldfile' exists, but not 'oldfile'.
>   Did you mean 'HEAD^:oldfile' aka 'HEAD^:./oldfile'?

You can feed two blob object names to "git diff", but I do not think
there is any provision to compare a blob object and a file in the
working tree.
