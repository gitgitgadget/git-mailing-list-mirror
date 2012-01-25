From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Tue, 24 Jan 2012 23:00:57 -0800
Message-ID: <7vd3a8466u.fsf@alter.siamese.dyndns.org>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
 <20120124224000.GE8222@burratino> <op.v8mmwftk0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonathan Nieder" <jrnieder@gmail.com>, git@vger.kernel.org,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 08:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpwqw-0006Dh-So
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 08:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab2AYHBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 02:01:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2AYHBA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 02:01:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 689667529;
	Wed, 25 Jan 2012 02:00:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VWGJy6UI/ODUyDOoPEwADcYr1vk=; b=VOSXxu
	vWNGVehAmvrdhfAenXjUi3TRs6Dw+mymRaU2DKsjxvGU60OoXKpg8+/3wKkv1nGF
	RqRie7mRLEb9VPJaWlCUyNwDkRg+BpRsIE64UkNPk+AONM8lJ1U908wiH2UV3eg6
	3/KdXkTzlYHfefTJvX3vviDRom3iTGoaGEUyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1631EvXaEkNIV4mwto13OIZH08d1MuU
	Vp5SG6xBKd3R4c92vVn2do9kXeB162887xeF4/HvSeXyAOzY4rycc+I6PIJUwpdN
	qkfVKceR86IhtHEmGLqx6momXVXsEXJA3vW6J6yQ1bpCE6YXg4YrHuqDd/YQQOkY
	6pMfv7fAfJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF637528;
	Wed, 25 Jan 2012 02:00:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E49FA7527; Wed, 25 Jan 2012
 02:00:58 -0500 (EST)
In-Reply-To: <op.v8mmwftk0aolir@keputer> (Frans Klaver's message of "Wed, 25
 Jan 2012 07:27:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55A9C53A-4722-11E1-B7BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189099>

"Frans Klaver" <fransklaver@gmail.com> writes:

> On Tue, 24 Jan 2012 23:40:00 +0100, Jonathan Nieder
> <jrnieder@gmail.com> wrote:
>
>> Frans Klaver wrote:
>>
>>> +++ b/t/t0061-run-command.sh
>>> @@ -8,8 +8,8 @@ test_description='Test run command'
>>> . ./test-lib.sh
>>>
>>> cat >hello-script <<-EOF
>>> -	#!$SHELL_PATH
>>> -	cat hello-script
>>> +#!$SHELL_PATH
>>> +cat hello-script
>>>  EOF
>>
>> Looks like a no-op --- the script already started with #! and no
>> leading tab for me.  Does it behave differently on your machine?
>
> Hurr? I'm fairly sure the script ended up being indented for me. I'll
> recheck.

It could be that your shell is broken and does not understand the
distinction between the "<<-EOF" vs "<<EOF". What system are you on? If
the problem is real and widespread, we might want to mention it in INSTALL
or Makefile, just like we label Solaris /bin/sh as unusable and advise
people to use /usr/xpg[46]/bin variant.
