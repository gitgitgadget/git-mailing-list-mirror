From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Fri, 09 May 2014 10:16:54 -0700
Message-ID: <xmqq61le27p5.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<xmqqha515ebt.fsf@gitster.dls.corp.google.com>
	<536adf96f37ec_3caaa612ec69@nysa.notmuch>
	<xmqqtx902k45.fsf@gitster.dls.corp.google.com>
	<536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
	<xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
	<536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
	<xmqqha4z27ly.fsf@gitster.dls.corp.google.com>
	<536c15cf8594b_6f3bb152ecb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:17:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioPy-00068k-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224AbaEIRRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:17:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60310 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757200AbaEIRQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9169315276;
	Fri,  9 May 2014 13:16:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7TIQqMlyvCXwn50vma1fdEwaFpQ=; b=PxjkEG
	heif5NVakH3R4fYIlnVFXfnw5NR0TiIWua/KLxkix7OM8TQ0R02Vu2jg42DaBkLM
	CzApXapRcu2H7RlHL+bvCAh8h9S4y/wdSiPcv7koPF2ZFcTXoJYjrPcdsXHl92V3
	2ttzABCPV/MgW3GzTjEYkcD3dCZTAymNJGULc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lEnRvcFnaIGE7C5HGXM8y5PGEva+rPmz
	bYpptvdrs4oX5sCXfMVwbmHXMwhEyGekzqckltbULNa8CAYM/AYrB+sx4FYrbhf5
	7UU0dwQ5Onh7dK4QYdFzCmoHEYLkdMQPILC+OBGqFvbe0D03kkacRBKDf7dVISXi
	qQQ4c1pIPrU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 861D215275;
	Fri,  9 May 2014 13:16:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 16E9B1526F;
	Fri,  9 May 2014 13:16:56 -0400 (EDT)
In-Reply-To: <536c15cf8594b_6f3bb152ecb@nysa.notmuch> (Felipe Contreras's
	message of "Thu, 08 May 2014 18:39:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8C598B6-D79D-11E3-9F12-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248591>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > I already said this multiple times, but let me be clear once more:
>> >
>> > MASTER HAS A REGRESSION (for all versions of Mercurial).
>> 
>> As you said, that is not a regression, isn't it?  It is an old
>> breakage that existed even before 1.9 (was it 1.8.3 or something?)
>
> No. It does't happen in 1.9, it will happen in 2.0.
>
> That's a REGRESSION.

You earlier said in our exchange:

    > Wrong. The code in question was not recent, it was introdued in 1.8.3,
    > more than one year ago.

and "git blame -L870,880 contrib/remote-helpers/git-remote-hg" does
show that 68d4f4f3 (remote-hg: custom method to write tags,
2013-04-22) is the culplit that has introduced ManifestLookupError.

And it is in since 1.8.3.  How does it break 2.0 and without
breaking 1.9?  The dormant and otherwise unused code got its first
caller, or something?

If this were a core part of the system the only sensible thing we
can do at this point is to revert at this late stage of the cycle,
but I do not think I have time to bisect and find that culprit, as
today is when -rc3 has been scheduled to happen.
