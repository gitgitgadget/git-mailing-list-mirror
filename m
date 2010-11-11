From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 09:58:41 -0800
Message-ID: <7vfwv7hhda.fsf@alter.siamese.dyndns.org>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
 <201011111649.oABGnjca019731@no.baka.org>
 <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:59:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbQJ-0006G7-18
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab0KKR6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:58:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0KKR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:58:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B19CD37B1;
	Thu, 11 Nov 2010 12:58:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qusz/OiKYWByXakGPw4Cbw7SQlc=; b=hpFmj1
	honJvmhkSwiGRx4tpSYRR/NGw9cL3wZmMup1n6dcXvhKhuma8Tgi5fZlhDo7Lexn
	A2BbqF0F3/p5oLyr4SddMUOPFr1zz0tY+ZLFM/bSF3oa1Po3npWpeg/LT3oQGAJ8
	q/zcb/6CCV94qFTCsXjPLYAvZXlxK2AqSzcX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0a5D95/XlmufwM1xyeHfHszXoWmRa5G
	+i0qnpr55lJ1mZTFF4JUkCUBhsjNe49OYlzmNSPg2KhsFEUtZ9J8awbTaSIdTGQ6
	jaET5yg5k8kB/BzTnuLeN43lYmPshp+mPbVWu4DnZ/Gf1yETssthPvKEOyEWsTJK
	SP1Mwm0rpwU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62FD237AF;
	Thu, 11 Nov 2010 12:58:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36BD737AE; Thu, 11 Nov 2010
 12:58:48 -0500 (EST)
In-Reply-To: <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
 (Patrick Doyle's message of "Thu\, 11 Nov 2010 12\:34\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 587D25BE-EDBD-11DF-943F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161279>

Patrick Doyle <wpdster@gmail.com> writes:

> $ git merge --no-commit
> $ git reset
>
> Why is that "git reset" benign, when the "git reset HEAD^" wasn't benign before?

The former is resetting the index to HEAD (your latest commit), while the
latter is resetting the index to HEAD^ (the one before that, discarding
your latest commit), no?
