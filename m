From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: make "git -C '' <cmd>" not to barf
Date: Tue, 3 Mar 2015 10:00:13 -0800
Message-ID: <CAPc5daWFAV2P_MCCo=oz2Be=2_L5NVxNweY+rUbU5OcK84wVaQ@mail.gmail.com>
References: <1425397291-25435-1-git-send-email-karthik.188@gmail.com> <vpq385mgifi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSr7W-0003ZP-LY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 19:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbbCCSAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 13:00:34 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36266 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbbCCSAd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 13:00:33 -0500
Received: by obbnt9 with SMTP id nt9so1414851obb.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f8TUujyI+0sJC4a1J7V/hswMQOZO/h23zebu6QTE3Is=;
        b=hFf1ahSHbYSdoLtUNosZ3+AyU7eJLeS0WdbzX6IKXIa18i66WXKveVU1g6mKDw5MKX
         2BXmrc50NmMiau/r7yxiFuSxU1OdPoiGBlpEgSXTGlsElVuxLt5PFjk9ztvQxRRqjBcQ
         hcZlvqbAkYU8SKi51Q9sQN8o8GmExlEdoZopsDGxNpxAq3JzGyu5Hep8U7rQ/uU5PvQ1
         8j77Hv1BpJkW9y5sVlWEwvtDY9IKVF+MhRj2/UsqrtwLTkNkGzEFB+E1wK64jym6XWwP
         urlV/g502wzSR0BreiWl2Xzmwf4hxphPDebNGeM/6dHpNJ+3As0e0QRRZ3BfWTr7SsfF
         1TBA==
X-Received: by 10.182.205.133 with SMTP id lg5mr20544obc.61.1425405633178;
 Tue, 03 Mar 2015 10:00:33 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Tue, 3 Mar 2015 10:00:13 -0800 (PST)
In-Reply-To: <vpq385mgifi.fsf@anie.imag.fr>
X-Google-Sender-Auth: zsq8VPJnQc2rMU_c1ZnlOWveRz8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264673>

On Tue, Mar 3, 2015 at 8:22 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> now it works like cd "" which silently succeeds
>
> Missing "." at end of sentence.

And lack of capitalization at the beginning.

More importantly, lack of justification--why is it a good idea to make
"it works like cd ''" in the first place?

>
>>  git.c | 4 +++-
>
> That would probably also deserve a test.

Another "huh?" I had on the actual code was if this counts as "envchanged", if
you are not actually changing the directory at all.

Is this meant as a "micro" for GSoC, by the way?
