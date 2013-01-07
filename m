From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: treat field names as case-independent
Date: Sun, 06 Jan 2013 23:47:10 -0800
Message-ID: <7vsj6djuyp.fsf@alter.siamese.dyndns.org>
References: <1357522498-8086-1-git-send-email-nickolai@csail.mit.edu>
 <7va9sllljh.fsf@alter.siamese.dyndns.org>
 <CADGQE7HTB+s2=PWhMZ=1BpU9nruhx5OBhKOY-ngdZJz=vC61uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts7Qk-0001WO-JP
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 08:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab3AGHrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 02:47:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab3AGHrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 02:47:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2640BAD5F;
	Mon,  7 Jan 2013 02:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6ZBdhqqNNpPJbp3lD7L/OkLXlE=; b=ByR+UW
	CSq4T9eQJwon0+7CG0GcfKFAueQaG2TYRQDZJ4Q5mHzZ9KrPx7QViEdC7EATYBGh
	AMg/Rp5nvf6hbg3Q7xXgof9rP5QAAAkI9gJdhKfOrD5NSrcAG7eAAjinZ50CE2Xd
	qp9kSz+NdxNo3tOQHbt2xmD0gJhNBt6dkWruk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocA2piKCE4OVDsBTrSuTJVJhJ3n9pNGd
	jOyQruQcF65s1xXc5sBd0+9yKtoxd6+kB9Kzg+oppgGa3sqjIVmnGvYx+u09naim
	LmfUR/au9uqYQN2t1jNlDybliIVKIYOnfVF8ODBH0lUey1jRDqzRNtHjeGfzu69L
	ijoduzeIb/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188D3AD5E;
	Mon,  7 Jan 2013 02:47:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93128AD5D; Mon,  7 Jan 2013
 02:47:11 -0500 (EST)
In-Reply-To: <CADGQE7HTB+s2=PWhMZ=1BpU9nruhx5OBhKOY-ngdZJz=vC61uQ@mail.gmail.com>
 (Nickolai Zeldovich's message of "Sun, 6 Jan 2013 22:38:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 720D8750-589E-11E2-8AA6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212883>

Nickolai Zeldovich <nickolai@csail.mit.edu> writes:

> On Sun, Jan 6, 2013 at 10:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> While I think this patch is a sensible thing to do, I at the same
>> time wonder who is writing "cc:" in the lowercase in the first
>> place, and if that is one of our tools, we should fix that part as
>> well.  Such a header would leak out to the payload given to the
>> underlying sendmail, doesn't it?
>
> In my case, I wrote the "cc:" headers by hand; it was not a result of
> any automated tool.

Ok, thanks for shrinking the list of things that worries me by one ;-)
