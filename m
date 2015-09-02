From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Wed, 2 Sep 2015 21:10:15 +0530
Message-ID: <CAOLa=ZQXgVXSB9FqhXnc5npOrW8HVj97i0XhNeM-k-MJHR_xfw@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-12-git-send-email-Karthik.188@gmail.com> <xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:41:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXA9l-0004js-QN
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbbIBPk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:40:57 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34778 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbbIBPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:40:45 -0400
Received: by oiev17 with SMTP id v17so7996102oie.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TTEJ2E6epPPa5fnOB9Hev5PcT2wPyPnC3UGvLef0BO4=;
        b=KnL8wCvHnnZDQmUAAsYsMZyuVv3LFy/fsV2FXRejg7MpdV/mgSyg3r7IqdOTCJF8g1
         pSEYBgFfeLk+C3QrYT0gDHyjeVEtd0A0lN7IZekvFVyNDMl6gyE8CHbvM7Ylv/FH8fhf
         PgqgXnvn4g1eqF8s8LB3LRcr/ZlCAy0NIpewxlxoLPHQzvImzZzfx2fmnvdzTH8XsWTo
         2B1mZO4sjozWg0C7j/5mqWJ4KAchlfZDVbeUdmpSAJlCfBu0joa7uX+B8Ftq3GNR0V1O
         fm4wB4BW9hKve3kWolbR9tbIhmp64cunoQfI/2PE29FG8u5RsNAMbgaIRBymwX048/RB
         20Ug==
X-Received: by 10.202.92.65 with SMTP id q62mr20035162oib.11.1441208444509;
 Wed, 02 Sep 2015 08:40:44 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 08:40:15 -0700 (PDT)
In-Reply-To: <xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277097>

On Wed, Sep 2, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +     if (filter->lines)
>> +             format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>> +                                        filter->lines);
>
> I recall hearing that you were more in favor of
>
>         "%(align:16)%(refname:short) %(end)%(contents:lines=4)"
>
> somewhere in the earlier discussions?

I did, but Matthieu suggested that this would be better!
Can't find a link to that.

-- 
Regards,
Karthik Nayak
