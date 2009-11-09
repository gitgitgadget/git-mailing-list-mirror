From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] builtin-push: add --delete as syntactic sugar for
 :foo
Date: Mon, 09 Nov 2009 08:59:53 -0800
Message-ID: <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
References: <20091109130935.2bea7771@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Xb5-0005QI-Lk
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 18:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbZKIQ74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 11:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbZKIQ74
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:59:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZKIQ7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 11:59:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92F3E98734;
	Mon,  9 Nov 2009 12:00:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=69wQaHamKkLZ
	Unvt4/s7or69fLA=; b=C7zB+au9nDHi/Md2y8OKaFHjOPylkpugZs/YcslgH/0J
	4UDSGG604/FDpxizDE5p8VX35v2Mlt5WWiUr3MVrWMa1lUKzp9yDO1P81ygKBto5
	PBAf1a5hrWumljAMIKJ7diAoTdAraLiXM+S/o0wLVzOlb8L1mTxEGGItGy0BDcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q/ibyF
	8idS7uWwnhqIC6xybZa0ZdN0eqQgak2F/iYHlWHGoajZerx6zLjwNWPxKOBCc/CJ
	86dd7bTM934UO/SAzgSbisWfdh9HAlDT+se3U7L2uin+VogVLywiObh1+O/L4Em5
	yh4bNI0HLHOuVQ6wFYxbi0DuglnISA6aZIQYU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E5AC98733;
	Mon,  9 Nov 2009 11:59:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F13E9872F; Mon,  9 Nov 2009
 11:59:54 -0500 (EST)
In-Reply-To: <20091109130935.2bea7771@perceptron> ("Jan =?utf-8?Q?Kr=C3=BC?=
 =?utf-8?Q?ger=22's?= message of "Mon\, 9 Nov 2009 13\:09\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FBC282C-CD51-11DE-A7DE-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132495>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Refspecs without a source side have been reported as confusing by man=
y.
> As an alternative, this adds support for commands like:
>
>     git push origin --delete somebranch
>
> Specifically, --delete will prepend a colon to all colon-less refspec=
s
> given on the command line.

Will it barf and error out if there is any colon-ful one?  I think it
should.  I was about to write "I guess it could be argued both ways", b=
ut
after thinking about it for 5 seconds I do not see a sane way to explai=
n a
command line "push origin --delete one two:three".

I agree with you that it wouldn't make sense to mix this with --all and
friends.
