From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 13:49:38 -0700
Message-ID: <7v628a7iu5.fsf@alter.siamese.dyndns.org>
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
 <7vtxvu7p5s.fsf@alter.siamese.dyndns.org>
 <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
 <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Hs6-0004Re-4A
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 22:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297Ab2HVUto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 16:49:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231Ab2HVUtm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 16:49:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D263A84CB;
	Wed, 22 Aug 2012 16:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hDh79y84kwYVatN2c/0R8bjcHr0=; b=g0c4vm
	rOFtb44utkNXykp4JhZpuwD89xdLz2GUw7YLcqcoHxkac8ewwqtttM0b5d0+rxvz
	S82CQfzWQSJBxNt6SxAnlA0YLCyHJ7GYHBkSAjik0e9p/uBag+ObD2M3bG0fCn3D
	DUDbNXg9mUR9nbyK+gVokhR2PpY/Jx4vAbiMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LGVUh0Whn7neUlW7Fl5ED1IX+TS1G2jF
	xwsQfafJslziIXD1WyEb2nwraDM43aCezyLzE80WxSWRvPLApCkzu3nG0GxGpwJM
	w9zN68WYsPB2rP/pZmZIw1jXR99zvPBxkEWRMXStdpcgR2Hh9yF71pwgeEsfCJEf
	l63gwMWrA3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C034084CA;
	Wed, 22 Aug 2012 16:49:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0447C84C9; Wed, 22 Aug 2012
 16:49:39 -0400 (EDT)
In-Reply-To: <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 22:18:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E47BB034-EC9A-11E1-A9FC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204092>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Hi folks
>
> There another API missing on HP NonStop and that is setitimer(), used in progress.c and build/log.c
> I do have a homebrewed implementation, on top of alarm(), it goes like this:
>
> #include "../git-compat-util.h"
> #undef getitimer
> #undef setitimer
>
>
> int
> git_getitimer(int which, struct itimerval *value)

See Documentation/CodingGuidelines for style nits.

> {
>         int ret = 0;
>
>         switch (which) {
>                 case ITIMER_REAL:
>                         value->it_value.tv_usec = 0;
>                         value->it_value.tv_sec = alarm(0);
>                         ret = 0; /* if alarm() fails we get a SIGLIMIT */
>                         break;
>                 case ITIMER_VIRTUAL: /* FALLTHRU */
>                 case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
>                 default: errno = EINVAL; ret = -1;
>         }
>         return ret;
> }
>
> int
> git_setitimer(int which, const struct itimerval *value,
>                         struct itimerval *ovalue)
> {
>         int ret = 0;
>
>         if (!value
>                 || value->it_value.tv_usec < 0
>                 || value->it_value.tv_usec > 1000000
>                 || value->it_value.tv_sec < 0) {
>                 errno = EINVAL;
>                 return -1;
>         }
>
>         else if (ovalue)
>                 if (!git_getitimer(which, ovalue))
>                         return -1; /* errno set in git_getitimer() */
>
>         else
>         switch (which) {
>                 case ITIMER_REAL:
>                         alarm(value->it_value.tv_sec +
>                                 (value->it_value.tv_usec > 0) ? 1 : 0);
>                         ret = 0; /* if alarm() fails we get a SIGLIMIT */
>                         break;
>                 case ITIMER_VIRTUAL: /* FALLTHRU */
>                 case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
>                 default: errno = EINVAL; ret = -1;
>         }
>
>         return ret;
> }
>
>
> Worth being added to compat/, e.g. as setitimer.c, or, as itimer.c
> (as a by-product, it has getitimer() too)?

If it helps your port, compat/itimer.c sounds like a good place.
Doesn't it need a new header file to introduce structures and
constants, too?
