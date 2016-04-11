From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify signature verification
Date: Mon, 11 Apr 2016 09:41:22 -0700
Message-ID: <xmqqtwj8rtcd.fsf@gitster.mtv.corp.google.com>
References: <20160409200756.GA22694@hashbang.sh>
	<xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
	<20160411003242.GC9034@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: KellerFuchs <KellerFuchs@hashbang.sh>
X-From: git-owner@vger.kernel.org Mon Apr 11 18:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apeu3-0005yw-45
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 18:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbcDKQl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2016 12:41:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753686AbcDKQl0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2016 12:41:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0775153C57;
	Mon, 11 Apr 2016 12:41:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hExhstTvcAZ7
	ovjLWw0Li2f1ofk=; b=PMOrcrMKWBRHFPmuJ7i7cgPJCcMTEKPv66pmzMd9EArz
	eusyTkxZ+G1OXvfjQ7TCiYZAm3WWjfpofcmXFx/0tYTMwLjh7Utlp94vkOAPZFl3
	FlldH6YihTbOEWVdxNb8KT/Z3WzNUKig74YNQqRWBXhGt6ZwXYy/nklTjs8iHY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ipLl4f
	5PvsKHXJh55Sho3+OQSiOMs+3MnZ1j2lbilgPe7vZAL0N5XbNuTszD8iYW5ThceA
	dvSAUna14OpAQMYgIsseEvKgTMoXG1V+Q+7GFbUl1iqEW9NYkQIAuQq1Q72osJYq
	hU2COOlLUaWNn+yXMOtGTuA5a6CXWocdHWRwE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1DFE53C56;
	Mon, 11 Apr 2016 12:41:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77D7253C55;
	Mon, 11 Apr 2016 12:41:24 -0400 (EDT)
In-Reply-To: <20160411003242.GC9034@hashbang.sh> (KellerFuchs@hashbang.sh's
	message of "Mon, 11 Apr 2016 00:32:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AA36698-0004-11E6-BAEE-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291219>

KellerFuchs <KellerFuchs@hashbang.sh> writes:

> On Sun, Apr 10, 2016 at 11:46:10AM -0700, Junio C Hamano wrote:
>> > --- a/Documentation/merge-options.txt
>> > +++ b/Documentation/merge-options.txt
>> > @@ -89,8 +89,10 @@ option can be used to override --squash.
>> > =20
>> >  --verify-signatures::
>> >  --no-verify-signatures::
>> > -	Verify that the commits being merged have good and trusted GPG s=
ignatures
>> > +	Verify that the commits being merged have good and valid GPG sig=
natures
>> >  	and abort the merge in case they do not.
>> > +	For instance, when running `git merge --verify-signature remote/=
branch`,
>> > +	only the head commit on `remote/branch` needs to be signed.
>>=20
>> The first part of this change and all other changes are of dubious
>> value, but the last two lines is truly an improvement--it adds
>> missing information people who use the feature may care about.
>
> The reason for the first edit is that =E2=80=9Ctrusted=E2=80=9D and =E2=
=80=9Cvalid=E2=80=9D are OpenPGP
>   concepts: a key is trusted if the user set a trust level for it,
>   and a uid is valid if it has been signed by a trusted key [0].

OK, so it is wrong to talk about "trusted" and/or "valid" "GPG
signatures" like the original one.  We should say "... have GPG
signatures that were signed by valid key" (not "trusted" key)?

> Most of my confusion came from this, since it sounded like the signat=
ure
>   would only be accepted if it came from a key with a non-zero ownert=
rust.

Thanks for clarification.  The distinction between trusted and valid
should at least be in the log message and possibly (if we can find a
good way to flow it into the description) added to the documentation.

Perhaps like this?

    Verify that the tip commit of the side branch being merged is
    signed with a valid key (i.e. a key that is signed by a key that
    the user set the trust level as trusted), and abort the merge if
    it is not.
