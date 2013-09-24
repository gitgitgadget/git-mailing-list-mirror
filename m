From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 00:32:46 -0500
Message-ID: <CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLEz-0003f2-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713Ab3IXFcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:32:50 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35967 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IXFct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:32:49 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3231905lab.33
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=An3z7b1Ad+1AhsFd24BCbq5wq/4FnnT64CL22oG68/A=;
        b=SbfIWgvIOnhkSJ6+phmxCthqxjGVkCwhGaH0zVOBOigkX1RXQm7pwJ7v2K81PiqOHl
         0dXam6WNXckarAwmBGwHZLGO631F1kj0unxHwgl7TcGtiAQ3V6Q/CodAqLIRwbvuQq1y
         n9NInA8CqXP1Ss9QnQf7NFVfpqVD7tXOeF48jTU6iHqbc47+GUKfdkG/PkXfbU4ru33G
         0xOe8jiU0x0SqEmHq26npbTQRomUQyEiuPohs0wMFXTj0UsdqETdEsdJXCR6W6VOnSG/
         tfzSgIZ+kit4lS/Ia/3tpFws3biVgn8H0xRnBnGYcQ+uo6fUqAWxPw4xJm1C5vLEDH98
         Ei8w==
X-Received: by 10.152.9.37 with SMTP id w5mr9925311laa.23.1380000766763; Mon,
 23 Sep 2013 22:32:46 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 22:32:46 -0700 (PDT)
In-Reply-To: <20130924045325.GD2766@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235264>

On Mon, Sep 23, 2013 at 11:53 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 21, 2013 at 02:20:21PM -0500, Felipe Contreras wrote:
>
>> For now simply add a few common aliases.
>>
>>   co = checkout
>>   ci = commit
>>   rb = rebase
>>   st = status
>
> Are these the best definitions of those shortcuts? It seems[1] that some
> people define "ci" as "commit -a", and some people define "st" as
> "status -s" or even "status -sb".
>
> You are making things more consistent for people who already define
> those aliases in the same way (they are available everywhere, even if
> they have not moved their config to a new installation), but less so for
> people who define them differently. Rather than get an obvious:
>
>   git: 'co' is not a git command. See 'git --help'.
>
> the result will be subtly different (especially so in the case of
> "commit" versus "commit -a").

Before:

# machine A: git ci
git: 'ca' is not a git command. See 'git --help'.

# machine B: git ci
commits

After:

# machine A: git ci
no changes added to commit (use "git add" and/or "git commit -a")

# machine B: git ci
commits

The "after" part is much more consistent, at least several commands
have a higher chance of doing what the user actually wants, at worst
they would do something close to what the user wants.

-- 
Felipe Contreras
