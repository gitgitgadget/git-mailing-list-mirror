From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add support for the google-chrome web browser
Date: Tue, 05 Jan 2010 11:56:40 -0800
Message-ID: <7veim4xr47.fsf@alter.siamese.dyndns.org>
References: <20100105051906.GA22799@efarrerlx.appsig.com>
 <7vr5q56rew.fsf@alter.siamese.dyndns.org>
 <32541b131001050920j2a569ec8u8811f1b0358f21ef@mail.gmail.com>
 <7v8wccz99g.fsf@alter.siamese.dyndns.org>
 <32541b131001051056o5853b1d2xd57d75d9a62f9f1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Evan Farrer <evan.farrer@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 20:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSFWh-0003jd-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 20:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab0AET45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 14:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165Ab0AET44
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 14:56:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0AET4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 14:56:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D71688E9BF;
	Tue,  5 Jan 2010 14:56:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ulllS+YDSp7T4XMiqbczRSZngA8=; b=BnAZul
	zlzT7U7VxKSiufLfhP+KWGAKA3E76OUyifdIcpZz8xvR2BWT5f6/mYZpC9F4uC9G
	dfOa9wpSBILlCXEbxiLzRxeFyTZd7vyrgOj9zjbeXKwNzsVRTxrYohkZRtQY+f+4
	ejIgAaBXyp5pYOalI++vbXf0vstGbnMFwdIPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3XCv2qO7CAQen3lG1LC3fFaI91m1MuZ
	YZXEA5Egu65/6BKYV9ul9G8cWb1h8K4LpXlXvwW8yIemrEr1mTg/BOtIuzhnyI+N
	5Znv7tukG3gcBUNDpagNWdsQrD1lwbA3eMNA8TPTLOpb96FbPnRMM8mcaHXLXLjA
	NNctMlDLZgY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DCD78E9BE;
	Tue,  5 Jan 2010 14:56:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 973E58E9BD; Tue,  5 Jan
 2010 14:56:41 -0500 (EST)
In-Reply-To: <32541b131001051056o5853b1d2xd57d75d9a62f9f1a@mail.gmail.com>
 (Avery Pennarun's message of "Tue\, 5 Jan 2010 13\:56\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 745C1C90-FA34-11DE-9110-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136204>

Avery Pennarun <apenwarr@gmail.com> writes:

> The current behaviour will barf right away (I think) because it
> doesn't know.  If it instead had a default case that just assumed
> non-firefox behaviour, then it would fail *strangely* (instead of
> predictably) on browsers that needed special workarounds, such as an
> as-yet-unknown firefox derivative.

Ok, I can buy that.

I have a feeling that extensibility situation of this script is similar to
that of mergetool/difftool.  Perhaps a similar approach to refactor and
then support browser-specific peculiarities by separate files, outlined in
http://thread.gmane.org/gmane.comp.version-control.git/134906/focus=135006
might work well, don't you think?
