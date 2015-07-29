From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH] Port branch.c to use ref-filter APIs
Date: Wed, 29 Jul 2015 21:24:02 +0530
Message-ID: <CAOLa=ZTQSvFtNUPRNfJMsFVz7TY_u=usopYSiG2QrGuQYyAMDQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <vpqoaiwwgl2.fsf@anie.imag.fr> <CAOLa=ZTDsYDbyvCfC0Ad1uZ+5wPeFusCoa0JuzOcYS2qB8Wbjg@mail.gmail.com>
 <vpqr3nsnp7o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:54:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTgi-0003Nj-V3
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbbG2Pyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:54:33 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36447 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbG2Pyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:54:32 -0400
Received: by obnw1 with SMTP id w1so10322006obn.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AeQG66EBPMJfwD8PCkr2TGjTItXT5UwToBj9SY/2XwU=;
        b=ZZdvlt0uShvNyxs/uT+PIEwUmCUqgVk1WNFFHMSm2RB21bWXH3rtOyBEQ7PSiifIOV
         +9iApHFAE+5+LLUXJmHYaClfuPnMW4znA3gs/gc+EcXX2okuWZP1C3kqCiPnyP1RjcrL
         chRnPbSy8kvAE5fSWLr21lKBH9jpA4IhkXWW29XxTDC+7L8Mzgl50zMUDtwRtmVgJXRm
         32EjhlvUYsgaDnqtSKEFa1SB7a4C1QLAl5x+muQCCwFBFetWlryMawFEtzsLvZuw+fnT
         v5W81P3GpjnnuywJ7lnnxXrTNTsxhyFPk4AsMo4/pwo/rMrAL8OYNw/jX6Sc274XvJKR
         cMhQ==
X-Received: by 10.60.42.230 with SMTP id r6mr42828542oel.9.1438185271826; Wed,
 29 Jul 2015 08:54:31 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 08:54:02 -0700 (PDT)
In-Reply-To: <vpqr3nsnp7o.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274908>

On Tue, Jul 28, 2015 at 11:23 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 7:05 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> Ideally, you could also have a modifier atom %(alignleft) [...]
>>
>> This could work for refname, as each ref_array_item holds the refname,
>> But other atoms are only filled in after a call to
>> verify_ref_format().
>
> If you swap the order and call verify_ref_format() after filter_refs(),
> then you could detect %(alignleft) and iterate over the list as needed
> in verify_ref_format().
>
> (You would actually force swapping the order and you would need to adapt
> other callers in for-each-ref and tag)
>
>> But I don't see this as priority for now, so will mark it off for later.
>
> Absolutely, that's what I meant by "Ideally". I'm just thinking aloud.
>

Maybe after GSoC ;-)

-- 
Regards,
Karthik Nayak
