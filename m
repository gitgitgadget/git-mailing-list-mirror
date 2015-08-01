From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Sat, 1 Aug 2015 12:16:04 +0530
Message-ID: <CAOLa=ZTC9xJu9WCnF9VVf9wRLSK4=R3576UJ6CqAC7GEGDbCOQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com> <CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
 <xmqqy4hy973q.fsf@gitster.dls.corp.google.com> <xmqqtwsm94j1.fsf@gitster.dls.corp.google.com>
 <vpqh9omek39.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Aug 01 08:46:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQZ4-0004fj-Fz
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 08:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbbHAGqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 02:46:34 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35191 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbHAGqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 02:46:33 -0400
Received: by obbop1 with SMTP id op1so68583372obb.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4N2pncQCMcKZyOPnSzwgkOTHDqLqcHb0PjIaSBHEGDk=;
        b=0TYKuLMm5QEJ6TQI0A7eJFjfqThLOAbWuHbRGkSVc1cr1mg3tErgDozqki2KRf+q1K
         StmNoJwuPD3Qd0lhw+s3ZbVl2YKV9abhjqA5IoRzj0uOQDltNg19R5B6gs0gsO3zeCKE
         jgtJ4X7Gd7tx+ihNzvIoH0ABHrwt+xeeblSThJJcktcM+G8nnTjDkS3+rIMVBNRapsFS
         RugZxMKgi/X5ZfmUhyPU5z7ZTtRZO88/nVpCttsGkjCgClQRsV49YiCFX5iLmrHncUTB
         DefhnTQjuonVDyM474ZUe1uk7BbEg6s8ny657k+7yyIsn7Mw+F70uABNXjvdbFXBkGfe
         mFdQ==
X-Received: by 10.60.177.195 with SMTP id cs3mr7268595oec.37.1438411593368;
 Fri, 31 Jul 2015 23:46:33 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 31 Jul 2015 23:46:04 -0700 (PDT)
In-Reply-To: <vpqh9omek39.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275110>

On Thu, Jul 30, 2015 at 2:51 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> Couldn't think of a better replacer, any suggestions would be welcome :)
>>>
>>> See below.
>>> ...
>>> One way to do all of the above is ...
>>
>> Note that is just "one way", not the only or not necessarily the
>> best.  It certainly is not the easiest, I think.
>>
>>     %(if:atom)...%(endif)
>>
>> might be easier to implement.
>
> And I find it easier to read or write too. Nested parenthesis in a
> format string make them really tricky. That removes the need for
> escaping since the content of the if/endif is a format string like the
> others, it can use the same escaping rules (IIRC, %% to escape a %).
>

THat's a really good point. Will work on this :)

-- 
Regards,
Karthik Nayak
