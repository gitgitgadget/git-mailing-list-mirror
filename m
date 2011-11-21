From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revert: rename --reset option to --quit
Date: Mon, 21 Nov 2011 12:36:23 -0800
Message-ID: <7vpqglfc1k.fsf@alter.siamese.dyndns.org>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111120094824.GC2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 21:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSabk-0006QT-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 21:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293Ab1KUUg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 15:36:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab1KUUgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 15:36:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29AA5B12;
	Mon, 21 Nov 2011 15:36:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyFzfv90x2NXN2TJTPubauBHAUo=; b=M6dAMX
	p2rXwBVFlOBnOd5tAbKyG9UZGw/msCTFrKLIoVVJ8yGl6JtP2Iq1wd4zQGv6ZiK4
	GJEKwfIi/3E4L50y9h6n+/UNOJzB84XyRJ/ZrdF1F6QrksRVIuDEEZvKcbezZUSI
	9QaAutckacP32dWFma+1dwVmSmmNyZf1ln+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IzhxZ0B3B4PDwXd5PnTP5Hya/XtIEDiF
	/fMXDEhcCSt/g/uMjKa35ZIFiEKYiuLF/OLCxvpdQEoDS0iqoR18o1z8dHIpKV+5
	vHntaPcqjIVjMh0TDHRbkw2Dcj55RrQm8pxir8MQHoW0ot98BBOOOSqB4mVwRs1z
	lmGqQ1B+RgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D97555B10;
	Mon, 21 Nov 2011 15:36:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 688065B0F; Mon, 21 Nov 2011
 15:36:24 -0500 (EST)
In-Reply-To: <20111120094824.GC2278@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Sun, 20 Nov 2011 03:48:24 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB2734C-1480-11E1-8AD0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185761>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The option to "git cherry-pick" and "git revert" to discard the
> sequencer state introduced by v1.7.8-rc0~141^2~6 (revert: Introduce
> --reset to remove sequencer state, 2011-08-04) has a confusing name.
> Change it now, while we still have the time.
>
> Mechanics:
>
> This commit removes the "git cherry-pick --reset" option.  Hopefully
> nobody was using it.  If somebody was, we can add it back again as a
> synonym.
>
> The new name for "cherry-pick, please get out of my way, since I've
> long forgotten about the sequence of commits I was cherry-picking when
> you wrote that old .git/sequencer directory" is --quit.  

Wouldn't it match other commands better if we called this --abort instead
of --quit?

Other than that I think I agree with the reasoning (and I think I too had
encountered the irritation with the "sequencer state").
