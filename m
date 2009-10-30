From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 15:33:16 -0700
Message-ID: <7v4opgh5qr.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
 <7vljisk1m7.fsf@alter.siamese.dyndns.org>
 <7viqdwilx2.fsf@alter.siamese.dyndns.org>
 <55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N402F-0000pC-JQ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbZJ3WdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbZJ3WdV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:33:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949AbZJ3WdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 18:33:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 527C88C0F9;
	Fri, 30 Oct 2009 18:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g3/6YSPmqo2c
	pkCaJLIt1bK396I=; b=kgIi+ez9pjTZIJFG6H/j6aH3fbTDYOqxn/byvYyO3jaX
	Ldpf2igPoeiy3jThF/FpMcI3LfUNm/gmJWYD2BO0+spfxGqnnHx0qiysMv5jHxBH
	CjMihA/D5+oOHFU6kFDke/ZCxTGUOXaFJLzZnPAod0kjYqfpOwSyN/OP4IDMIzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f8BLNO
	CB13DPv1nVMj5piAR0qt/7xQP9rWT1igzM3aLGojd2EZwdweTEGiH4z+zhl2aGOU
	qeTQxMUGeQJs+svvApF2iOupEsfNkT8sl+XyQDsK3+REvaKvft7TcDh1MmhKdWM/
	YPp/ZpW0J3JeW6HF6mBV2NBD9n85XKf/UpugU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32DD18C0F8;
	Fri, 30 Oct 2009 18:33:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC55E8C0F7; Fri, 30 Oct 2009
 18:33:17 -0400 (EDT)
In-Reply-To: <55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com>
 (Erick Mattos's message of "Fri\, 30 Oct 2009 20\:20\:55 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AEDA150-C5A4-11DE-A9A6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131770>

Erick Mattos <erick.mattos@gmail.com> writes:

> 2009/10/30 Junio C Hamano <gitster@pobox.com>:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> ...
>>> I agree that the issue the patch addresses is worth improving, and =
I think
>>> it is sensible to default to reuse the timestamp for -C and not to =
reuse
>>> for --amend. =C2=A0I am not sure about -c myself, but it probably s=
houldn't
>>> reuse the timestamp by default.
>>
>> So after realizing that this was about "author" timestamp, I am resc=
inding
>> this comment about the change of the default for -c and --amend.
>
> Actually I am only changing the default for -c and I see it useful.
> At least with me I normally use -c only to use messages of commits as
> template.

I do that from time to time as well.  As I said in a different message,=
 it
may make the default more intutitive if we give new timestamp when the
author is the same as the committer when doing "-c".  You are creating
your own commit in that case.
