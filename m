From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: Re: [PATCH] reset: allow "-" short hand for previous commit
Date: Wed, 4 Mar 2015 12:37:03 +0530
Message-ID: <CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
References: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
 <vpq4mq13f69.fsf@anie.imag.fr> <xmqq1tl5acwu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT3P6-0005R3-3f
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874AbbCDHH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:07:27 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:44969 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbbCDHHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:07:25 -0500
Received: by lams18 with SMTP id s18so42504503lam.11
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E9pTRyTR0YEPNsNRytNNJ/GxwyfzSVUxdoS9DZgFnYI=;
        b=MA3wuZJwMRm9wBLD2MlGAOYDJIweiY5ISVuecgaVatVYAmjZghAhLQYNd949M/Vb76
         8Aj/Pke38DQPsKogagvqyljUvr38yQGe8vdoufwv2zVM110sGFjrbfStvyBplq1VWJ0O
         wpz8hnvikQADfz7FRp4o42LN+dNXjiNmceg/pieEe6mqllp20VjUV24A9n/Yvg7B+deT
         MObadbsMfpqhrOaX1baOFIr1DFfDAQh+lQbloWCcZBfCJ/5h8K4FH06eiGxSihDyOmzc
         +skq/urhEYKOGgyNpQyWNVSxI4aeb7cFTsyJTdA/EME38ErGNijIaVppoD9UJnHo8S2F
         PJ/g==
X-Received: by 10.152.87.178 with SMTP id az18mr2154639lab.122.1425452843289;
 Tue, 03 Mar 2015 23:07:23 -0800 (PST)
Received: by 10.152.43.138 with HTTP; Tue, 3 Mar 2015 23:07:03 -0800 (PST)
In-Reply-To: <xmqq1tl5acwu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264723>

Hi,

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>>
>>> From: SudShekhar <sudshekhar02@gmail.com>
>>
>> Please, set your configuration to have the same identity for commit and
>> send-email. It seems your commiter ID (user.name) does not contain your
>> last name.
>
> Actually, the token does not match either of the two names; it looks
> like two names smashed together into a single nickname token.

Sorry, I had set my irc nick as the commiter id. I have changed this to my name.

>>> builtin/reset.c | 2 ++
>>
>> Doesn't this deserve a test?
>>
>> +             if(!strcmp(argv[0],"-"))
>> +                     argv[0]="@{-1}";
>>
>> Wrong spacing (around = and after ,).

Thanks for pointing this out. I have corrected it.

> What should worry us even more is what the user would get when @{-1}
> does not resolve to something the command can use.  It would be bad
> if we give an error message with @{-1} in it that the user never
> typed (and may not even understand what it means).


I apologize for having overlooked this use case. I have made some
changes and I think this should work now. I will email the updated
patch in the next email (I hope this is the correct procedure). Please
let me know your thoughts.
Also, this use case hasn't been handled in the case of git merge.

Another thing, can someone guide me regarding the right place to add a
test case? Should it be t7102-reset.sh or some other file?
