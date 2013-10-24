From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 13:04:29 -0700
Message-ID: <xmqqzjpymo4y.fsf@gitster.dls.corp.google.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
	<201310212029.01589.thomas@koch.ro>
	<1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
	<201310211249.49568.mfick@codeaurora.org>
	<xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
	<CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
	<xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>
	<CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
	<8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>
	<CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
	<5268B7D6.5050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZR94-0003RF-Br
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab3JXUEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:04:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab3JXUEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:04:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECAC4D09F;
	Thu, 24 Oct 2013 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XC6tuLyxKkXfPPGgI98vRfAi94Q=; b=uij14O
	JoxH4WTzUMLeW/AR65JTiGaacvXDiDDcjBFuHUlMV3F85l8gn94Wn/is/w3fmqVw
	H9Oe+tTlcn3cFd6n9yRunZD5G0ItBE6ctuYAqtQqJLxjPH6M3amz8YEfq3n3Tz8a
	aL0h3qN+X2PXAIwELeeT3eL6eVICWzX4UpepU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lQNzlMQYqFrSbCICleoYgHeZ2xLT8YPw
	tutOdOR3Zo+Ca3204yq6KYxk4mSgry0n/T00njgVi420DI0QgOA9BYbtq/8m1gO8
	U4NXA6EVyDK/RhG/haEWLUBamlVrF1EQ9oZNpYCqwHE+ExDpjKUuX1U1YYkpTFak
	Zlm8t7dTI2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B2844D09D;
	Thu, 24 Oct 2013 20:04:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE5124D097;
	Thu, 24 Oct 2013 20:04:31 +0000 (UTC)
In-Reply-To: <5268B7D6.5050106@viscovery.net> (Johannes Sixt's message of
	"Thu, 24 Oct 2013 08:01:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F1D76E8-3CE7-11E3-8D8F-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236615>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 10/24/2013 7:25, schrieb Duy Nguyen:
>> On Thu, Oct 24, 2013 at 11:11 AM, Nasser Grainawi <nasser@codeaurora.org> wrote:
>>>>> It is not clear to me how you envision to make it work.
>>>>
>>>> I don't have the source code.
>>>
>>> Now you do: https://gerrit.googlesource.com/gerrit/+/master/gerrit-server/src/main/resources/com/google/gerrit/server/tools/root/hooks/commit-msg
>> 
>> Thanks. So you do have tree sha-1 by running "git write-tree". But at
>> that point I'm not sure if cache-tree is written down to disk yet, so
>> write-tree could be more expensive than necessary (one good point for
>> building --change-id in).
>
> Consider that I make a commit with a change-id. Then I rewrite the commit,
> but keep the change-id. Then I push the rewritten commit to Gerrit. Gerrit
> does not have the objects that the change-id is based on; the change-id is
> just a random number and has no other significance. Right?
>
> Why do you go all the length in computing a change-id instead of just
> pulling 20 bytes from /dev/random?

Very good point.

The quoted script does not necessarily give the right commit object
name at least under three scenarios:

 - when we would need to add encoding header, etc.;

 - when we are recording merges (perhaps merges will not get rebased
   in Gerrit workflow and it does not matter what random garbage
   this script added to them).

 - when we record the commit after 1-sec boundary since _gen_ChangeIdInput
   in the script was called.

I wouldn't call the script "buggy", but I tend to agree with you
that it is an unnecessarily more complex way to spell "grab 20
random bytes" ;-)

> That said, I don't think that --change-id option that the user must not
> forget to use is any better than a hook that the user must not forget to
> install.

That is why I said this in my first response to this thread:

>> ...  We may even want to
>> introduce commit.changeId boolean configuration variable if we did
>> so.
