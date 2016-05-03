From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/11] connect: change the --diag-url output to
 separate user and host
Date: Tue, 3 May 2016 13:23:37 -0400
Message-ID: <CAPig+cTYjY7=8YqGy_4dNKK7JWinShjTR-nEMY2V6gudzS2Bgw@mail.gmail.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462265452-32360-1-git-send-email-mh@glandium.org>
	<1462265452-32360-9-git-send-email-mh@glandium.org>
	<c1cc0220-d239-1589-9957-1ef8a6245d54@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 19:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axe2x-0007mq-4g
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933979AbcECRXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 13:23:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35865 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbcECRXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 13:23:38 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so2959622iof.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=/G3yy2//338NYDmQcFlz8r9gHirADy8X8nRchJbJLqg=;
        b=YB3Lov2ZDHtd9cYRXboKvzDkevhpwkcqd+MtxkR/++Q1TBk2rLSGt4aTM0itPOYeYq
         mEc8c2hu1pRALwE1gxyGx+PNo5/6n2UlhVHm/sLTBHgo62ysR9bqR4DXKlk383AbYpSc
         sGDxihDXAsZyetx2bTp6vMPPG1KkgHBLXF785tPPD4/qBy/qiAr9b8KEr5eVK3YdfW0W
         kXxN0TPmw7LN36JyM+Uh5hXBOALIL5xHRaWk8BcwFM2fWHN1NYJgcCEwnkZIGGEIeVvM
         s2xk8FgZ6x5znY4aTM592RgoJAf+6B5iy4dZeDaDdOO9DfOHFlvQP6IIQ1jaEZ/pE8TG
         lIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=/G3yy2//338NYDmQcFlz8r9gHirADy8X8nRchJbJLqg=;
        b=T2JzwYsAnPU+YwrESvLwm/V/7/2lxECC1iky1XDDJtZteco91zwRqOYYEfuidJMz8k
         SMy2q1Na7jCG7SwqmRNTkF4HUpKKPVkrwJtoDbBvYYJQPb1cqUySPVAHfa8B4pZmtIDX
         IXVto8wlXUhT2YUtBC5bOFlQDcZ1FFPfPR7Ov29/ZHmAypGB5/rtJqmbOMZQXLpP6Nv3
         WsB91k6/8MDtY8rnhZz8IK06pt+z4v1HqTgNKtSGRTG9gAO3e2ROVNtnRiWJuMizElC4
         vauiI1rywr1tUJve039vDMHnXt3MJ77iC6ekX6n2R3gBjrzQJPXHhpZxyaT9GyGfH1dJ
         PU0g==
X-Gm-Message-State: AOPr4FXq4YFqZcPoPoJK15koKTNl8JLTm5OiokBfBH9qjOa/BgMpliY46a36eGRZDgDdEfc76Y2VuX+6CwzLCg==
X-Received: by 10.107.25.13 with SMTP id 13mr3945738ioz.104.1462296217934;
 Tue, 03 May 2016 10:23:37 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 10:23:37 -0700 (PDT)
In-Reply-To: <c1cc0220-d239-1589-9957-1ef8a6245d54@web.de>
X-Google-Sender-Auth: zKYbi319T3Cu9A3XxcUNZxydr90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293420>

On Tue, May 3, 2016 at 12:20 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2016-05-03 10.50, Mike Hommey wrote:
>> -     git fetch-pack --diag-url "$1" | grep -v host=3D | grep -v por=
t=3D >actual &&
>> +     git fetch-pack --diag-url "$1" | grep -v user=3D | grep -v hos=
t=3D | grep -v port=3D >actual &&
> Running grep a couple of times is probably not optimal in terms of sp=
awning a
> process....
> Does
>
> git fetch-pack --diag-url "$1" | egrep -v "user=3D|host=3D|port=3D" >=
actual &&
> work ?
> or the version like this:
> git fetch-pack --diag-url "$1" | egrep -v "(user|host|port)=3D" >actu=
al &&

I always worry about portability problems with these "advanced"
expressions in grep and sed, however, both of these work fine under
Mac OS X and FreeBSD (which is where problems often manifest).

An alterante expression which shouldn't raise any portability alarms wo=
uld be:

    sed -e /user=3D/d -e /host=3D/d -e /port=3D/d
