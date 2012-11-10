From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sat, 10 Nov 2012 14:39:58 -0800
Message-ID: <7v4nkxozep.fsf@alter.siamese.dyndns.org>
References: <509E66B0.3040308@web.de>
 <CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:40:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXJj2-0005zD-KE
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 23:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab2KJWkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 17:40:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2KJWkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 17:40:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F29629326;
	Sat, 10 Nov 2012 17:40:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wKqzZEuiJ1yL
	VlSAIsGLZYdAifo=; b=TBpE2HC2JDJ9YJ479fOSpe/zeOBmRX/k9swbv5F1Ul72
	wAmoDkVaXCs5BgyxMplS1eYZ2hPzPBLzG0/ciovd55zz0EZKBCtTC1V3lJUCcUmy
	ol6bB69Ad3NxguiSdbrwOFZVAylSqxrHCBbeem+1+Kr0lxI3Wacta8Vnf6+Y+80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qcalcr
	/Qh7GrLLLy1NfGwj6K3RX1bSOklhsf6BsDPa+hazf2S6rdhN3hn+Zn7h7UlLeAbf
	ZxyEzCZxjKTel6EBhAKpk1ESvm3NOKPALgIgMc4TNLoW6drhB1LxL51S4gxnSSXX
	4aZxXQ0zldoMPSinH1wFixesBMY2UeTDKw6TE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF1F9325;
	Sat, 10 Nov 2012 17:40:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 036649322; Sat, 10 Nov 2012
 17:40:00 -0500 (EST)
In-Reply-To: <CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 10 Nov 2012 20:17:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FF3BD46-2B87-11E2-8B54-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209311>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Nov 10, 2012 at 3:37 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> The short version:
>> echo -n doesn't seem to be portable.
>> The following works for me:
>
> Right, I was supposed to change that to:
>
>   true > marks-cur &&

Please make it like so:

	>marks-cur &&

No command is necessary when creating an empty file or truncating an
existing file to empty, and no SP between redirection and its target.
