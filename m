From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 10:35:00 -0800
Message-ID: <7vvcahw3zf.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
 <20130128081006.GA2434@elie.Belkin>
 <CAFXTnz6zN0izx8S23JFww5niVD6x-r2e7TSthqZnempUrvAEWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztYE-0004qB-BH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3A1SfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:35:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3A1SfC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:35:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A188CC92;
	Mon, 28 Jan 2013 13:35:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Yx8kShqUGKXgLm3O4Lb0Mebf9Q=; b=FXms+y
	zLE0T2ZD3w7N+Batmi7ak2pQVJDI4ne7GZKZNdE/FlCcDHHYUhLMHafsmx0fLz7i
	uu5r55Z6K7VPsseV7eHY+B8KZ/4SXrk/oB+WYabErPToIj2mMw9rfNOFXHfF/wmR
	yozEZRGbwGTX9AIua9KJaunQxCUmEqxsvnkg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f7mLTCU4POLlyTM2+BNM6aVpxIeLeHxj
	SeUzgLGFD7NV7wzxouTxeg+91rV0kog0xxZEORUtRGb42QMQrSq0owZLqB8vQN1I
	wZbUwQkTrbYwKwYPDEVRjiwpUxnedxNwUKEg/TPcXyuh9dt/aKeRN7Moea+lzil1
	T1bSkWuL0k0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D66DCC91;
	Mon, 28 Jan 2013 13:35:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBBD2CC8C; Mon, 28 Jan 2013
 13:35:01 -0500 (EST)
In-Reply-To: <CAFXTnz6zN0izx8S23JFww5niVD6x-r2e7TSthqZnempUrvAEWw@mail.gmail.com> (Lars
 Hjemli's message of "Mon, 28 Jan 2013 18:11:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D311418-6979-11E2-BA6B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214854>

Lars Hjemli <hjemli@gmail.com> writes:

> On Mon, Jan 28, 2013 at 9:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> ...
>> So if I ran the world, then having commands
>>
>>         git -a diff
>>
>> and
>>
>>         git for-each-repo git diff
>>
>> do the same thing would be fine.  Of course I don't run the world. ;-)
>
> This would make me very happy. Junio?

Ahh, our mails crossed (rather, I responded to the other message I
saw before I saw this one).  I am not completely sold on "git -a"
yet, but another worry I have is which one between "submodule
foreach" and "for-each-repo" should use "git -a", if we decide that
it is useful to the users to add it.
