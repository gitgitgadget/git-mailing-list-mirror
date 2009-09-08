From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving merge failure message
Date: Tue, 08 Sep 2009 09:34:39 -0700
Message-ID: <7vzl958kf4.fsf@alter.siamese.dyndns.org>
References: <20090908153101.6117@nanako3.lavabit.com>
 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
 <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
 <7vk509ev20.fsf@alter.siamese.dyndns.org>
 <e2b179460909080059x62eb9d30t4d723d185e6316e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 18:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml3eq-0004hU-VT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 18:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbZIHQey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZIHQex
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 12:34:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZIHQex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 12:34:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 857B8490A1;
	Tue,  8 Sep 2009 12:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nJUgWzZkMZumwzLgs3CuBz8lXBc=; b=I962ApQvL7vRFvl7vse3hGw
	xuEl/MphByFFtAautw7ZHRh0c4Whw1iapit8M09jQ9ugXbKEEgoQLUyu+PdKn+wF
	twPlAl8dNOz8ZQRqssfpfs9geDWC+Gy4bQbg2ybz4JctgcviGV/Yt2vScedKQIc+
	po/piZxz1aFk/5hPKZhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nLKJXjIJusjMV+qOv+/vOcoa+lTCn2Kg7nDK3hMyD4nZKh4Pz
	3EwnKrXzBMIVeer1K4GCjJOYz58Sd5It1gxQeJaK/202Tw0iHatPdv1VBhurQCMt
	T8ZeqO61NjSZcbvlPF3U5dFigt7ESY2vIik9iH2a9W/NLLpDAkfkEP8HPE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FBC64908C;
	Tue,  8 Sep 2009 12:34:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 310424908A; Tue,  8 Sep 2009
 12:34:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87537034-9C95-11DE-BBB7-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128018>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> 2009/9/8 Junio C Hamano <gitster@pobox.com>:
>> I'll leave the exact wording up to other people.  My primary focus was to
>> end all of these messages with "Aborting."
>>
>> This turns out to be a continuation of an older discussion thread back in
>> May 2008, and I do not know if anybody took up the challenge back then.  I
>> wouldn't be surprised if "checkout", which was the topic of the old
>> thread, has some other scary plumbing message still seeping through to the
>> UI layer.  Perhaps there are some other commands that needs similar kind
>> of love.
>
> Just a note that Documentation/git-checkout.txt references this
> message in an example and should be kept in step with the final
> wording change. It would be ideal to be able to regression-test the
> examples in the documentation somehow but that might involve abusing
> the asciidoc markup somewhat.

Thanks.

> 2009/9/8 Jeff King <peff@peff.net>:
>> While we're picking apart your wording, is "clobbered" the word we want
>> to use?
>
> If we're debating 'clobbered', then maybe the non-word 'uptodate' is
> fair game too? 8-)

I think you added smiley because you already knew the answer, but if that
is not the case, please see

    http://thread.gmane.org/gmane.comp.version-control.git/81100/focus=82358
