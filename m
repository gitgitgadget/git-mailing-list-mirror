From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitremote-helpers(1): clarify refspec behaviour
Date: Wed, 17 Apr 2013 17:30:33 -0500
Message-ID: <CAMP44s38Cqcr4mwDBexW4tHzv3BKffCYEn5oN0U6Wji10nmJMw@mail.gmail.com>
References: <505914600ac7f4afc26f8b29fbece26156c87519.1365272021.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 00:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USasB-0002ZQ-L1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 00:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966930Ab3DQWaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 18:30:35 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:63618 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966919Ab3DQWae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 18:30:34 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so1974133lab.39
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=UY3M00EYV4JCg+hqrWONA8WwupYcJ9YsiH1v+uUaOy4=;
        b=qVy4HtLSxjkqvwFPluPosn1Wzj4JPmY52zexo9L3oGzRayNya8NN+xLa7a9Q9gthQJ
         YEhmsEAmq1xTSpqMJ1+56n/Lg+sf+5ANNs6sLlwihWEsKg4VXHhtupoa7koGQnn7gi0S
         Swy1n3EayPOTuocJb1F/8/2IOZJocieZmFQiKrmYsr+M+hFVFly0U963e0lJBD10U50/
         nWTlqvCnpO+hspW4ko5mPwf3EOiBgxJ8j9iKz/Frw7LMZPd2E8TSGPdiTEMl+1hQ6c8g
         olt4ZTbPRsIuAxUDP/i0Lc8bJ1fROaX6Oxx5lIyO/7JdoigSeTnBk9xuZvEqJg2jp5ql
         hmWQ==
X-Received: by 10.112.139.226 with SMTP id rb2mr3548373lbb.12.1366237833142;
 Wed, 17 Apr 2013 15:30:33 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 15:30:33 -0700 (PDT)
In-Reply-To: <505914600ac7f4afc26f8b29fbece26156c87519.1365272021.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221580>

On Sat, Apr 6, 2013 at 12:13 PM, John Keeping <john@keeping.me.uk> wrote:

> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -174,8 +174,8 @@ ref.
>  This capability can be advertised multiple times.  The first
>  applicable refspec takes precedence.  The left-hand of refspecs
>  advertised with this capability must cover all refs reported by
> -the list command.  If no 'refspec' capability is advertised,
> -there is an implied `refspec *:*`.
> +the list command.  If a helper does not need a specific 'refspec'
> +capability then it should advertise `refspec *:*`.

But if it advertises a straight 'refspec *:*', nothing would work. If
anything, it should be 'refs/heads/*:refs/remotes/$alias/*', but then
tags would fail. Why not just tell the remote helpers to do the right
thing and avoid this comment altogether?

-- 
Felipe Contreras
