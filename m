From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 16:49:19 -0700
Message-ID: <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 01:49:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBbDL-0001v9-15
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 01:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935577Ab1JEXtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 19:49:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935554Ab1JEXtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 19:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0777609D;
	Wed,  5 Oct 2011 19:49:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pSu7WchdfEPPN/WipH6KaMad3ow=; b=VpvQps
	wG9UY34iJ7yVVTC7DHrZH89W6oazBcWOmCrKxTxVPICTGXnoDmNHOCicbFpXhaW9
	Z0wTvtEzToqvKSiz5VF6CpVrgKj82Sm0gtS73D1lH0r308FDB9UjFAH8OiGQGgx6
	591r+eLFE7VaXhEIte+i65hvOMYkZ+ODMT+is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q+mP3T2n7qChiGNz8BhYwShNTnYQzXlh
	XLoSxgUn54UgM7mCoJWq89dousRc0WXz6xd+oJEMI6opyQAfOIbrwqaZULrLJ8HF
	ewFSxMCrzxmH8ZKa/U8J0MPJa6gFHG9GzvsEq1D4Lu6fdIYrWX06rnU6U8lXcLXP
	dcwcqy6/X5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 987C4609C;
	Wed,  5 Oct 2011 19:49:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CC24609B; Wed,  5 Oct 2011
 19:49:21 -0400 (EDT)
In-Reply-To: <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 6 Oct 2011 10:11:26 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A58BD782-EFAC-11E0-AFFF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182904>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 6, 2011 at 9:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I think of two options:
>>> ...
>> Sorry, what problem are you trying to solve? Does that "checkout -f" meant
>> to nuke the local changes that are not yet at a good "stop point"?
>
> I meant "git checkout" on the already locked branch is refused, but
> "git checkout -f" in that case will act just like "git checkout"
> ignoring all locks. But I forgot that "git checkout -f" also discards
> worktree changes. Maybe "git checkout --ignore-locks" instead of "git
> checkout -f".

I see what you mean, but doesn't it feel as if it is working around a
problem that is introduced only because of a wrong policy (i.e. "you
cannot check out the same branch at two places", as opposed to "viewing
them in multiple places is perfectly fine, but no touching")?

This reminds me of how we ended up handling the "scary warning" around
detached HEAD. It is not wrong nor even dangerous to detach. It is not
wrong nor even dangerous to make commits on detached HEAD. It is however
dangerous to switch away from that state without saving it to a ref, and
that is where we give warnings.
