From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 08 Sep 2009 13:31:12 -0700
Message-ID: <7vocplxjov.fsf@alter.siamese.dyndns.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909080512.34634.johan@herland.net>
 <7vd462qdeg.fsf@alter.siamese.dyndns.org>
 <200909081054.02523.johan@herland.net>
 <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7Ls-000448-U9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZIHUbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZIHUbe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:31:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZIHUbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:31:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8614B49918;
	Tue,  8 Sep 2009 16:31:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=B1EfG7CzdtYpSsELhZZztpYekFA=; b=uzCx2JsYfMTxBF4On4GEIhY
	p+6Mrd/mOHQc7OS8L3kg0LsHU2y27TTPeBbuMRmhdxnYoS6Mwsi9PIlpRBB7rcjM
	M5dJG1X2hzXwa03XxMiECkaoq1QFhK975zrLBco2eIoAeL8nP5aYlUYhHg/dud/3
	JpomZ4iSWjBYXcXY9oI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=n0aM0pmEutb2Z1+LLxQyS1r7DjVxURvk818NsaKwGtg3IyV6J
	kl+YF6IS6MVf4h8WVuyjaewPgTw83+lw6PGbaXnx8HN7B6Y6Kde9zsG2sGkvsTmr
	rslINwowOcG99QH8h+9JYPgzfKaH2ruID1Oo32twTvLz9tLkQdxFnhY4tg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14D2F49912;
	Tue,  8 Sep 2009 16:31:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CF764990D; Tue,  8 Sep 2009
 16:31:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95E3986A-9CB6-11DE-A768-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128032>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 8 Sep 2009, Johan Herland wrote:
>
>> Algorithm / Notes tree   git log -n10 (x100)   git log --all
>> ------------------------------------------------------------
>> next / no-notes                4.77s              63.84s
>> 
>> before / no-notes              4.78s              63.90s
>> before / no-fanout            56.85s              65.69s
>> 
>> 16tree / no-notes              4.77s              64.18s
>> 16tree / no-fanout            30.35s              65.39s
>> 16tree / 2_38                  5.57s              65.42s
>> 16tree / 2_2_36                5.19s              65.76s
>> 
>> flexible / no-notes            4.78s              63.91s
>> flexible / no-fanout          30.34s              65.57s
>> flexible / 2_38                5.57s              65.46s
>> flexible / 2_2_36              5.18s              65.72s
>> flexible / ym                  5.13s              65.66s
>> flexible / ym_2_38             5.08s              65.63s
>> flexible / ymd                 5.30s              65.45s
>> flexible / ymd_2_38            5.29s              65.90s
>> flexible / y_m                 5.11s              65.72s
>> flexible / y_m_2_38            5.08s              65.67s
>> flexible / y_m_d               5.06s              65.50s
>> flexible / y_m_d_2_38          5.07s              65.79s
>
> It's good to see that the no-notes behaves roughly like baseline.
>
> I can see that some people may think that date-based fan-out is the cat's 
> ass,

Actually, my knee-jerk reaction was that 4.77 (next) vs 5.57 (16tree with
2_38) is already a good enough performance/simplicity tradeoff, and 5.57
vs 5.08 (16tree with ym_2_38) probably does not justify the risk of worst
case behaviour that can come from possible mismatch between the access
pattern and the date-optimized tree layout.

But that only argues against supporting _only_ date-optimized layout.

Support of "flexible layout" is not that flexible as its name suggests;
one single note tree needs to have a uniform fanout strategy.  But it is
not unusably rigid either; you only need to be extra careful when merging
two notes trees.  We can leave the heuristics to choose what the optimum
layout to later rounds.

> - I find the restriction to commits rather limiting.

Yeah, we would not want to be surprised to find many people want to
annotate non-commits with this mechanism.

> - most of the performance difference between the date-based and the SHA-1 
>   based fan-out looks to me as if the issue was the top-level tree.  
>   Basically, this tree has to be read _every_ time _anybody_ wants to read 
>   a note.

A comparison between 'next' and another algorithm that opens the top-level
notes tree object and returns "I did not find any note" without doing
anything else would reveal that cost.  But when you are doing "log -n10"
(or "log --all"), you would read the notes top-level tree once, and it is
likely to be cached in the obj_hash[] (or in delta_base cache) already for
the remaining invocations, even if notes mechanism does not do its own
cache, which I think it does, no?

> - I'd love to see performance numbers for less than 157118 notes.  Don't 
>   get me wrong, it is good to see the worst-case scenario in terms of 
>   notes/commits ratio.  But it will hardly be the common case, and I 
>   very much would like to optimize for the common case.
>
>   So, I'd appreciate if you could do the tests with something like 500 
>   notes, randomly spread over the commits (rationale: my original 
>   understanding was that the notes could amend commit messages, and that 
>   is much more likely to be done with relatively old commits that you 
>   cannot change anymore).

Hmph, is that a typical use case?  How does it relate to CC's object
replacement mechanism?

Also Gitney talked about annotating commits in the code-review thing.
What's the expected notes density and distribution in that application?
