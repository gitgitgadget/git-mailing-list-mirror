From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 16:28:47 +0100
Message-ID: <CAHGBnuNGTQvBStqK6-OERye4y2+yvRkK3g+rdSNPepSqy4kyRg@mail.gmail.com>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
	<56BB3157.7080307@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 16:28:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTWhJ-0000TG-1e
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 16:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbcBJP2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 10:28:49 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36430 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbcBJP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 10:28:48 -0500
Received: by mail-vk0-f67.google.com with SMTP id k196so1211379vka.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kkLqhH9zrWyTj5qgue/sOX0khYdED5uL9Z9AwC/AvmA=;
        b=WZM+FuOUsd1zDwgrXghm9BWXYyKB5wzvCxL7yfpeK+jmiSRRw3POn4XOY3JK02riY6
         CPBhYd0aVyriEAH9pSzv1qk1thPDEenjVZ8/lsHklOsr1P+j9L/sjVvhp24ytgDigjX9
         FUgZmZo007ni19np652T7uR3GOZZ69NNo9RhubGb1wj2VsaeRsaVLAzMblGXzdm1cqD8
         1pJmhfLYMnT2kiZ/ylM2nR+2hvgtm7hVLjAXJD30PVv/dEhimpDDQOsE5f4nFwgbJjUT
         4aniL0Ev60tVyic32d3SU2bORyMWooBSvx0KZn8d8o2gjwrs3RzbyXojjF6rAcoi+X+f
         ZycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kkLqhH9zrWyTj5qgue/sOX0khYdED5uL9Z9AwC/AvmA=;
        b=cYz6z5xt1kO+a3PweW3PNnxhL5XcG8UxJhIwNn545cnZL6qykJxM8gjAbW17osUB8O
         fcwj3ZX1XYSwhpefY1NlvsxFJHGoeR4BdtidR3Zi+jXgVLF2HVeTl9uT9T6gUdkrNz6U
         fXZHz71DPApAW3G6vCOzcdhUkWZm2KlDZu0vmOeUeaJCGDSxcXlol2k9Bby9eqxag/FU
         7SlxbBvpn1l2owtdC61tyT8HyAnZI+M+hO9hBQFWW+TI23P5iKLPgfrHx2exOKOP5Nel
         neZUqNEn6xglDC/fmw4bUAW8GYvpVSaud+xkSAKbVPlPEqn7hnu48C1vtbG0nO68JFZG
         UesA==
X-Gm-Message-State: AG10YOQiJQTZRfEpG1Rj//rK0S+SJnE6iN9uO+oQAe8kbze7xHjGSwAvwHwLA4wUM0b0X8CWHt5NsrHd7ulDQQ==
X-Received: by 10.31.49.138 with SMTP id x132mr30624252vkx.33.1455118127235;
 Wed, 10 Feb 2016 07:28:47 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Wed, 10 Feb 2016 07:28:47 -0800 (PST)
In-Reply-To: <56BB3157.7080307@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285902>

On Wed, Feb 10, 2016 at 1:47 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

>> Sebastian suggested "--show-origin" as a better option name over "--sources".
>> I still believe "--sources" might be slightly better as I fear that users could
>> somehow related "origin" to "remote" kind of configs. However, I am happy to
>> change that if a majority prefers "--show-origin".
>
> <bikeshed>
> As I have said before, I'm not very good at naming things, but ...
>
> Of the two, I *slightly* prefer --show-origin, since I don't think
> there will be any confusion. However, I think --source may be OK too
> (for some reason it sounds better than the plural). Another idea
> may be --show-source. ;-)
>
> </bikeshed>

I agree that using --source sounds better than --sources, as the
latter sounds even more like "source code".

Here's another idea: How about --declaration or --show-declaration?

-- 
Sebastian Schuberth
