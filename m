From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 03/11] tests: at-combinations: improve nonsense()
Date: Wed, 8 May 2013 01:49:54 -0500
Message-ID: <CAMP44s2S53kUvp3LcYcXdzq=bwP-kG0uZmG+s-u_6mEEjABEBA@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-4-git-send-email-felipe.contreras@gmail.com>
	<7v8v3qgglz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 08:50:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZyCO-0004dB-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 08:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab3EHGt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 02:49:56 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36414 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3EHGt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 02:49:56 -0400
Received: by mail-lb0-f177.google.com with SMTP id 13so1559131lba.8
        for <git@vger.kernel.org>; Tue, 07 May 2013 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=gfeGAC4DcANw3H/rq0QT/EeK0Vkk/VUzOg6aodZNuWQ=;
        b=T+sgnLWNb05CSrzKhm2Apr8R0vlojeQemEIZeejVbS3AYvJmhPNLRBtQ7Str7XajXv
         siblTw+NAIKdyxUlJuIojXDRuZXescdcr5spMx8zlIB7FoAqESrydOKY3E+lIylqRxYC
         z/Lp5sIQ++7gqDWBOUZ56aYvU9urZJ5fDJOciz8P+3Ayiquoa/jwVXOpVSjFQh6pTxMY
         xHVvu7SJAIfw1GmsUOoDihxRYSMR6ES55+Rgq8xKSvbVKj/tspQEbQdodLcQhzMB+Mu7
         g8/KQrYK58Fah80+uMpDiqKfEfsyUOcJc1JcBL7izWVjoeWQO/LlayN6QIdGNVSpZbSL
         hASw==
X-Received: by 10.152.22.168 with SMTP id e8mr2406355laf.20.1367995794516;
 Tue, 07 May 2013 23:49:54 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 23:49:54 -0700 (PDT)
In-Reply-To: <7v8v3qgglz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223644>

On Wed, May 8, 2013 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> In some circumstances 'git log' might fail, but not because the @
>> parsing failed. For example: 'git rev-parse' might succeed and return a
>> bad object, and then 'git log' would fail.
>>
>> The layer we want to test is revision parsing, so let's test that
>> directly.
>
> Hmph, but
>
>         git rev-parse Makefile
>
> would happily succeed if there happens to be Makefile in the
> directory.
>
> Are we expecting that they are always object names?  If that is the
> case, perhaps
>
>         git rev-parse --verify "$1"
>
> would express the intention better.

Probably, although the same would fail before this patch.

-- 
Felipe Contreras
