From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:26:36 -0700
Message-ID: <7vy5l67pgj.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
 <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
 <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
 <7v4nnxld24.fsf@alter.siamese.dyndns.org>
 <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
 <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
 <503519B3.1020403@kdbg.org>
 <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fdd-0002HN-CH
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244Ab2HVS0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:26:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933208Ab2HVS0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:26:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D5380FE;
	Wed, 22 Aug 2012 14:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J4oGOzBrOZhcY8Ov1WLeTvbe9xs=; b=M5Zj2Y
	qTsNmLJIEZ3g4izFjGZddjzJ+AkD0xiHtrsMxMjULYG+4RvUCdFoINB13wGyo2hb
	rUtLf6m2Jzc6IOixezG1Uavy8pUY27fn2Ag6uE3Toj0jksMMmiBNkoLFcXOxFUfn
	axFSSspb5Jhy4bRyO8qVZQ6FoP5yOfuOETXkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oIJNZSAojXcHYO5s1rj8kwXCkVx1XU9u
	BFy3pv3riHlGdgI3MmjTsbkiVf39TmxB0oAGbiJA3s+UYdme3aOF+Xvr+jEaG+RC
	m4cJ9+ytTCPYaMMEIVpoKqkj7OXaRN8B9VNJHRffNvjwRl7hxO2euF5o4RzujSwY
	IfI5LCelJFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 853CA80FD;
	Wed, 22 Aug 2012 14:26:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8CD480FC; Wed, 22 Aug 2012
 14:26:37 -0400 (EDT)
In-Reply-To: <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com> (Brandon
 Casey's message of "Wed, 22 Aug 2012 11:09:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E922EC88-EC86-11E1-8BA1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204062>

Brandon Casey <drafnel@gmail.com> writes:

> On Wed, Aug 22, 2012 at 10:41 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 22.08.2012 19:00, schrieb Brandon Casey:
>>>  So I think the body of [compat_mkdir] can become
>>> something like:
>>>
>>>    if (len && dir[len-1] == '/')
>>>        dir = tmp_dir = xstrndup(dir, len-1);
>>
>> Don't use x* wrappers in the compat layer, at least not those that
>> allocate memory: They behave unpredictably due to try_to_free_routine
>> and may lead to recursive invocations.
>
> I thought that rule only applied to die handlers.  i.e. don't use the
> x* wrappers to allocate memory in a die handler like
> compat/win32/syslog.c.  At least that's what I wrote in 040a6551 when
> you pointed out this issue back then.
>
> Admittedly, it could get pretty sticky trying to trace the die
> handlers to ensure they don't invoke your new compat/ function.  So,
> yeah, adopting this rule of not using x* wrappers that allocate memory
> in compat/ generally seems like a good idea.
>
> Should we also try to detect recursive invocation of die and friends?

> In theory recursion could be triggered by any die handler that makes
> use of a code path that calls an x* wrapper that allocates memory,
> couldn't it?

Correct, but at that point we will end up dying anyway, so...
