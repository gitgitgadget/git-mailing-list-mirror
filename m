From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Wed, 06 Nov 2013 12:10:50 -0800
Message-ID: <xmqqfvr98f5h.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 06 21:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve9RN-00084I-KJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 21:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab3KFUK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 15:10:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab3KFUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 15:10:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F1004E8A1;
	Wed,  6 Nov 2013 15:10:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/Yj3H4s48I0fB3mcKDOyxesL7U=; b=Ar0JUL
	nMYAzPQ/Jti/CIEDBfka/6IPEkwE58r98pgR5d8lL/tFjkrjADquwl/y+w1hMIIG
	qvfiZUg3yMrRc82+XvWufYK2rcvGjImUDUYW4UctjlHsDA3NPAa8OUkiTRwcU1h7
	zcZChl6NRr9HVo7Mg6Vfl43uiLrOWQ6NGGGDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uhKSAbcG1Z4YK+L6JrKHCeZ+pBY6UCi8
	xNhVULdgRRDyIHI4utNHuV7gWeAWJB/fvGDyWwKTrmoWBWMMF5R2I6SSkQZFXXvH
	7dYbb8RApupd+V3gvxLvdH1CK1RhpHO8PD631vrn3odR4ffrTfD+Z3MUzSyGKyWd
	uEJIth7aNcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6E34E89E;
	Wed,  6 Nov 2013 15:10:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AF534E89D;
	Wed,  6 Nov 2013 15:10:54 -0500 (EST)
In-Reply-To: <xmqqk3gl8id0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Nov 2013 11:01:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8A8AA9B4-471F-11E3-B04A-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237365>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:
>
>> I don't remember all the discussions on the patch which introduced
>> the warning, but I don't think it's relevant to digg them before applying the patch:
>
> If we apply the patch then it is too late to dig them ;-)
>
>> * The assumption was that users would read the docs, but as I already mentioned:
>>   "Judging by the question asked on stackoverflow
>>   ( http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0 )
>>   and its popularity, telling the users to read the docs did not work very
>>   well."
>
> That is true, but does it justify giving a misleading information in
> the advice message?

Also applying this will have an unpleasant fallout to merging the
endgame patch b2ed944a (push: switch default from "matching" to
"simple", 2013-01-04).  The added text needs to be corrected with an
evil merge.

I'd prefer to having worry about such a fallout only once.  Which
arguably we already did when we came up with the current message, so
I am fairly annoyed by this patch coming loooooong after we
concluded the original discussion.

Sigh X-<.  I'll worry about this later, as b2ed944a is in 'next'
during the feature freeze, and I'd prefer not having to rebase it on
top of the final version of this patch.
