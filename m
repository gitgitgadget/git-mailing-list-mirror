From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 26 Mar 2015 13:55:29 -0700
Message-ID: <xmqqoanfxyv2.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<55146BF5.7040008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:56:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbEoY-0000wU-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbbCZUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:55:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752513AbbCZUzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 16:55:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E9A42C5C;
	Thu, 26 Mar 2015 16:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/610GmBVQMm3XU1cXvwg30GmjA=; b=f+FfZ1
	VOy0LKyd6cKUD14eLd8jR+f7oDZMa4jgVzmfBqJB/JoTeeAVsqTvDbA4JzW+oZSu
	53pj5DH5TCoAMyCNQA6d2eaI1g5eXp9UC19pmxyjjnAr29T1Q6rcJG/yHeuP/RNL
	2ucRPz9I/bkBeHdeTOyS5/xBIeh5sWcFhCQns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DmtrU0uK2mkLf1CPw1J+pUA313y38vuc
	rMlhRYLgB8hWS5XgpYtdPmdhgJs6QiHQtSAE28KfxhkeY17gFcVh21sXNU1Ipp7o
	ZZTanMrKkaSHw6gk4gGSASuJ7S3zGeOsQ3do1GIFKCnOsJHNH8ybiTiLmD8wPSSa
	Laaivg2DDFM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C84642C5B;
	Thu, 26 Mar 2015 16:55:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 256BA42C5A;
	Thu, 26 Mar 2015 16:55:31 -0400 (EDT)
In-Reply-To: <55146BF5.7040008@gmail.com> (Sebastian Schuberth's message of
	"Thu, 26 Mar 2015 21:28:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 708EF880-D3FA-11E4-9CE4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266348>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> 	Instead of flattening the history by replaying each
>> 	non-merge commit to be rebased, preserve the shape of the
>> 	rebased history by recreating merge commits as well.
>>
>> or something along that line, perhaps?
>
> Hm, I'm not sure about the "as well" here. Non-merge commits basically
> are just picked, not recreated in the same sense as merge
> commits. I'll come up with another proposal.

OK.  I do not see qualitative difference between picking a non-merge
and picking a merge; they are both being replayed and it is not like
the machiery is trying to preserve an evil merge.  Having said that,
I do not have a strong feeling either way between keeping and
dropping that "as well".  I threw it in there only to contrast the
preserve mode (where merges are also picked) with the normal mode
(where merges are not picked).
