From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Handle p4 submit failure
Date: Fri, 30 Oct 2015 13:23:42 -0700
Message-ID: <xmqqziz0jeb5.fsf@gitster.mtv.corp.google.com>
References: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
	<xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>
	<CAJA=mv7ydNCm-yy9Ukk2XB-xvAJ1VkyqHEGcCTA2PEg=5y9cFQ@mail.gmail.com>
	<xmqqy4ekkzmg.fsf@gitster.mtv.corp.google.com>
	<5633CABA.1000003@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsGDF-0000cQ-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 21:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760117AbbJ3UXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 16:23:46 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752740AbbJ3UXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 16:23:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 354BB27826;
	Fri, 30 Oct 2015 16:23:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xphLoyLBQKsoBo5uoCJMlUuJOjE=; b=UG/u+T
	juGKA3xcx5v4CDUd10M9nTS/0ucoX4dI6PQeAOvIkULm/Sxs61/jAjo1wvTNr8lq
	eXqa7EjM371okfuxN8nmH23FJA9MFtY/eKwkQxbORYmGkb5GlzkKwKqVANfHBj8X
	kGZ7t9ngWS/cdK5j10nU29cSgtAiuTvyUtmdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYJL/vtrzyPPD2AqyJFrK/aRg+jQ8L7A
	5l8LZdntP13evJU+fW0Osw7WGsTXjxECt4VEPpTLsYLMilJmONsQ1J91vLlo84b0
	IGS2JaYnNFG36wbpPWvL52RuIOBh6XhXfF5Gv3yk5kREVAWgOj5QQFoyMc2oKJ2X
	mXlQxxtFXIc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29BA327824;
	Fri, 30 Oct 2015 16:23:44 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A13AF27823;
	Fri, 30 Oct 2015 16:23:43 -0400 (EDT)
In-Reply-To: <5633CABA.1000003@diamand.org> (Luke Diamand's message of "Fri,
	30 Oct 2015 19:53:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DA8662E-7F44-11E5-9606-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280539>

Luke Diamand <luke@diamand.org> writes:

> On 30/10/15 17:57, Junio C Hamano wrote:
>> Etienne Girard <etienne.g.girard@gmail.com> writes:
>>
>>> Yes, however if `p4 submit` fails the corresponding "Command failed"
>>> error message is displayed, and the p4 error message itself is
>>> displayed if any.
>>> Tthe script will also terminate successfully if self.edit_template
>>> returns false but it will exit with error code 1 if p4 submit fails.
>>>
>>> So the user will get "Command failed: [...]" followed by "Submission
>>> cancelled, undoing p4 changes", to let him know that the script failed
>>> because of p4 and that nothing was submitted.
>>
>> OK, then it sounds like all I have to do is to update the log
>> message with the "How about this" version and correct the authorship
>> to use your murex address, and then wait for reviews from real "git
>> p4" reviewers.
>>
>
> Looks good to me. Nice use of try...finally.
>
> One very small thing - test t9807-git-p4-submit.sh is now failing with
> this change.
>
> That's because it tries to delete one of the files it created, but you
> are now deleting it already! Could you just update that please?

I'll ask Etienne include that change in a reroll, as my environment
is not equipped to run any p4 tests.

Thanks.
