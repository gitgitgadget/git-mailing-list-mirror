From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:38:59 -0700
Message-ID: <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
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
	<7vtxvu7p5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:39:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fpd-0000Xu-5i
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045Ab2HVSjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:39:04 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40424 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965041Ab2HVSjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:39:00 -0400
Received: by vbbff1 with SMTP id ff1so1377180vbb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GL/ldZ1szAUDFP9H43LC6iX+95y0qWkgKLYXwbmRSDM=;
        b=TELX75DLmxBd8WGCkTJPhzHssrR+Qopqe1gFELL1/CpLHiqVFsNj38HhyqlSOoac3O
         Qse/ceDOCnsFBkv+glZyR8kQMVaYhbC/UXQOcVtEpqwQousLfa/o1ASn3tuPQx2pNyHC
         Fno+mD6LVUFw4/vXToUkkgad6z3Iclz3Ectovz5AXXtlt4syeTKTjKLfXRrMvuMqlPeP
         +uZChuxtLeGOfqVdPNZTv0RgsqEV7x1+WWYbJbYaigW9E0i9Lasz9zsMSzM+yeHluQCw
         KnR3hpwNEYW0vW4+YRyoneseWbALHL1ycFYF8+tkxwEaYQlBLh8ah3Ms6mtErh/X+6/p
         1fqQ==
Received: by 10.52.64.242 with SMTP id r18mr15085116vds.90.1345660739118; Wed,
 22 Aug 2012 11:38:59 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 11:38:59 -0700 (PDT)
In-Reply-To: <7vtxvu7p5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204065>

On Wed, Aug 22, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> Perhaps something like:
>>
>> diff --git a/usage.c b/usage.c
>> index a2a6678..2d0ff35 100644
>> --- a/usage.c
>> +++ b/usage.c
>> @@ -80,8 +80,15 @@ void NORETURN usage(const char *err)
>>
>>  void NORETURN die(const char *err, ...)
>>  {
>> +       static int dying;
>>         va_list params;
>>
>> +       if (dying) {
>> +               fputs("fatal: recursion detected in die handler\n", stderr);
>> +               exit(128);
>> +       }
>> +       dying = 1;
>> +
>>         va_start(params, err);
>>         die_routine(err, params);
>>         va_end(params);
>> @@ -89,11 +96,18 @@ void NORETURN die(const char *err, ...)
>>
>>  void NORETURN die_errno(const char *fmt, ...)
>>  {
>> +       static int dying;
>>         va_list params;
>>         char fmt_with_err[1024];
>>         char str_error[256], *err;
>>         int i, j;
>>
>> +       if (dying) {
>> +               fputs("fatal: recursion detected in die handler\n", stderr);
>> +               exit(128);
>> +       }
>> +       dying = 1;
>> +
>>         err = strerror(errno);
>>         for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
>>                 if ((str_error[j++] = err[i++]) != '%')
>
> With two function-scope static, you can go like this:
>
> die()
> -> die_routine()
>    -> xsomething()
>       -> die_errno()
>         -> die_routine()
>            -> xsomethingelse()
>               -> die() or die_errno()
>
> Not that we probably care too deeply about, as at least we won't
> infinitely recurse and die out of stack space.

Yeah, I noticed that, but didn't think it was important or likely.
But there's no reason not to make "dying" a global.

-Brandon
