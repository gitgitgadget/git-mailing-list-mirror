From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Tue, 7 Jan 2014 16:43:22 +0100
Message-ID: <CABPQNSaBbcgpE98j7mChvu6N7QqCG0CEmUgvJRURXLTdUTyFGg@mail.gmail.com>
References: <52C5A039.6030408@gmail.com> <alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
 <52C5ABDE.1010006@gmail.com> <alpine.DEB.1.00.1401022143310.1191@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 07 16:44:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Yp7-0001Tp-LK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 16:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbaAGPoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 10:44:06 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46724 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaAGPoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 10:44:04 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so544494ieb.29
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hPJ2MVxJ0SlyG6amf34UlDDkCJR8/V1+osj/StgCcU8=;
        b=FDAQwgVxY/R+MT2Kpmgo8AdcDuC3qCOMO506lt9n52tassU1s/3Q/IMpdSX6ac52sI
         X0+AIGTgG/Gobh2gMKoVR4qSbcEUeMHl7fQo/MYRkpj7wdQX4xwvutlV1dz1o60zLPF8
         pEepft65cBV19diNz3IhQ59b/eQXtkk11kH9pbc167iCgGnrkA4daGnLX96WIjP4qLZi
         PDexugG//VguPtjHa4F9AQkunRMubWyyf5DAmga/yHDulDfzHR8abLsx/pwUGL6FwTHl
         GZ6Jta3FkP5ZwzvSeUgVkKD2SeOtmLTVcRyv59cN+KHGMyaV/jYAzDi66OqsueaeZBT+
         yllg==
X-Received: by 10.43.82.69 with SMTP id ab5mr762417icc.95.1389109443123; Tue,
 07 Jan 2014 07:44:03 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Tue, 7 Jan 2014 07:43:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1401022143310.1191@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240107>

On Thu, Jan 2, 2014 at 9:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Sebastian,
>
> On Thu, 2 Jan 2014, Sebastian Schuberth wrote:
>
>> On 02.01.2014 18:33, Johannes Schindelin wrote:
>>
>> > -- snip --
>> > On Linux, we can get away with assuming that the directory separator is a
>> > forward slash, but that is wrong in general. For that purpose, the
>> > is_dir_sep() function was introduced a long time ago. By using it in
>> > safe_create_leading_directories(), we proof said function for use on
>> > platforms where the directory separator is different from Linux'.
>> > -- snap --
>>
>> While I'd be fine with this, I do not think we really need it.
>
> I also would have been fine with your commit message. But I knew Junio
> wouldn't be.
>
>> As you say, is_dir_sep() has been introduced a long time ago, so people
>> should be aware of it, and it should also be immediately clear from the
>> diff why using it is better than hard-coding '/'.
>>
>> That said, I see any further explanations on top of the commit message
>> title is an added bonus, and as "just" a bonus a link to a pull request
>> should be fine. You don't need to understand or appreciate the concept
>> of pull requests in order to follow the link and read the text in there.
>
> Well, you and I both know how easy GitHub's pull request made things for
> us as well as for contributors. I really cannot thank Erik enough for
> bullying me into using and accepting them.

Huh? I don't think you refer to me, because I really dislike them (and
I always have IIRC).
