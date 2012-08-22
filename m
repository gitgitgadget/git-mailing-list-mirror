From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 14:12:17 -0700
Message-ID: <7vobm2637y.fsf@alter.siamese.dyndns.org>
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
 <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
 <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de>
 <7v628a7iu5.fsf@alter.siamese.dyndns.org>
 <004501cd80a9$d01ecc00$705c6400$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4IDz-0001uL-FM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304Ab2HVVMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:12:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933209Ab2HVVMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:12:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 368738A78;
	Wed, 22 Aug 2012 17:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eJLfjPMTCH7jmPtDWuaSBzgplmc=; b=LB5sOv
	+xu9NBQQ3afHuXoZFnhkb5xQRCUZ/2lGO9ocxf79TbJkQ2R2/W4LgWr48mqt2fF6
	afGFBFegsOVK2QXddEYe7Z7Fu9jM7AQDrFD+gLz1XtezRWrB1zTpVhARx+saqMeq
	LLzQw2ciB9EtkabqBZz1U9ifauz5pWXLN9pAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eGMZZPOiaENU0cx6zu0QNZ60HJGnAhXq
	kcKLf3iRaaSRqmteAztHqoNo/aB0cD3BWDyYDyCyYHcnwCgwi0BHMInnuEWHdqdv
	uybI53hzR90Z9M3kHvU/Pj9ijg7R24ldPQOMCUdcL/phPK91qa2GD0lYSRH96T0C
	AdNNwm4+NOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9EF8A77;
	Wed, 22 Aug 2012 17:12:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 736AB8A76; Wed, 22 Aug 2012
 17:12:19 -0400 (EDT)
In-Reply-To: <004501cd80a9$d01ecc00$705c6400$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 23:05:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EC80380-EC9E-11E1-90F0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204098>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> If it helps your port, compat/itimer.c sounds like a good place.
>> Doesn't it need a new header file to introduce structures and constants,
> too?
>
> You mean the ITIMER_* and struct itimerval, right?
> On NonStop these are available in <sys/time.h>, so here's no need to add
> them.

At least you would need a header to declare these two functions and
make them visible so that the remainder of the codebase will not
have to know about git_setitimer(), no?  Or does your header files
on NonStop declare setitimer() but does not implement it?

As your proposed name is not compat/tandem.c but more generic
sounding compat/itimer.c, we would have to plan for systems other
than NonStop, so we may later have to introduce makefile variables
to ask that header file to declare the structure and define the
constants that are missing from such a system.  While you are
porting to NonStop, you may not have to define/declare them, but
knowing that these files are the place to later do so is part of the
planning.
