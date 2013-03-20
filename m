From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Wed, 20 Mar 2013 13:45:22 -0700
Message-ID: <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:45:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPtQ-0000WY-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab3CTUpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab3CTUpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DA8BA0D6;
	Wed, 20 Mar 2013 16:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EUF3E/Q1DOjS2taVuttr2vrL55w=; b=HjPaJt
	HYgO7XwmXjeQQUM4rYvum0jbWCSyY0zXQhoXxqTN70d9DpVG6Qx5lIyIRG9WfK7P
	leGovDJTC9bWQrY009uSLbcYN9GiZma6SN4AcGRA3mBYKNtG/8xlVkOD2bJwxEmT
	Qad0iTxjeDrU45iV8nkihwlUrPhCqT9MAZCnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPwSg+At5tqdqNx/9NxmJCuS6jehgmTs
	wh2fGEGJDV4h1xBr+Yxepy7alnqF4/s2I8x+Dn8knM6KthjkdG/X4mHDi7+EKeR/
	1J4bDOSEBgaG1HfsnEZlKJNKTWXtdh8yxop5zjC941TcGwIE/Y5owbyH2xDofqw8
	0XPeFNAXs6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42087A0D5;
	Wed, 20 Mar 2013 16:45:24 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9ACD7A0D1; Wed, 20 Mar 2013
 16:45:23 -0400 (EDT)
In-Reply-To: <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 21 Mar 2013 01:55:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 166A4160-919F-11E2-A265-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218680>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Andrew Wong wrote:
>> On 3/19/13, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>> I know that this is expected behavior, but is there an easy way to get
>>> rid of this inconsistency?
>>
>> You can actually rely on "rebase" to run the appropriate command.
>
> Didn't Junio explicitly mention that this is undesirable earlier (from
> the point of view of `rebase -i` design)?  

I am sure it is my fault but my memory fails me.  As Andrew
mentioned, "rebase --continue" seemed to get this right.
