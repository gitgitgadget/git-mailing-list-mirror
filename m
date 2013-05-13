From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 01/10] Add support for -i/--interactive to git-clean
Date: Mon, 13 May 2013 22:46:00 +0800
Message-ID: <CANYiYbGX1w5YxxTJg4J0JrN1+3Kn-OK99ma+Qbi=VcRYR2o2TA@mail.gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<vpqvc6oi1f6.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 13 16:46:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubu0t-0002F1-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab3EMOqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:46:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57788 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab3EMOqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:46:01 -0400
Received: by mail-we0-f174.google.com with SMTP id x53so6304183wes.5
        for <git@vger.kernel.org>; Mon, 13 May 2013 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4tFg6N6hhTVom40XZqLIfYEbhODW9Payz9ymc3T4axo=;
        b=0L76elZaKwWYsK2hvJSEehO7a3R+Sp5ocPAuqBuRQvT4gXnY05bEEB2I2/nC9I5Orr
         G6uuT/9BOuDUhDC76duCmZEXZfkPeoMRCbttsAirr9IyhQgL5ZFd+2Bb8Eq52nOtovzB
         xTPkiePq4P5FVqn8/QTPyNDP4TjCYDkdrydkZJRt2bzAc+zXvTazdsiTNNXR19LTVt2O
         4rTlz1KTovaYpjwcNBNuQ1FLFVk1QGpvk046nY8qo6Uf8nlDW9cJkIGCtOGQTJcxRnZt
         rU6gylOaRugwIsOsEYxkrK0cJB1B8CfPh6BdYkohyq9CKqUEPoe0B3YQ2+qYb1IDdrtd
         d1ag==
X-Received: by 10.194.178.162 with SMTP id cz2mr40882080wjc.27.1368456360286;
 Mon, 13 May 2013 07:46:00 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Mon, 13 May 2013 07:46:00 -0700 (PDT)
In-Reply-To: <vpqvc6oi1f6.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224157>

2013/5/13 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> +             /* Confirmation dialog */
>> +             printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
>
> To be more consistent with "git add -p", this should use [] instead of
> (), and have no space before "?".

Will be replaced with:

             printf(_("Remove [y/n]? "));

>
>> +                     die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
>>                                 "refusing to clean"));
>
> That makes it a 85 characters message, and we usually break lines before
> 80. Adding \n after ";" (instead of a space) would be better IMO.
>

If die with multiple lines, it looks ugly. E.g.

    % git clean
    fatal: clean.requireForce defaults to true and neither -i, -n nor -f given;
    refusing to clean

I think because of this, some die messages are longer than 80 characters.
Such as:

    # builtin/apply.c:1496

    die(Q_("git diff header lacks filename information when removing "
                "%d leading pathname component (line %d)",
                "git diff header lacks filename information when removing "
                "%d leading pathname components (line %d)",

-- 
Jiang Xin
http://www.worldhello.net/
