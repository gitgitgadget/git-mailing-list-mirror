From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t3034: add rename threshold tests
Date: Tue, 23 Feb 2016 19:55:53 -0500
Message-ID: <CAPig+cR_p2aKU9VRpiyomdOo+Ucnxr82dh2uqBaR6TTsN9B4qw@mail.gmail.com>
References: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
	<1456271292-4652-2-git-send-email-felipegassis@gmail.com>
	<CAPig+cQ+MF7Nsvp7jASXPtPjNWT_g865ot45Y1Q347Y1iCDeYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:55:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYNkE-0002BS-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 01:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbcBXAzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 19:55:55 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33226 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbcBXAzy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 19:55:54 -0500
Received: by mail-vk0-f41.google.com with SMTP id k196so3050407vka.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 16:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=U+6NE4W+S4J+URu9/a4uaftJj/dGH28oyK81RfvkkUQ=;
        b=gk9KRSoMyDVjcDzNLr5uCKmUWkAij1wsIztk9DcnXeFRvjqujoLDBqHxUOx/YBqjJW
         yW4ADGCw5ZSjRGblMnAfxLWuorV1CR/W7b3cbs36LBK7cTgpycG+RTs04JTe98k77B7r
         7a+RS6+ChVbHpvicEAMUB1BTsivReUql980Vy90fo9JqqquyOvxceZXq5a/tlBmQAeO2
         nU4H95H6L3gHsCdk//Nn5xuFdoCQ+b9adUa1qcScpJ5gzPRHs+wVHOqFHSX5JQfLMkXS
         qfbaNzApfe11inj72juhe3eaxJNSqfiivnuizrZBTHcDmCZj4g5TZGC8gVAhL4EqNM+g
         kwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U+6NE4W+S4J+URu9/a4uaftJj/dGH28oyK81RfvkkUQ=;
        b=VnGDV8TdNKgtj8xU7bqvBFDCw7P2ZCjdcYH0GGKt5BJKywrBMn7d6ZhbWg06nHuQJM
         6J/+YMMwnCLVXOLomAXAQHb2FD94VvVR1r8BEcR/dbJoAPSqTOShpRCqJxPcbQYH69Sh
         5bZT/cS/OFBm9eculr3vca843GkBiqkLs2Qod79QtvwgjcHC7j4j65vWuwp7xWxXwTil
         qfK7/GXro5i9kqAoHgEpVyGPtZUuIzYIdwqnIL2Yx2sQ2jeCV+GarZtRiowtwnPRdi2A
         7tsqiYGJTOAGMs6M4RAxfpCBtb4dNdLNIheaFsQaQuMUj2wovagIEH16Aff4q0RQ2mir
         UUAA==
X-Gm-Message-State: AG10YOQEV74+T26LbLc+T2WzMazl4cSmFdvpwArj25apyGTIfEoIGPf+BOtPgXeB1bl7KJC5875+zAPvPpaTvw==
X-Received: by 10.31.141.2 with SMTP id p2mr31253481vkd.37.1456275353984; Tue,
 23 Feb 2016 16:55:53 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 23 Feb 2016 16:55:53 -0800 (PST)
In-Reply-To: <CAPig+cQ+MF7Nsvp7jASXPtPjNWT_g865ot45Y1Q347Y1iCDeYA@mail.gmail.com>
X-Google-Sender-Auth: NYXPtn-yGikZPms8gJaEQQyWrc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287151>

On Tue, Feb 23, 2016 at 7:50 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Tue, Feb 23, 2016 at 6:48 PM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> +       if [ 50 -le "$th0" ]; then
>> +               check_50=3Dcheck_threshold_0
>> +       elif [ 50 -le "$th1" ]; then
>> +               check_50=3Dcheck_threshold_1
>> +       elif [ 50 -le "$th2" ]; then
>> +               check_50=3Dcheck_threshold_2
>> +       fi &&

Oh, I totally forgot to mention a few style issues:

1. use 'test' rather than '['
2. place 'then' on its own line
3. drop semicolon

    if test 50 -le "$th0"
    then
        ...
    elif test ...
    then
        ...
