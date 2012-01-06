From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Fri, 06 Jan 2012 14:49:05 -0800
Message-ID: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org> <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
 <20120106155204.GA17355@sigill.intra.peff.net>
 <20120106194800.GA9301@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjIb3-0004rX-Ol
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759102Ab2AFWtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:49:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab2AFWtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:49:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03471625E;
	Fri,  6 Jan 2012 17:49:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PIZfhRtLMMbQnl2NNee9JWdWxig=; b=MV1zSS
	+1dSNKxn8fDtRtQXfyg+963caVkLiXRCT3vYLUdOvqbI0xSUmRaVbqaElOmvar7V
	0KShLpTk4upYUqTAgfk/qG88eBXncPIL8Lj7xI0MUV8zNylBqR2PwaelIBYnSTLb
	qmzLEbgLpHrETaw04PBIPCLxHEPN32XWR6xQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suSFe8BD7Be676v/83fYodxpKSYnyhKc
	hrNCD8lwxU7ZwO0luhPB4f92PRakC/fZ+RLqFp3lOvAUV4q3mYp2dzEekbH38Fuo
	V9c22yvBs/KFY1lCQl1+LSu0f4GkkTvY8BTbeSMyBY0k2FXeYK/Z9GtkdJfPBATJ
	/XWMbwN4J3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD07625C;
	Fri,  6 Jan 2012 17:49:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7853A625B; Fri,  6 Jan 2012
 17:49:06 -0500 (EST)
In-Reply-To: <20120106194800.GA9301@ecki.lan> (Clemens Buchacher's message of
 "Fri, 6 Jan 2012 20:48:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A37483B8-38B8-11E1-AC90-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188054>

Clemens Buchacher <drizzd@aon.at> writes:

> I have rebased Junio's cb/git-daemon-tests onto your
> jk/child-cleanup and replaced the call to pkill with a regular kill
> command.
>
> On top of that, I have added two commits to fix the discussed race
> condition. I also verified that the race condition actually happens
> by adding an artificial delay in the daemon (this change is
> obviously not included).
>
> I pushed the new cb/git-daemon-tests to
> https://github.com/drizzd/git . If you have no objections I will
> post the entire series including your run-command and send-pack
> patches to the list.

Looked fine except that some patches seem to lack enough justification
(justification in Peff's reply was good enough).

I actually was thinking that the previous round was good enough (perhaps
dropping the "pkill" bit altogether and replacing it with "kill" on the
daemon process itself, if OSX folks complain loudly), so it is in "next"
already, but it seems that the best course of action would be to drop it
and queue your re-roll afresh, aiming for the next cycle.

Thanks.
