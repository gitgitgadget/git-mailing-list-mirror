From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v5] diff --stat: tests for long filenames and big
 change counts
Date: Thu, 16 Feb 2012 12:01:38 -0800
Message-ID: <7vd39ezgwt.fsf@alter.siamese.dyndns.org>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
 <7vvcn810ml.fsf@alter.siamese.dyndns.org> <4F3CD318.1040600@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:01:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry7WU-0003th-H8
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab2BPUBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 15:01:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab2BPUBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 15:01:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 157B57C4B;
	Thu, 16 Feb 2012 15:01:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xcvzncIFCi88
	ShhSzFpqrKqpMzU=; b=Lhd+MotuuQCrm+Xmas/cqIRtLwImDe0x0xviwYZrabAx
	NjEr6gn6wkfBAurkmzJF+vyFr8XYMEF3rTQHDBCHicssVyUfxibFMh1u0fOVlDCJ
	z7TFf4T53Tv4M7fY+pSD3mfVJVeoOs9E4MFaSFu+VKv/lV+togKCBLyeE9IC2HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RVpAyX
	vs1lXWnxiJHZ4Euh8TPYmehB/lZGq55hRZmWzQpMBCLO/RYl/dowHfJG5hTXKgin
	7D0PKGigS4kIxE5EUF99yQlxt9mFi92yHxdAXAFADF9jtEJ4RzcUr0Mf/OxHTXeD
	hOe3j0om9nrz2+JNPlYnPFBwsacJlX4yhiKyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B4E17C4A;
	Thu, 16 Feb 2012 15:01:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CCF07C49; Thu, 16 Feb 2012
 15:01:39 -0500 (EST)
In-Reply-To: <4F3CD318.1040600@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 16 Feb 2012 10:57:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F73866-58D9-11E1-A360-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190903>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 02/15/2012 06:12 PM, Junio C Hamano wrote:
>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>>
>>> Eleven tests for various combinations of a long filename and/or big
>>> change count and ways to specify widths for diff --stat.
>>> ---
>>
>> Sign-off?
>
>> Hrm, this does not seem to pass, making the result of applying [1/3]=
 fail;
>> I see that the elided name is shown much shorter than the above expe=
cts.
>
> Hi,
>
> I'm sorry for not properly testing the patch with tests. I somehow
> convinced myself that the tests pass. This whole series needs more
> work, even after squashing in your two patches.

It is nothing to be sorry about if a series needs more polishing; that =
is
what the review discussions are for.

I've queued the series after restructuring it, and merged except for [3=
/3]
to 'pu', which conflicts too heavily with the nd/diffstat-gramnum topic
that is already in 'master'.  I'd say we should concentrate on your fir=
st
two patches without the "num-width" stuff and get them in first, and th=
en
later consider if rerolling the [3/3] patch is worth it after the dust
settles.

Thanks.
