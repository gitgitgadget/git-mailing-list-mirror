From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] send-email: recognize absolute path on Windows
Date: Wed, 23 Apr 2014 11:30:36 +0200
Message-ID: <CABPQNSZ_d0KwEo-P5_Hx5QdV-tzYKMfZQA9SzEj3PD-wed6_bA@mail.gmail.com>
References: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
 <xmqqfvldi4ue.fsf@gitster.dls.corp.google.com> <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
 <CABPQNSbcWjg3nLPD9U114zSk5rBNupOGLr901u4ptCkdiiKvCA@mail.gmail.com> <xmqqk3ah71g8.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBZMQ32NAKGQEGIHJSOQ@googlegroups.com Wed Apr 23 11:31:21 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBZMQ32NAKGQEGIHJSOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f191.google.com ([209.85.214.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBZMQ32NAKGQEGIHJSOQ@googlegroups.com>)
	id 1WctWQ-0003q7-QR
	for gcvm-msysgit@m.gmane.org; Wed, 23 Apr 2014 11:31:19 +0200
Received: by mail-ob0-f191.google.com with SMTP id vb8sf155594obc.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Apr 2014 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=L85Qt/zGJiZCQwjokEhF/aMlGxcCNjlvGlzfQIEtVhg=;
        b=KQl8CcdnUvuAJg8Dj5Gq9CVZ6kuTYU8ItpmK/VUL+D+Gwi/H9VtQET28Iz3ft9TFjY
         UiBC9UUCZ1VVBaE/IXfUZnOmSCgNZSjK+Y/ao1gZtfQYuKv2bNZ4/6Xd8qRLRHrFhP5c
         IWsILvlTZvShRR5UoGYITKw+UcYMUQITV7mnbkjnZZ1kfVmIzy86E7ISYhYr7KRO/cuc
         vGnd5gV5jfpWQMyFfyZgB+hAXqMhcBLxnEapD6BmppgNVZhTnu6mx7wblnqtKoR3QaiB
         I5D8eTBUAPiqaOeL/ucTV9zyKrGe7p2osaUiVLctLYnCKlIT0RbT+zKetE1ZWGkGRFJz
         J/uQ==
X-Received: by 10.140.107.35 with SMTP id g32mr377072qgf.2.1398245477803;
        Wed, 23 Apr 2014 02:31:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.89.70 with SMTP id u64ls543619qgd.80.gmail; Wed, 23 Apr
 2014 02:31:17 -0700 (PDT)
X-Received: by 10.52.2.129 with SMTP id 1mr19938991vdu.4.1398245477186;
        Wed, 23 Apr 2014 02:31:17 -0700 (PDT)
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com [2607:f8b0:4001:c05::234])
        by gmr-mx.google.com with ESMTPS id rg8si435650igc.0.2014.04.23.02.31.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Apr 2014 02:31:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::234 as permitted sender) client-ip=2607:f8b0:4001:c05::234;
Received: by mail-ig0-f180.google.com with SMTP id c1so765338igq.13
        for <msysgit@googlegroups.com>; Wed, 23 Apr 2014 02:31:17 -0700 (PDT)
X-Received: by 10.50.85.18 with SMTP id d18mr1165649igz.42.1398245477058; Wed,
 23 Apr 2014 02:31:17 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 23 Apr 2014 02:30:36 -0700 (PDT)
In-Reply-To: <xmqqk3ah71g8.fsf@gitster.dls.corp.google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246818>

On Tue, Apr 22, 2014 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>>> Shouldn't the latter also be anchored at the beginning of the string
>>>> with a leading "^"?
>>>>
>>>>> +    }
>>>>> +
>>>>> +    require File::Spec::Functions;
>>>>> +    return File::Spec::Functions::file_name_is_absolute($path);
>>>>
>>>> We already "use File::Spec qw(something else)" at the beginning, no?
>>>> Why not throw file_name_is_absolute into that qw() instead?
>>>
>>> Ahh, OK, if you did so, you won't have any place to hook the "only
>>> on msys do this" trick into.
>>>
>>> It somehow feels somewhat confusing that we define a sub with the
>>> same name as the system one, while not overriding it entirely but
>>> delegate back to the system one.  I am debating myself if it is more
>>> obvious if it is done this way:
>>>
>>>         use File::Spec::Functions qw(file_name_is_absolute);
>>>         if ($^O eq 'msys') {
>>>                 sub file_name_is_absolute {
>>>                         return $_[0] =~ /^\// || $_[0] =~ /^[A-Z]:/i;
>>>                 }
>>>         }
>>>
>>
>> In this case, we end up requiring that module even when we end up
>> using it, no?
>
> Also somebody earlier mentioned that we would be redefining, which
> has a different kind of ugliness, so I'd agree with the code structure
> of what you sent out (which has been queued on 'pu').
>
> My earlier question "don't we want to make sure 'C:' is at the
> betginning of the string?" still stands, though.  I do not think I
> futzed with your regexp in the version I queued on 'pu'.

Ah, yes of course. Thanks for spotting that. I also like the other
clean-ups you did to the regex (above).

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
