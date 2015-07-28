From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Wed, 29 Jul 2015 02:01:05 +0530
Message-ID: <CAOLa=ZTcMJ00WGoKwzrexmZGyaVG==vRHEZ7di+y0E2YKCO1ag@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD1Bx_o2gWP0R4EbsHO0d3LRRJ2rpHDKQhRVQpTrD6pjBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBXH-0002DH-V6
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbG1Ubg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:31:36 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:32917 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbG1Ubf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:31:35 -0400
Received: by obdeg2 with SMTP id eg2so93538405obd.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Y8QWnd1mPR8CzT6vx5bovuJkTPkR1Y1lzdUSb8TCtc=;
        b=VKXsQHJDVgB9pBD8wtVfTZXRYGCkvY4X5Z9T1FU3l2SYg83ITwrlq/sIbM3JmLMhGu
         zLgCZa++XkwGw52VeRmw9Mlzj2Ub0YLcMARX41OwJQ3ZK6498qqNZ40wVdwNBiY+Lptj
         HgBz1bu8wRA7rjzg5RVVxa8CQQ2S6r+2Gp1LCysfmX7JdQ3SvC1ZkEfv5e9tV5AKJcZR
         gCZm2yxwViotBMzBNGD2iAleDmT0eUQuzewqmEpWUsfdSctCuFl7cYT772w2gN4UaLpO
         i9eSQY8VKPTLesggyFLBibHDjYsjA/RkIC/OhYDVoAVTrxcn8LpJGTrkFw3sYwdu1+jJ
         nfaw==
X-Received: by 10.60.62.105 with SMTP id x9mr35717280oer.1.1438115494932; Tue,
 28 Jul 2015 13:31:34 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 13:31:05 -0700 (PDT)
In-Reply-To: <CAP8UFD1Bx_o2gWP0R4EbsHO0d3LRRJ2rpHDKQhRVQpTrD6pjBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274839>

On Tue, Jul 28, 2015 at 1:52 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 7d1871d..3458595 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -5,6 +5,7 @@
>>  #include "refs.h"
>>  #include "commit.h"
>>  #include "parse-options.h"
>> +#include "revision.h"
>>
>>  /* Quoting styles */
>>  #define QUOTE_NONE 0
>> @@ -48,6 +49,7 @@ struct ref_sorting {
>>  struct ref_array_item {
>>         unsigned char objectname[20];
>>         int flag, kind;
>> +       int ignore : 1;
>
> Maybe you could add a comment to say that this will be removed in the
> next patch.
>

Yes, Will do. Thanks :)

-- 
Regards,
Karthik Nayak
