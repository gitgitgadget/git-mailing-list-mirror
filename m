From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Sun, 16 Aug 2015 19:49:10 -0400
Message-ID: <CAPig+cQHdB9y+_+apWuz6hCZZfvXgTy6=jMrz7Zs_6JY0P=-zg@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
	<CAOLa=ZS1gQuKYqYGjXx3M_XLFsc5uAxYcD6c-d-WJG7S_spYag@mail.gmail.com>
	<87lhdbl9r2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 01:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR7fx-0002LI-43
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 01:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbbHPXtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 19:49:12 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36750 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbHPXtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 19:49:11 -0400
Received: by ykfw73 with SMTP id w73so58503982ykf.3
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3zdEDQCP60t2pBGZtlyDW8FAZ/JPOGNwsuhnNK5bN4Y=;
        b=SAfQc3kaFmUMZe2AMmTLBDFurwtiI2xHAwrLFDs1rS6WZwDi82WGy/w48BSXwpcOiV
         lALO+13Q4OGkgKSGZ4BuuVHyVUEolwCpJHZkkIcDbDZDK1YrR/ty7q6ToPcE06IU3otJ
         C8Scpe4yPTYbeoTdeaBtSeziw9lMeYVImhiVZNfeQQXbhPpNrEcc2shfxjMNPu3Ec8ro
         Ck8DCnb1N6aoriiZZK7LcH0Z0FjgvmigZW7zxOKd9yypk2/AvLu7lBN3b3HfpXy8V2+n
         5QE09GjhFrk/MONw5G6x6x/GG81MrmZFS3LbZEY9ls6Y76EJP0Os7E+AEnVF7Mxmx0mn
         uW/g==
X-Received: by 10.170.55.70 with SMTP id 67mr39948748ykx.82.1439768951063;
 Sun, 16 Aug 2015 16:49:11 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 16:49:10 -0700 (PDT)
In-Reply-To: <87lhdbl9r2.fsf@igel.home>
X-Google-Sender-Auth: 4GFc6AnV7WJeFj4wHHgdW5xG6pA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276027>

On Sun, Aug 16, 2015 at 8:04 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>> I think we need to squash this in
>>
>> diff --git a/Documentation/git-for-each-ref.txt
>> b/Documentation/git-for-each-ref.txt
>> index 3099631..17bd15e 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -129,7 +129,7 @@ color::
>>
>>  align::
>>         left-, middle-, or right-align the content between %(align:..)
>> -       and %(end). Followed by `:<position>,<width>`, where the
>> +       and %(end). Followed by `:<width>>,<position>`, where the
>
> s/>>/>/

Also: s/left-/Left-/
