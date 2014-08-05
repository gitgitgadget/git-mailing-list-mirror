From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Tue, 05 Aug 2014 09:42:10 -0700
Message-ID: <xmqqppgeq465.fsf@gitster.dls.corp.google.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>
	<xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
	<53DFD729.8090307@gmail.com> <vpqegwwauo2.fsf@anie.imag.fr>
	<53E0F057.1040706@gmail.com> <vpqiom72cj4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 05 18:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEhok-0008G4-Eu
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 18:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbaHEQm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 12:42:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64349 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbaHEQmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 12:42:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D61552D7DC;
	Tue,  5 Aug 2014 12:42:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3BjhfxlakjCytKPE44Ewrtbvb6I=; b=OHxHVC
	DEaCb4IYHEnJQcZDCRRRdD+uop1W4dGHTcDJdk4R2xsMjJuo7Z3OaUY4oJRH0Ck0
	xzV0yN5MtCnn6uP+P1FR3lRs/KQOFp+/XFKLO+HhNrFuvnTO8rSpybhMfoAoJr2w
	k80kiD4G107rSBeUP2B/q5dY8d7Pf4Ym8/RZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lWbAtB/DbsCmvbL9vwsfq10RF2NF+pE1
	2LKGO7N7GDPRWE2By3eWu0sj1X/bx7hr5ASBCIouBGCGA3cL4Weyunec8M/C6+nY
	99O98nyjtWYObM8fM4I6xTHX08frT7Xviu7OgTpzOgtR6U6TE4VqDQSUuT3tju26
	kF2ZRWrg7aM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC72E2D7DA;
	Tue,  5 Aug 2014 12:42:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 280A02D7C4;
	Tue,  5 Aug 2014 12:42:13 -0400 (EDT)
In-Reply-To: <vpqiom72cj4.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	05 Aug 2014 17:15:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 739A43B0-1CBF-11E4-9D93-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254811>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> Currently works like the old git_config() error reporting path. If err is set to "NULL",
>> it would print no error message and just the die message. If given something like,
>>
>> 	 git_config_die(key, "value '%s' is not allowed", value);
>>
>> it would print,
>>
>> 	error: value '3' is not allowed
>> 	fatal: bad config variable 'core.frotz' at file line 15 in .git/config
>
> That seems to be a good step forward.
>
> I think we would also want to improve the error message, but that
> shouldn't block your series from inclusion: we can do that later without
> API change.

Yup, I agree with your assessment.

Thank you, both, for good polishing.
