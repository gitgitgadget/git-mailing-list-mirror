From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sun, 06 Nov 2011 16:12:31 -0800
Message-ID: <7v4nyg6b9s.fsf@alter.siamese.dyndns.org>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
 <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
 <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com>
 <7vaa89573r.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gS2fV5B26ZBOLs=5L_rnaeORmKW49OxwbP-+vx+ZN8cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 01:12:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNCpM-0004pt-FI
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 01:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab1KGAMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 19:12:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab1KGAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 19:12:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BA056BBE;
	Sun,  6 Nov 2011 19:12:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OROCiWXOsTJnFpvsy//WqNGv21A=; b=xZa3vO
	YzT97Ei6PGUPTCNzWswlYXJErPnnDG227zhOSkcC9W44RR11G5H5BBFuzULpnhft
	wIGIh/Q6rUxO+CY+h78HSr2BA8UWhuaprDT2Rr6TxFaB+aHru/VlwPpu6b13Y2Ev
	6tGsOQdvoMKq4zYIKBVxLWpjHtnhgrkZKvmjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EQcfm4vaFrY+eCmhRsmcXPi0vGkVj0fJ
	KcRCoJmnOsDeMCpXN/bMMRC4nDtOFnPnS+B5j+jBu28vKMCDE9Q8P4kt2rnkgM00
	Uy/gL/vWPj2HK5/pXIQbQLPNke2w/71aLY1DSvDfPUiY8vJxp1DfbJabNefqcXhC
	4/oefoG/bzU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 018FF6BBD;
	Sun,  6 Nov 2011 19:12:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 421276BBB; Sun,  6 Nov 2011
 19:12:33 -0500 (EST)
In-Reply-To: <CAGdFq_gS2fV5B26ZBOLs=5L_rnaeORmKW49OxwbP-+vx+ZN8cQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Sun, 6 Nov 2011 21:42:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30840292-08D5-11E1-BFC0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184936>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Nov 6, 2011 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
>> In what situation does it make sense to say "It came from _this_ commit"?
>>
>> I think there is a separate variable that allows any part of the script if
>> we are being run as a backend of rebase or not, and that is the condition
>> you are looking for.
>
> The closest I could find is:
>
>                 if test -f "$dotest/rebasing"
>
> Which is exactly the case when commit is set. Do you prefer the "-f
> $dotest/rebasing" test or the "-n $commit" one?

Given the variable scoping rules of vanilla shell script, relying on the
variable $commit is a very bad idea to begin with.  I think the variable
also is used to hold the final commit object name produced by patch
application elsewhere in the script in the same loop, and I do not think
existing code clears it before each iteration, as each part of the exiting
code uses the variable only immediately after that part assigns to the
variable for its own purpose, and they all know that nobody uses the
variable as a way for long haul communication media between different
parts of the script.  Unless your patch updated that aspect of the
lifetime rule for the variable, which I doubt you did, using $commit would
introduce yet another bug without solving anything, I would think.
