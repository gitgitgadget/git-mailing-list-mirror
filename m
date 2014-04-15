From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] send-email: recognize absolute path on Windows
Date: Tue, 15 Apr 2014 22:28:39 +0200
Message-ID: <CABPQNSYzKB1QbXwqBNX+e1vc70rx4koqS6Q7+q2QXPmi5MjDXw@mail.gmail.com>
References: <1397551465-10968-1-git-send-email-kusmabite@gmail.com>
 <534D0ADB.7070702@viscovery.net> <CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDR53PPJ7YHRBIFNW2NAKGQEMDGBPUI@googlegroups.com Tue Apr 15 22:29:27 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBIFNW2NAKGQEMDGBPUI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIFNW2NAKGQEMDGBPUI@googlegroups.com>)
	id 1Wa9yr-0002j9-IP
	for gcvm-msysgit@m.gmane.org; Tue, 15 Apr 2014 22:29:21 +0200
Received: by mail-vc0-f190.google.com with SMTP id lc6sf2214452vcb.7
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Apr 2014 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=0hbmf8qkJQLpIVBM+38CayYcBaqnhU7CGZVwHLQXFRE=;
        b=w5AjxJaTUGS/YuLfoaNIyD8aui/5jO3uXCyw49bLE2kWq9ucKQ0lqxpXETWe1OoCTc
         IXW7tGaMx+LpxAfPqb/h8qT4CjT7atMKYt5uhZfQio210BTDIE9VScS8d8eT1Y0Re/qa
         tLlWvFmgnGFKAh74OOR+2M2Un4Ikwsrhye9Gv3MYccCLAKRTk4LIdTU+6izlwg9+Ltom
         LdxlGw0H+Ez3Hr65v0ImpVCvAqn2+dkpbbLAxbTHpXl4uBz2FioFQ68j/jqo1dD8TwvT
         ntp9okArxn1+PxSqZksK4AD4kRzjSW1Vww9y/Nnzk4AmV4/2U084hn9FuVgVcXUabXb7
         I91A==
X-Received: by 10.140.91.180 with SMTP id z49mr98007qgd.3.1397593760796;
        Tue, 15 Apr 2014 13:29:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.91.39 with SMTP id y36ls60072qgd.82.gmail; Tue, 15 Apr
 2014 13:29:20 -0700 (PDT)
X-Received: by 10.236.118.38 with SMTP id k26mr1769827yhh.35.1397593760331;
        Tue, 15 Apr 2014 13:29:20 -0700 (PDT)
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com [2607:f8b0:4001:c03::22b])
        by gmr-mx.google.com with ESMTPS id iq7si4398544igb.0.2014.04.15.13.29.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 13:29:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22b as permitted sender) client-ip=2607:f8b0:4001:c03::22b;
Received: by mail-ie0-f171.google.com with SMTP id ar20so9744455iec.30
        for <msysgit@googlegroups.com>; Tue, 15 Apr 2014 13:29:20 -0700 (PDT)
X-Received: by 10.50.254.36 with SMTP id af4mr336722igd.24.1397593760177; Tue,
 15 Apr 2014 13:29:20 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 15 Apr 2014 13:28:39 -0700 (PDT)
In-Reply-To: <CABPQNSafmC-7zNJZJSZm598pF37_xUMUopgZ3c=ttL_wRDYsfQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246297>

On Tue, Apr 15, 2014 at 12:42 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Apr 15, 2014 at 12:32 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 4/15/2014 10:44, schrieb Erik Faye-Lund:
>>> From: Erik Faye-Lund <kusmabite@googlemail.com>
>>>
>>> On Windows, absolute paths might start with a DOS drive prefix,
>>> which this check fails to recognize.
>>>
>>> Unfortunately, we cannot simply use the file_name_is_absolute
>>> helper in File::Spec::Functions, because Git for Windows has an
>>> MSYS-based Perl, where this helper doesn't grok DOS
>>> drive-prefixes.
>>>
>>> So let's manually check for these in that case, and fall back to
>>> the File::Spec-helper on other platforms (e.g Win32 with native
>>> Perl)
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>>
>>> Here's a patch that we've been running with a variation of in
>>> Git for Windows for a while. That version wasn't quite palatable,
>>> as it recognized DOS drive-prefixes on all platforms.
>>
>> Did you consider patching msysgit's lib/perl5/5.8.8/File/Spec.pm by
>> inserting a line "msys => 'Win32'," near the top of the file; it is the
>> hash table that decides which path "style" is selected depending on $^O.
>> Then File::Spec->file_name_is_absolute($path) could be used without a wrapper.
>
> I did not, but that works, and is IMO much nicer. Thanks for the idea!

Actually, after having tried that, other stuff starts to break... So
back to the drawing-board.

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
