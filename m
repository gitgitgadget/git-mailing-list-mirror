From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: give --reroll-count a short synonym -v
Date: Thu, 03 Jan 2013 17:28:53 -0800
Message-ID: <7vip7dviqy.fsf@alter.siamese.dyndns.org>
References: <1357166525-12188-1-git-send-email-gitster@pobox.com>
 <1357166525-12188-2-git-send-email-gitster@pobox.com>
 <A6A2DEC8F88743B88AA03DC5BD8547B7@PhilipOakley>
 <7vpq1lvmtz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 02:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqw63-0001UO-EX
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 02:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab3ADB27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 20:28:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab3ADB26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 20:28:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F812A22D;
	Thu,  3 Jan 2013 20:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h6REcvpiSfcHcb9jWRg0LSKuKbE=; b=HLfl6f
	HLWKAEEKY/TK20EzGhg7buTszAzz3rePY/mvVnY+G85FdQEiBR0c98YmP7asVmzI
	HvNhnhvcolpo3ltAHvdPRNXPAYd6cd0qg//pHCZpjOCuMb0cX9Acqv2MpkgxeBP0
	lNaHDVD8Y6428uCpNZzm5UL0UkQOAUXriX1B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0Y4C4B/EJeimxr5axaPBNCHfeeQuUJt
	8tSaKkmHjAaHjVGvSnXveX0c6Dv3JxNr1EwZa2bICz3x0uMH2hQQeXNjgmvZjnzq
	luAo9BZH2dmmKkYInLk+kB9S2a/HW/35N2iTaxEazK7SyrG9KCtk1pjFHRL+1x63
	qn4UScT+e4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D82A223;
	Thu,  3 Jan 2013 20:28:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFAB2A221; Thu,  3 Jan 2013
 20:28:56 -0500 (EST)
In-Reply-To: <7vpq1lvmtz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Jan 2013 16:00:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BA5DEF4-560E-11E2-B78B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212625>

Junio C Hamano <gitster@pobox.com> writes:

> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> +test_expect_success 'reroll count (-v)' '
>>> + rm -fr patches &&
>>> + git format-patch -o patches --cover-letter -v 4 master..side >list
>>> &&
>>
>> Shouldn't this be using the sticked form -v4 as described in the
>> commit message and gitcli?
>
> I personally do not care too deeply either way.

Actually, I do care. And in this case both should work.

    Separating argument from the option
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    You can write the mandatory option parameter to an option as a separate
    word on the command line.  That means that all the following uses work:

    ----------------------------
    $ git foo --long-opt=Arg
    $ git foo --long-opt Arg
    $ git foo -oArg
    $ git foo -o Arg
    ----------------------------

As "reroll-count" must always be followed by nth (in other words, it
is not optional), the following does not apply.

    However, this is *NOT* allowed for switches with an optional value, where the
    'sticked' form must be used:
