From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:33:03 -0700
Message-ID: <7vtxvu7p5s.fsf@alter.siamese.dyndns.org>
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
 <CA+sFfMdNmT5+sVdiRsWyBYNUwF+nkPcAiBswGsTjp3Yr4yZLUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fk0-0001xX-I7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab2HVSdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:33:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933252Ab2HVSdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:33:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77C0182AF;
	Wed, 22 Aug 2012 14:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOXWIjG1WOMWicfZ0rXcHebL97k=; b=GZe1To
	v1jSbxFp0EBCmzV826OESRBGA4Lnnrfhq2KF1e+wcMHAAXgeMOjIBoiNWZXxkx9J
	7+toR4VGBweSCY4YTHtVsF+ZYtDZPMYHMTp+tr69Il51Hy6a9UkhcJMLl6hXyQfA
	kEfzHuB5Gj8jxESD+r4+WPduifIK+tXuthzXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMm31yzRu2BMqX/n3maU0mOoOq8GrFSA
	1rsbUMoBLawoVIEXBIcO3WB5KiYdxUpeGqmG5ITuKfoeB6+KKSCWkbtcaYLeSfvH
	Lmbz8tGN9Nl9eaSB9S9wEADoFNX5PBAwJg1WFZ0pRxXbsapUtNpXar34897PwDKv
	uSNWH78FVv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6524082AE;
	Wed, 22 Aug 2012 14:33:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9392682AC; Wed, 22 Aug 2012
 14:33:04 -0400 (EDT)
In-Reply-To: <CA+sFfMdNmT5+sVdiRsWyBYNUwF+nkPcAiBswGsTjp3Yr4yZLUQ@mail.gmail.com> (Brandon
 Casey's message of "Wed, 22 Aug 2012 11:24:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFA2F342-EC87-11E1-ABBB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204064>

Brandon Casey <drafnel@gmail.com> writes:

> Perhaps something like:
>
> diff --git a/usage.c b/usage.c
> index a2a6678..2d0ff35 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -80,8 +80,15 @@ void NORETURN usage(const char *err)
>
>  void NORETURN die(const char *err, ...)
>  {
> +       static int dying;
>         va_list params;
>
> +       if (dying) {
> +               fputs("fatal: recursion detected in die handler\n", stderr);
> +               exit(128);
> +       }
> +       dying = 1;
> +
>         va_start(params, err);
>         die_routine(err, params);
>         va_end(params);
> @@ -89,11 +96,18 @@ void NORETURN die(const char *err, ...)
>
>  void NORETURN die_errno(const char *fmt, ...)
>  {
> +       static int dying;
>         va_list params;
>         char fmt_with_err[1024];
>         char str_error[256], *err;
>         int i, j;
>
> +       if (dying) {
> +               fputs("fatal: recursion detected in die handler\n", stderr);
> +               exit(128);
> +       }
> +       dying = 1;
> +
>         err = strerror(errno);
>         for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
>                 if ((str_error[j++] = err[i++]) != '%')

With two function-scope static, you can go like this:

die()
-> die_routine()
   -> xsomething()
      -> die_errno()
        -> die_routine()
           -> xsomethingelse()
              -> die() or die_errno()

Not that we probably care too deeply about, as at least we won't
infinitely recurse and die out of stack space.
