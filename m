From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 3 Jul 2013 01:19:19 +0200
Message-ID: <CAETqRChiW49TwrZiZoi6vCwe9yOjurn97QpPEcJ2pb6fvp3ZBQ@mail.gmail.com>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<7vk3l8in2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 01:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9r2-0000MY-16
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab3GBXTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:19:20 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48360 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab3GBXTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:19:19 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so13763220iec.41
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UroieQRPDlYVlVRKHXUDqG2cW/UyVyZBSWpaVL0OtBk=;
        b=h2Z29FFp8PNG3xskBaASIr/Ea7A9SqeRLEUVbILdtYcF1FoVB8AEYhX4ypl+SLPM5M
         xuWuP4Uq/luVtD6ka9pWIfqxO6an+321S8hF1u2YS62b4X4/LBbtose7sJqY8ve+uM+Y
         eINemXZz0TCsDbEAIdPIBcaD2O1OgkXDd4j2kVVYqhB+V/EDhdSGcNXa6aO4DUgWH/+p
         Za8w/mw4f1oB/876RR5ipYgRgo+EPeXUAUoEmd9pCPKDVdWRoWAleqraOwifZKWo9n2o
         4oM1i+TVHbaubdUlmSJYaHrmaWfb+d72dGCoM1JcVyndFT4KWb1IxtBi5KeLhAsmrGCs
         C8Qg==
X-Received: by 10.50.153.109 with SMTP id vf13mr22571251igb.58.1372807159194;
 Tue, 02 Jul 2013 16:19:19 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Tue, 2 Jul 2013 16:19:19 -0700 (PDT)
In-Reply-To: <7vk3l8in2c.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: HysewXGbjc_kbz3N5SDSXUU9Ne4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229448>

> Do we want to add that ':' unconditionally?  Could GITPERLLIB be
> empty?

For now, GITPERLLIB is only used in that kind of statements:
use lib (split(/:/, $ENV{GITPERLLIB} || ... ));

The trailing ':' does not really matter, split will ignore it.

With the current codebase, I think it's nicer to do it that way (makes
wrap-for-bin.sh more readable).
