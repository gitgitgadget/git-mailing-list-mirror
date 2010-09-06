From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Mon, 06 Sep 2010 16:34:00 -0700
Message-ID: <7v8w3etpjr.fsf@alter.siamese.dyndns.org>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
 <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
 <4C81A67B.2060400@gmail.com>
 <alpine.LFD.2.00.1009032304560.19366@xanadu.home>
 <4C81DC34.2090800@gmail.com>
 <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
 <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
 <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
 <alpine.LFD.2.00.1009042132500.19366@xanadu.home>
 <AANLkTi=YLx6MqbWd_N0geXbuXLdqAUOneGoym75dfthL@mail.gmail.com>
 <alpine.LFD.2.00.1009051820100.19366@xanadu.home>
 <AANLkTi=CEOj40Sj+zegvX+ry8-y6p7UwsyqdtoHB1d-T@mail.gmail.com>
 <alpine.LFD.2.00.1009061025210.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslCh-00089z-FL
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab0IFXeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:34:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0IFXeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:34:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18EFAD334A;
	Mon,  6 Sep 2010 19:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=juUcpC40rnE8YPHSp38+5Zu1D1Q=; b=VdRfmg
	Oz5MHpM9vjpWmRkalhNHdCVWP4jc8PyDqtBUe3lxl5sFaGcWXYnE/lTwQlbaj32s
	A4Nlf84a/1dVFmhQEeOobhuuOKQoTQXmdVrXKvTN51vxJ/ry1woN2hFcSnFmVbvf
	Mn5ZWao/+QRb4ZehifKVI/jlzryaudIa7X4ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcmYLwvd5hV/rttGT2Dr4wHk+k1Rroq0
	88oIBHh5NIIwI0FSQKqlQLAzwmOucFw5VPt0L1v07KDX3P7Gxnl7jjfCzkADnT7M
	d7DvrPCTchRLjhR+ivZy18eXA7KwILtIxYedCOuUpxLeJmitt4M8HJTD0sQp5Slo
	3WlBS0Vgym4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 648EDD3343;
	Mon,  6 Sep 2010 19:34:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C03DD333F; Mon,  6 Sep
 2010 19:34:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1009061025210.19366@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 06 Sep 2010 12\:51\:47 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F4EDF6A-BA0F-11DF-ABA5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155640>

Nicolas Pitre <nico@fluxnic.net> writes:

>> * enumerate the list of objects associated with an individual commit by:
>>     i) creating a CUSTOM pack+idx using git pack-objects {ref}
>>     ii) *parsing* the idx file using gitdb's FileIndex to get the list
>> of objects
>
> That's where you're going so much out of your way to give you trouble.  
> A simple rev-list would give you that list:
>
> 	git rev-list --objects <this_commit> --not <this_commit''s_parents>
>
> That's it.

I didn't want to get into this discussion, but where in the above picture
does the usual "want/ack" exchange fit?

The biggest trouble before object transfer actually happens is that the
sending end needs to find a set of commits that are known to exist at the
receiving end, but it needs to do that starting from a state where the tip
commits the receiving end has are not known by it.  That is why the
receiver must go back in his history and keep asking the sender "I have
this, this, this, this...; now have you heard enough?"  until the sender
sees a commit that it knows about.  After that happens, it can list them
on its "git rev-list --objects <my tips> --not <he has these>" command
line in order to enumerate objects it needs to send.

If the receiver is purely following the sender, not doing any work on its
own, the tips the receiver has may always be known by the sender, but that
is not an interesting case at all.
