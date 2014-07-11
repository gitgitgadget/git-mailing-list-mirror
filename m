From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Fri, 11 Jul 2014 11:25:43 -0700
Message-ID: <xmqq4myn4us8.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	<xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
	<xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
	<xmqqmwcg561j.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2db=ZMFSvzW6be3gBv7DP93C7Z5yfOEhs9QLNOkX0fGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:25:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fW8-0007vO-5H
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbaGKSZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:25:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbaGKSZu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:25:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B886C2640D;
	Fri, 11 Jul 2014 14:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eFYIVcO2UoF3MXH0aFVG0w32nCc=; b=Jh/g7l
	KZjN0o3ot5NjMDjSZuBqd/IkqyzTlMto0CXssGiilZXfDSrzMm6yTtdO1YUa9V5t
	rfrvk1m+ZC5PcIV7DRi/NXX9z3U/KqevD1YFKVpo6c8CxoCP3D8ac/OiAR3ArkAA
	NEPvaAtyRjl0jlDABhWCW0U2rDFnL1ZaXTaj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G2HxTTxvQN9ul7B+PvmKObHyGTq3djiO
	JMRcLfvM3RYVXBC8bZxA20ht8dNFfkK2/dbpyb/wLyuTh3WrCiWbo3jCF83tmKNm
	cPzUq8JW/+BdluOTvcyzwTdQnATHSJ9Kp0qfzOmDRXVDs6m5GUwuhRy4FeIF9kgr
	HwqDfSGyh+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A898626408;
	Fri, 11 Jul 2014 14:25:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3BCE2263FA;
	Fri, 11 Jul 2014 14:25:29 -0400 (EDT)
In-Reply-To: <CAP8UFD2db=ZMFSvzW6be3gBv7DP93C7Z5yfOEhs9QLNOkX0fGQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 11 Jul 2014 18:24:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC775A6E-0928-11E4-96DE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253311>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jul 11, 2014 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> On Thu, Jul 10, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>>> "Making sure A's parent is B" would be an
>>>>> idempotent operation, no?  Why not just make sure A's parent is
>>>>> already B and report "Your wish has been granted" to the user?
>>>
>>> ... and here you say we should report "your wish has been granted"...
>>
>> Normal way for "git replace" to report that is to exit with status 0
>> and without any noise, I would think.
>
> In a similar case "git replace --edit" we error out instead of just
> exiting (with status 0), see:
>
> f22166b5fee7dc (replace: make sure --edit results in a different object)

I do not care *too* deeply, but if you ask me, that may be a mistake
we may want to fix before the next release.
