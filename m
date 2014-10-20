From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 12:43:37 -0700
Message-ID: <xmqq7fzu34t2.fsf@gitster.dls.corp.google.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<xmqqoat6389s.fsf@gitster.dls.corp.google.com>
	<54455655.9010406@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:43:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgIrp-0000tT-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 21:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaJTTnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 15:43:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbaJTTnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 15:43:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9183F178D6;
	Mon, 20 Oct 2014 15:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lpo57zkB+6Kgh2R5SF12cONLuSU=; b=OvEAMU
	iZCCm/6LgB2CCPP9Yl2bWFQf7qVbS9H0ZS2Lyh8x6AEjbWCFdeyYuRqirLeHnYbq
	BllpIkkpN7+QeaYuGAbSZPJrqe1nLriz0DmiIYmG98YSvkWMLxTnGmovr2Pa/Pc7
	d/DvjQ5aYBvvGkcpKMcQLwpHndh0bRyx9ONkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZa0cAZAF85vBNazX6JEZqO3fNOzMgKl
	k84L+mpYfddUhkj/Fuk9UrLgEq0MWEm/S6NMueJgrzPCGu9CNUsAMMgilRPt22I8
	z2O6Tk6dMPigDiRhH7dCSKMPfvcqlXdUNxGAyzW04GqLCskpvTPrNUkK1ALx9p4V
	lvj0b6ix0l8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88B96178D4;
	Mon, 20 Oct 2014 15:43:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10AF8178D3;
	Mon, 20 Oct 2014 15:43:38 -0400 (EDT)
In-Reply-To: <54455655.9010406@linuxfoundation.org> (Konstantin Ryabitsev's
	message of "Mon, 20 Oct 2014 14:37:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 638049C6-5891-11E4-9570-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On 20/10/14 02:28 PM, Junio C Hamano wrote:
>> I have to wonder why 10f343ea (archive: honor tar.umask even for pax
>> headers, 2014-08-03) is a problem but an earlier change v1.8.1.1~8^2
>> (archive-tar: split long paths more carefully, 2013-01-05), which
>> also should have broken bit-for-bit compatibility, went unnoticed,
>> though.  What I am getting at is that correcting past mistakes in
>> the output should not be forbidden unconditionally with a complaint
>> like this.
>
> I think Greg actually ran into that one, and uses a separate 1.7 git
> tree for this reason.
>
> I can update our servers to git 2.1 (which most of them already have),
> which should help with previous incompatibilities -- but not the future
> ones obviously. :)

Updating to 2.1 will hopefully correct the change in v1.8.1.1~8^2,
and will break Greg and friends who stick to 1.7 for that reason,
though.

The "breakage" in 10f343ea was only in the 'master' branch and
upwards, which is not yet released in any tagged version, and I just
reverted it from my tree, so people on the cutting edge will be okay
in a short order.

Thanks.
