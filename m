From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 15:14:19 -0700
Message-ID: <7vk3n1fbus.fsf@alter.siamese.dyndns.org>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
	<CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
	<7v8v3hi9ix.fsf@alter.siamese.dyndns.org>
	<CAMP44s2B3bFWXZe0aL_GMXe_56MbhSZXf-65rT364nY3shYwUA@mail.gmail.com>
	<CAMP44s16VD+Rm5J=TXxQB+pKhpzHqoxBXSSwDvi0CVW2u2J=5g@mail.gmail.com>
	<7v4ne5i7lf.fsf@alter.siamese.dyndns.org>
	<CAMP44s0CgYs9s1ac1EEqhP8XusScj39zY6CcQyMxSnh6i-V6SA@mail.gmail.com>
	<7vvc6lfc98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:14:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNUJ-00024a-Co
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665Ab3ENWOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:14:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758565Ab3ENWOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:14:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2DFF1FF69;
	Tue, 14 May 2013 22:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vGUp112CiLY/+TBn6SeYDAXRARI=; b=aMmgTS
	TQBO1/qxSDmHdR9PWHnkX3p6m1h4mEB/ZWdjyqXxycATSfOM5IGKmnniypqRgWsd
	/13FqzCYV+8Clxg4UgbfLNv8rfFDFc+XG75g+8boLN97FCtLFgs4oNw1e53iQSw/
	o7YirOQorgbGkPwDxXqXO1bB65CS23aUn+SaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c+YPDB5dv1KMntXE3N8HzRG0iwDVXRwl
	+Ytq1VPCbKiwQL0QHoUwSflw4/6COuJFH5T6TEM+1RngclfPo3t7PXAhYqyCdMVk
	C2SwDeSsCNB3zEDlcPOTdGqQVjf+pKfWnxCcyUKr1nZs6zYQWV9t7UubaZYVV9JU
	tm+ukq89DTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98F4B1FF68;
	Tue, 14 May 2013 22:14:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00F571FF67;
	Tue, 14 May 2013 22:14:20 +0000 (UTC)
In-Reply-To: <7vvc6lfc98.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 14 May 2013 15:05:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0746DB2-BCE3-11E2-A728-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224356>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And the clone would happen either way, with or without this patch,
>> because 'hg/origin/master' doesn't exist, the only purpose 'hg/origin'
>> serves is to block the new feature.
>
> That is the answer I was trying to extract out of you (I take the hg
> is a typo for bzr in the above, though).

Just to double check, I understand that the justification for
removal is this:

     If a clone exists with the old organization (v1.8.2) it will prevent the
     new shared repository organization from working, so let's remove this
    -repository, which is not used any more.
    +repository. It is not used by 1.8.3, and did not host any useful
    +information in the code in 1.8.2.
