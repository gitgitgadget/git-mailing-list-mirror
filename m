From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Wed, 29 Jul 2015 21:46:40 +0530
Message-ID: <CAOLa=ZSLkfO7enWEouGyRuRNb+f47vYnR-QM1+50yBdqqtFHFw@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
 <CAPig+cQ4PmKc0J1_X2vxn+yJ=pVd5AjM3j7j15T8ojrTPsEY_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKU2j-00053F-AY
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbbG2QRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:17:14 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34111 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbbG2QRL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:17:11 -0400
Received: by obre1 with SMTP id e1so10913375obr.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mp4wx0vbi/sM38ypmGViMSyhinLXF17V3Kb2nzCBIQI=;
        b=RFlN4ea5FivHHqHQoXXTW1lahlWTNgPG7BvSeSjUmf7djQHBhXEhEqyoPpmgSVpRh1
         UFGtDxnDl3d2MbZriWrlcI4SVKvyeI77I29vinrO7Lufa78J2msXGC4d36Mq4GaHQl/w
         G8cpDseVaJ/3nn3ZUsBGAQGv80bashktlnDNjfepnK7L41O+n0dFnntHkHngZs3Tb6rG
         eRjaxnEUo5vglyw7Alons8Ec3GxXss9AAPdS37O1or7wxHdBNsOYWYckhkErSdN8tUTa
         QqnQWf1nhjtraH1/pqZAuGQr6wBmuwqFQSJDTXxGepcKXvIW/muHjtcQzNvNQMCo06KT
         vP6g==
X-Received: by 10.60.177.195 with SMTP id cs3mr40753351oec.37.1438186630224;
 Wed, 29 Jul 2015 09:17:10 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 09:16:40 -0700 (PDT)
In-Reply-To: <CAPig+cQ4PmKc0J1_X2vxn+yJ=pVd5AjM3j7j15T8ojrTPsEY_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274917>

On Wed, Jul 29, 2015 at 3:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 27, 2015 at 3:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a new atom "padright" and support %(padright:X) where X is a
>> number.  This will align the succeeding atom value to the left
>> followed by spaces for a total length of X characters. If X is less
>> than the item size, the entire atom value is printed.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index e49d578..45dd7f8 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,6 +127,12 @@ color::
>>         Change output color.  Followed by `:<colorname>`, where names
>>         are described in `color.branch.*`.
>>
>> +padright::
>> +       Pad succeeding atom to the right. Followed by `:<value>`,
>> +       where `value` states the total length of atom including the
>> +       padding. If the `value` is greater than the atom length, then
>> +       no padding is performed.
>
> Isn't this backward? Don't you mean
>
>     ... If the atom length is greater than `value`, then
>     no padding is performed.
>
> ?

Yes, silly mistake.

-- 
Regards,
Karthik Nayak
