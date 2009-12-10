From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Thu, 10 Dec 2009 09:20:28 -0800
Message-ID: <7vpr6mkaoz.fsf@alter.siamese.dyndns.org>
References: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet> <m2pr6ocqrb.fsf@igel.home>
 <20091209120610.GA29430@atjola.homenet> <20091209120748.GI2977@redhat.com>
 <20091209130653.GA30218@atjola.homenet>
 <7v1vj4orra.fsf@alter.siamese.dyndns.org>
 <20091210074358.GA7723@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 18:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NImhG-00085p-1x
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 18:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760982AbZLJRUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756402AbZLJRUp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 12:20:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZLJRUp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 12:20:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0533B3AA;
	Thu, 10 Dec 2009 12:20:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F8kO2gUvNGIi
	NUt7jYjsikNtb58=; b=TWwXbMpcOVsxImqIAWPKaUbZw5KKypn6kOhrAz4H13Qu
	LrQBkZfHsFir+bfuma6tFRQGNRdmOqd/hyTo2kfmOS/LRWQNLvL1e1dGbwme0RkY
	3bWmBm18XzLubNlOjRNQ98m35wYzCvPrMASUG7nE0fntXKBgZ1adHrqda0jaGK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GXfDk9
	cZLd+lz1fcg4/B5+23KKNQPYPICVWvsvJwwDUaXm6EGuzkJNOyCDG2NUiQA0lPOT
	eF3Y9lparRHuEt+u2Ihw0B4C9a+bWQ5/Y85uP5c7VjeCwjvpxMZS/JhQ2yosoG6d
	ebdkis+sf5CbLZF4U07hurQDbDcGXC2rlNcpk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBB833A2;
	Thu, 10 Dec 2009 12:20:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F186F396; Thu, 10 Dec
 2009 12:20:29 -0500 (EST)
In-Reply-To: <20091210074358.GA7723@atjola.homenet> (=?utf-8?Q?=22Bj=C3=B6?=
 =?utf-8?Q?rn?= Steinbrink"'s message of "Thu\, 10 Dec 2009 08\:43\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5606A884-E5B0-11DE-B1F5-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135037>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

>> But at the conceptual level, "merge --squash" is a short-hand for th=
is
>> command sequence:
>>=20
>>     git rebase -i HEAD that-branch
>>     ... make everything except the first one into "squash"
>>     git checkout - ;# come back to the original branch
>>     git merge that-branch ;# fast forward to it
>>=20
>> So after all, it is "merge it after squashing them".
>
> To me, that approach looks backwards,...

Yes, of course, but what you are missing (and I am at blame for forgett=
ing
to mention the history behind this in the message you are responding to=
)
is that "merge --squash" to support a particular need/use case was done
way before "rebase -i" came into existence.

Here is how "merge --squash" is explained in the log message:

    git-merge --squash
   =20
    Some people tend to do many little commits on a topic branch,
    recording all the trials and errors, and when the topic is
    reasonably cooked well, would want to record the net effect of
    the series as one commit on top of the mainline, removing the
    cruft from the history.  The topic is then abandoned or forked
    off again from that point at the mainline.

A nicer workflow may be to use "rebase -i" to clean up the history befo=
re
even contemplating to integrate the topic to the mainline, instead of t=
he
above "abandoning or forking off again", if you know today's git. =20

But interactive was not available back then.  It was introduced at 1b1d=
ce4
(Teach rebase an interactive mode, 2007-06-25), which is 1 year after
7d0c688 (git-merge --squash, 2006-06-23).
