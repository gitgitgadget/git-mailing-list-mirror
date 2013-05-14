From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git cvsimport implications
Date: Tue, 14 May 2013 15:19:53 -0700
Message-ID: <7vfvxpfbli.fsf@alter.siamese.dyndns.org>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
	<CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNZg-0005Pw-HO
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab3ENWT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:19:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758647Ab3ENWTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:19:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE301E31A;
	Tue, 14 May 2013 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nQh1Tij8quP8dosFCAIipdDh0K0=; b=HIKGWo
	MVLkH7vyDaUcrVUGZzO8qbrbiQkbWyUBmJoLUahyk9R6n+WLypygMgIVMiQY7RgY
	T2zO/G+yW8RqtNbPrYXJhDL9SMmo0ddIKWjmMwoAFIjqQd0KyDRYYsgVreULr+1T
	RG9AZCINuJLtFYmG1DX69oS3NrFYJ5ZEoYTpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcvFwF3e604e1QOL2yVymc4Uy8rWM67S
	4PyzR/gv8qnWLS6g6OQQSk8xwuIkVcVtgSfvYDj4QmehB1yDZzT/kxhAg9KWqPZ0
	gKzYqQRU+fM8I+qT+lJfB3qgj3WbA1sWt65Y2f4t96URoOzrQxyVSqZKADo4K+cx
	GeMdaMIrNbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE6F1E317;
	Tue, 14 May 2013 22:19:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80C0B1E314;
	Tue, 14 May 2013 22:19:54 +0000 (UTC)
In-Reply-To: <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
	(Eugene Sajine's message of "Tue, 14 May 2013 18:09:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6740C5EE-BCE4-11E2-A981-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224360>

Eugene Sajine <euguess@gmail.com> writes:

> What if there are a lot of branches in the CVS repo? Is it guaranteed
> to be broken after import?

Even though CVS repository can record branches in individual ,v
files, reconstructing per branch history and where the branch
happened in each "changeset" cannot be determined with any
certainty.  The best you can get is a heuristic result.

I do not think anybody can give such a guarantee.  The best you can
do is to convert it and validate if the result matches what you
think has happened in the CVS history.
