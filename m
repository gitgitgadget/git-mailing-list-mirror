From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon, 08 Apr 2013 08:07:23 -0700
Message-ID: <7vtxnhysb8.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CCepx5njpMo40608vHf5mQ_VfeZA_e5KDaH98V8_o0-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:34:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF0U-0003oz-GR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079Ab3DHPHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:07:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965063Ab3DHPH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:07:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5AD145ED;
	Mon,  8 Apr 2013 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4jmlhn51AVe8umlB8ysyDJNQxkg=; b=OIKbiLBz00D76kkqqfxt
	CqXsIn9PkOOmQWNHej5HyQb3JV5sVwfj1M0jxn/19I57hFlD8Wu/R6YXXlJW4jXo
	kH33HOBrsxFjokhTO7jtdBb2RELqSMutfS49/v0fnzjbNHCxzkGUIMGLVBgg5LNr
	uxIKA9xnRdVSuTcwPaN4Fxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FyUmpYi2SqMXvyGwMkcDXee0Bm/f6DAy8qCZfr22gycyA+
	Au8ZyCCKy8UAUn1/2ywKU6tKAFfPs4ouzwQNCrikVpTHgflmQYCSnTZYqcz018PM
	0BGE4rfx2zfnqOMpPk7UyViO6ahsvo7c1drji79WEDPRHrbY5v6tf0JQszoIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B21FD145E9;
	Mon,  8 Apr 2013 15:07:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25455145E5; Mon,  8 Apr
 2013 15:07:25 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0558D62A-A05E-11E2-88A2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220433>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Apr 8, 2013 at 8:26 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> +test_expect_failure 'git add should not go past submodule boundaries' '
>> +       mkdir submodule_dir &&
>> +       (
>> +               cd submodule_dir &&
>> +               git init &&
>> +               cat >foo <<-\EOF &&
>> +               Some content
>> +               EOF
>> +               git add foo &&
>> +               git commit -a -m "Add foo"
>> +       ) &&
>> +       git add submodule_dir/foo
>
> Thanks. I yhink the last line above should be "test_must_fail git add
> ...". I'm half way of fixing it (I think treat_leading_directory is a
> bit loose). Will continue tomorrow (or this weekend, depending on
> $DAYJOB)

This is a good thing to test (to make sure "add" fails, as you
pointed out). Can you include a fixed one in your series?

Thanks.
