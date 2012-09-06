From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 0/9] new git check-ignore sub-command
Date: Thu, 6 Sep 2012 18:44:34 +0100
Message-ID: <CAOkDyE-691hi8Qx8eOKyU8=fy=GqA+NXu-41gXAmX5NViG9mgQ@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<7v7gscgnnr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9g8B-0005Ew-1K
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759359Ab2IFRog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:44:36 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45243 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2IFRof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:44:35 -0400
Received: by bkwj10 with SMTP id j10so972669bkw.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cDYL1xGIVFRHobAV6JW0HJSRH3mdZttvOIYse666sMg=;
        b=Ux2sjZUHK2BsAIjf6onYc0qjd0pqhOvE5oxY2pG0hOWcbtSXtmtvuucLtIXdi1p4P0
         MneuY5W0uwOGPS9ZiFYuVAvBhZ+v5r92UwiYAAfimAboRFbaGap/pXWpAefASUzTnX5w
         FLgwF9prPJw6M/GWzDVZR3JpXZAKN91KPmjBoi0G34V/gMSi0kXApNrKPerG3PZKac2N
         Y8USR8wjwnuutDyexp14/DQqpLZSL62SkJ/SchDGhCbUsVp5Xg3DFWlC2TcUHXPqvN2f
         Hsuvl26WmFRCVltdAFmxWSrFtrNzqDROunhZrOESq3bSMztF5JTqyrCHccQghGTdfTUh
         oWzg==
Received: by 10.204.4.154 with SMTP id 26mr1537033bkr.91.1346953474173; Thu,
 06 Sep 2012 10:44:34 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 6 Sep 2012 10:44:34 -0700 (PDT)
In-Reply-To: <7v7gscgnnr.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: grl_SWAj02_CITS62Kbs2QZzSYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204909>

On Sun, Sep 2, 2012 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> I was browsing stackoverflow the other day and came across this question:
>>
>>     http://stackoverflow.com/questions/12144633/which-gitignore-rule-is-ignoring-my-file/
>>
>> A quick google revealed this thread from 2009:
>>
>>     http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108815
>>
>> where Junio and Jeff discussed the possibility of adding a new `git
>> check-ignore' subcommand somewhat analogous to the existing `git
>> check-attr', and suggested the beginnings of an implementation.  It
>> struck me that it might not be too hard to follow these ideas to their
>> natural conclusion, so I decided it would make a fun project :-)
>
> Thanks.  I wish there are more people like you ;-)

Thanks ;-)

> As to styles, I spotted only three kinds of "Huh?":
>
>  * do not initialise statics to 0 or NULL, e.g.
>
>     -static int exclude_args = 0;
>     +static int exclude_args;
>
>  * avoid unnnecessary braces {} around single statement blocks, e.g.
>
>     -if (exclude) {
>     +if (exclude)
>         return exclude;
>     -}
>
>  * else should follow close brace '}' of if clause, e.g.
>
>      if (...) {
>          ...
>     -}
>     -else {
>     +} else {
>          ...

OK thanks, I will fix these and also submit a patch for CodingGuidelines.
