From: Manu <manu@blairos.org>
Subject: Re: fatal: unable to create '.git/index': File exists
Date: Fri, 5 Jan 2007 18:30:00 +0100
Message-ID: <f898cca90701050930l21338b88t1bd75e037beeca05@mail.gmail.com>
References: <200701051150.09968.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 18:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2stL-0005RD-SJ
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 18:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbXAERaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 12:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbXAERaE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 12:30:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:50828 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422637AbXAERaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 12:30:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7146605wxd
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 09:30:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=G1x+uYWKsRdUsZZZKnwpYRu/Iw01A5hdV4ejUHsfvzWGTgPvkd4wc3NFV9k+aVXQ3Xmvv/8QpcU46fP6OD4SpoBnoibqzP1ixyHOBLHA9ONYo2bAPvIdGc2t3ZQ8k3eGKbIvgc9pfrdufT1Zvs7n0bNHX6o59LC0dXCZ6xV5qaI=
Received: by 10.70.90.17 with SMTP id n17mr43646291wxb.1168018200271;
        Fri, 05 Jan 2007 09:30:00 -0800 (PST)
Received: by 10.70.36.15 with HTTP; Fri, 5 Jan 2007 09:30:00 -0800 (PST)
To: "Len Brown" <lenb@kernel.org>
In-Reply-To: <200701051150.09968.lenb@kernel.org>
Content-Disposition: inline
X-Google-Sender-Auth: 9a701360a7bee728
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36010>

Got this message once.
The reason was a git process still had a lock on the index file.
Make sure you have no git processes left running from the interruption
of git pull.

ps -ux | grep "git"

Manu

On 1/5/07, Len Brown <lenb@kernel.org> wrote:
> I kicked off a pull.
> Realized I was on the wrong branch
> and immediately did a ^C
>
> Now I can't change branches:
>
> # git checkout release
> fatal: unable to create '.git/index': File exists
> fatal: unable to create '.git/index': File exists
>
> git reset --hard
> does not help.
>
> curiously, moving .git/index to /tmp and repeating
> results in the same error.
>
> clues?
>
> thanks,
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
