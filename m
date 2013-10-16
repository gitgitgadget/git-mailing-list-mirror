From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] checkout: allow dwim for branch creation for "git checkout $branch --"
Date: Wed, 16 Oct 2013 14:39:15 -0700
Message-ID: <xmqq7gdc6gl8.fsf@gitster.dls.corp.google.com>
References: <1380113349-19838-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8AbBrVSz=p+ARxvR_QXtku1BxbtQPv7pz_QCveeUEtwCQ@mail.gmail.com>
	<vpqob7huhyw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, jc@sahnwaldt.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYoL-0008Fv-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab3JPVjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:39:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab3JPVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D64624BE67;
	Wed, 16 Oct 2013 21:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pfpCabJmybjMvzAdevq190aa3JM=; b=cQA2Wc3qR0gTpdOzDi4v
	sExmR4Gc0s2JgzK5xXWWbx+PEe66EB0ABotys71XLAFwCED8+7BUa1jmIkV6VdDC
	Im0jd5QJyC4tHE+5YFQfdImcO0i9cSOzQfB5aYmLNTrmMya0+8E7qicn9WJzpTus
	JoSW+pgu23et0PKjz+6SrJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qrSn5xnTqxErG37E2hmAT8rpMtY7q5MJd1Z8I+Ywy+fNQY
	LxDZaYuz0pXsCezAPc6ni5oGDOfQQyi2Orm22gWlJh1lOeQzI8kn+39UUfw6fGTj
	7DmoCSzSpzXhVZK4uqMwEi+Sc6b1iU4z6MErVKrt/TFXIdcVQZI7QjtWJ5lc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B604BE65;
	Wed, 16 Oct 2013 21:39:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 328DB4BE60;
	Wed, 16 Oct 2013 21:39:16 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67ED9558-36AB-11E3-80AA-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236268>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> has_dash_dash is calculated as (argc > 1) && !strcmp(argv[1], "--"),
>> so when argc == 1, the has_dash_dash must be zero, the "&&
>> !has_dash_dash" is redundant.
>
> Yes, but I'd rather not have to read the detailed definition of
> has_dash_dash to understand the code. With my version, the name of the
> variable is actually sufficient to understand.
>
>> But it makes me wonder what we do with "git checkout abc def -- xyz".
>
> Ouch. Both old and new say
> ...
> I'll resend, together with tweaks to the first patch.

Did anything further happen to this discussion?  Is v3 the version
with agreement among the list members I just should pick up?
