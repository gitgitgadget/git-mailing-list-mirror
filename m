From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin-push: add --delete as syntactic sugar for
 :foo
Date: Wed, 30 Dec 2009 11:49:13 -0800
Message-ID: <7vvdfoz1hi.fsf@alter.siamese.dyndns.org>
References: <20091109130935.2bea7771@perceptron>
 <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
 <20091109192044.605e50ba@perceptron>
 <20091229200523.6117@nanako3.lavabit.com>
 <7vvdfpg1je.fsf@alter.siamese.dyndns.org>
 <20091230105244.67f5969e@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4Y1-0001RR-9T
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbZL3Tta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbZL3Tt3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:49:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZL3Tt1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 14:49:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4726AABC9F;
	Wed, 30 Dec 2009 14:49:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=TxEG5td7yFBiSNNcoa9QvSSrz
	LM=; b=I/5zlRI1cFhTYU0aE0CFm6Afcny/MMa+9JnUpbd8BjU70RCXKuy1t9zrA
	rxIZwoZGoWinOGsJeyPF4AjCS7eF3Van7glu8sBtrHZApbSypRPmWwnU8xZzYl/A
	XT32hvNsO86yiqd1ziH0OFgOxYKzwv06dqpbK51rNh8/PX3yD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=c8Pp2mEdFHNX8ttKb1q
	4ncua4w3YBszU2ZMAsK3yo4+Q0Nk1CveSGpidnQGdDTiQ+1hd85+5uP41ZAhe9bG
	ZrqtI9b8fMIPJ5O0E8ZJHZthWDkyJXrVl+CaSumdB7d5mAtjr9Dg+R6oYmSCfF4n
	yK6MOc0qXY9NsWHuyW4SQ2wE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06A15ABC9E;
	Wed, 30 Dec 2009 14:49:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A5F21ABC9C; Wed, 30 Dec 2009
 14:49:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6BBB08BA-F57C-11DE-9BBC-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135919>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Refspecs without a source side have been reported as confusing by man=
y.
> As an alternative, this adds support for commands like:
>
>     git push origin --delete somebranch
>     git push origin --delete tag sometag
>
> Specifically, --delete will prepend a colon to all colon-less refspec=
s
> given on the command line, and will refuse to accept refspecs with
> colons to prevent undue confusion.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---

Thanks.  From a cursory read, the patch looks good.  We would however w=
ant
to have a test that has test_must_fail to protect the error codepath fr=
om
getting broken in the future.
