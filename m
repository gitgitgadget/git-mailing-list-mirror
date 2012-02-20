From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 11:56:13 -0800
Message-ID: <7vr4xpl1nm.fsf@alter.siamese.dyndns.org>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZLR-00007Y-FF
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab2BTT4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:56:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2BTT4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:56:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AEC7B40;
	Mon, 20 Feb 2012 14:56:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jc36WDTc7SgeDTli/KitrDXoFLA=; b=iAo6dR
	cWMtB2tUhuBsCnNCa21cdyzTT3lIH4/4I2xIW1KBc2fmTVpT6IVkXI/hnaeGj4dB
	KRIXn3CWZchHfBU/C2jHgDIHjVHdvZ9oZ1WQ46GREp7B0MIPZs4mG7Xz0qmV/GtL
	4jns38gxGKMIu3Y+ZsmfuJxG1NacujXS5XKCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dera8lquhzVpkrqj382qvff64Q6Hg7M4
	wkQOQoRDCNr5uNyEa9mBOIlB89xhR2jRLIR1b+Tjqa6cCuBnTQNwQkyao5XrGZTr
	k1aByQ/0g5wD54u36SVhWAIsb2CL10TW2BTzCbsVYgZxO8qNcCN7JIM4pt2wtR9Z
	XRlp4hCkWcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67987B3F;
	Mon, 20 Feb 2012 14:56:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FBB97B3E; Mon, 20 Feb 2012
 14:56:15 -0500 (EST)
In-Reply-To: <20120220140653.GC5131@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Feb 2012 09:06:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2376B34-5BFC-11E1-B60D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191093>

Jeff King <peff@peff.net> writes:

> Interestingly, on my git.git repo, I had an empty cache. Running "git
> read-tree HEAD" filled it (according to test-dump-cache-tree). It seems
> that running "git checkout" empties the cache.  So perhaps git could do
> better about keeping the cache valid over time.

At least in the early days unpack-trees built the result by manually
adding an entry without calling the add_index_entry() all over the place,
which meant that it was futile to pretend that there is even a slight
chance that complex beast would correctly invalidate cached tree
information at all the necessary places. I recall that I added a code to
nuke the cache tree at the very beginning of "merging" codepaths to avoid
any bogus cache tree result to be stored in the resulting index.

These days, we have src_index and dst_index, and dst_index IIRC can start
as empty in which case "start from kept information and selectively
invalidate" would not work at all.  When src_index and dst_index are the
same, however, you should be able to keep the cached tree valid, at least
in theory.
