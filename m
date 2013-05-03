From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Another use of "@"?
Date: Thu, 02 May 2013 23:38:26 -0700
Message-ID: <7vfvy4zhy5.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
	<7vr4hozie1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9db-0004C9-At
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229Ab3ECGia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:38:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933166Ab3ECGi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:38:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A6415DAC;
	Fri,  3 May 2013 06:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jWRJ8nE53E3ahdFQf78JU8h9FgE=; b=e7vVdR
	mEMwWiFfY4n/Ke+wbAC3xzIn6Q9+rs6fSeZz62QQMi3I3boyKF62Uq38lLuQToy6
	0F9KgFHcsgK0CJec9tw7vyCrzCsI/PzqGchQoU1R14miefDGbufLVt8henj7znsq
	2f8Xr8E8WE8KC7nwB/iLjF3c1Fxb1wnYOxi6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZX19fmeQ7jKCRbwJekGUA5/GgUq3AJir
	3+LHewzDjSmLxv3LhDsElJKnv8feM5vijV8RWG6qm8FkGWNtYACEH8dJ+J+gdoOO
	WssagHGKyXtFvbXbjf4XbQZpbn5IlmR6WhAg9WC3ofvMqUyfFNly9RPWfG3CAGvo
	X59SS1weiaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF4615DAB;
	Fri,  3 May 2013 06:38:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D85C15DAA;
	Fri,  3 May 2013 06:38:27 +0000 (UTC)
In-Reply-To: <7vr4hozie1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 02 May 2013 23:28:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FDD1E50-B3BC-11E2-9520-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223287>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> My setup is a bit peculiar where I do git development on three
>> different machines. Say I updated branch long-branch-name on machine
>> A. Then I continue my work on machine B. I would want to hard reset
>> that long-branch-name on machine B before resuming my work. What I
>> usually do is
>>
>> git co long-branch-name
>> git diff A/long-branch-name
>> git reset --hard A/long-branch-name
>
> Perhaps
>
>     git checkout long-bra<TAB>
>     git diff A/!$
>     git reset --hard !$
>
> In any case, not a Git question, I would have to say.

As a Git question, probably the answers are

	git co long-bra<TAB>
        git diff @{u}
        git reset --hard @{u}

with an appropriate setting of the upstream, perhaps?
