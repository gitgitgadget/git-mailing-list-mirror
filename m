From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2009, #02; Sat, 05)
Date: Mon, 07 Dec 2009 12:07:35 -0800
Message-ID: <7v7hsy35vc.fsf@alter.siamese.dyndns.org>
References: <7vpr6siki5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912061738580.5582@cone.home.martin.st>
 <20091207153736.GC17173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Storsj? <martin@martin.st>, git@vger.kernel.org,
	rctay89@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHjsB-0007Pq-To
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817AbZLGUHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758783AbZLGUHn
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:07:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782AbZLGUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:07:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26E67A4AC3;
	Mon,  7 Dec 2009 15:07:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GIP9dvGwQbYQBRWUydmVTBKiwMg=; b=GcolE5fQhuTVwyEU7J86Oke
	Kf0F7Rzk/kRZzkXgkOwB3n/9zVWO15SM8DSsKxHMgRAAWDOaRkthR2dQN/kcLvUl
	eglx4XpnvqClwKJCu9l2eRSRrRXu6WcBseLK6wxJQuEhqKnHQAH6wfTuzm9TxMkK
	tL4Lyq1yskZxr+FEMn4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ntws7BXpSHfoHEpnNzsIysigOmezsLDl+gz7bt53RRBz2rscP
	zItxuC1j/OLdGpRTYxc5CkAfZgcs5wHnTetpMG4dVrwPIUwc9kfWzBpje2sgWuHs
	QmSggBXJiaFGZFGndLWcqHSlxbnZ88PCTXRA0smK/NvqXAiNnxCmRU5qUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD51FA4AC2;
	Mon,  7 Dec 2009 15:07:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1DCBFA4AC0; Mon,  7 Dec 2009
 15:07:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D988642-E36C-11DE-BEC1-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134777>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Martin Storsj? <martin@martin.st> wrote:
>> On Sun, 6 Dec 2009, Junio C Hamano wrote:
>> > 
>> > * tr/http-updates (2009-12-01) 3 commits
>> >  - Allow curl to rewind the RPC read buffer
>> >  - Add an option for using any HTTP authentication scheme, not only basic
>> >  - http: maintain curl sessions
>> > 
>> > There was a discussion on a better structure not to require rewinding in
>> > the first place?  I didn't follow it closely...
>> 
>> I think the conclusion is: Rewinding support isn't strictly necessary, 
>> there's a number of mechanisms in both git and curl that should make sure 
>> that those cases shouldn't surface. A few of them in curl have an 
>> unfortunate conincidence of bugs up until the latest version, though, 
>> leaving much fewer mechanisms in place to avoid this.
>> 
>> Since that patch is quite non-intrusive I think it's a good safeguard, 
>> though. What do you think, Tay, keep it or leave it?
>
> I think the conclusion of the thread was that what you have queued
> in tr/http-updates is OK as-is.  The patch to grow the postbuffer
> to store the entire request wasn't a good idea and got dropped.

Thanks.
