From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] send-email: recognize absolute path on Windows
Date: Tue, 22 Apr 2014 14:15:59 +0200
Message-ID: <CABPQNSbcWjg3nLPD9U114zSk5rBNupOGLr901u4ptCkdiiKvCA@mail.gmail.com>
References: <1397635698-6252-1-git-send-email-kusmabite@gmail.com>
 <xmqqfvldi4ue.fsf@gitster.dls.corp.google.com> <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBKF33GNAKGQEIJPDIUY@googlegroups.com Tue Apr 22 14:16:43 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBKF33GNAKGQEIJPDIUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qg0-f55.google.com ([209.85.192.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBKF33GNAKGQEIJPDIUY@googlegroups.com>)
	id 1WcZcw-0001S6-0H
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 14:16:42 +0200
Received: by mail-qg0-f55.google.com with SMTP id j5sf431609qga.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 22 Apr 2014 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=/3mv77p0i0OvGN8tZauBc5vtTBEapmWNiD8K9adqixo=;
        b=UK83D5EpaaoNgj4UklMRojNuClSlLozhQH7h/+sBwV3m7FhKygxUB3GNKH+25I9ZFK
         YMD81IEhCWvOptE97ObiPEHIgRPVMDSGCxFYHE4pdsu01p9X+OuTvj0feDPa88GZ46Tu
         VAEapZb7flefIGoQHEXFB8rFS9uDM500VeqdlAqNDzbyzeGZNoRIP+7wYmoayDmk+Fli
         QyPBnf66TutiTKD+Ao4nOzdJDeAqmGiADw90NQnc8fks/O1Bk7tHcuDV6D4k8c9zv2gk
         z+4PsDkMxHy99lLDuuD2jw+5r4P4L/KGhhnSnbv3uPOjp01ain4Bwn3QHS4P9DQKaUeg
         i5Kg==
X-Received: by 10.140.102.150 with SMTP id w22mr43832qge.9.1398169001014;
        Tue, 22 Apr 2014 05:16:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.24.146 with SMTP id 18ls84084qgr.58.gmail; Tue, 22 Apr
 2014 05:16:40 -0700 (PDT)
X-Received: by 10.236.86.67 with SMTP id v43mr19975601yhe.41.1398169000524;
        Tue, 22 Apr 2014 05:16:40 -0700 (PDT)
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com [2607:f8b0:4001:c03::231])
        by gmr-mx.google.com with ESMTPS id rg8si859569igc.0.2014.04.22.05.16.40
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 05:16:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231 as permitted sender) client-ip=2607:f8b0:4001:c03::231;
Received: by mail-ie0-f177.google.com with SMTP id rl12so5126626iec.36
        for <msysgit@googlegroups.com>; Tue, 22 Apr 2014 05:16:40 -0700 (PDT)
X-Received: by 10.50.4.74 with SMTP id i10mr28872960igi.43.1398169000013; Tue,
 22 Apr 2014 05:16:40 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 22 Apr 2014 05:15:59 -0700 (PDT)
In-Reply-To: <xmqqbnw1i43p.fsf@gitster.dls.corp.google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246733>

On Wed, Apr 16, 2014 at 7:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> So let's manually check for these in that case, and fall back to
>>> the File::Spec-helper on other platforms (e.g Win32 with native
>>> Perl)
>>> ...
>>> +sub file_name_is_absolute {
>>> +    my ($path) = @_;
>>> +
>>> +    # msys does not grok DOS drive-prefixes
>>> +    if ($^O eq 'msys') {
>>> +            return ($path =~ m#^/# || $path =~ m#[a-zA-Z]\:#)
>>
>> Shouldn't the latter also be anchored at the beginning of the string
>> with a leading "^"?
>>
>>> +    }
>>> +
>>> +    require File::Spec::Functions;
>>> +    return File::Spec::Functions::file_name_is_absolute($path);
>>
>> We already "use File::Spec qw(something else)" at the beginning, no?
>> Why not throw file_name_is_absolute into that qw() instead?
>
> Ahh, OK, if you did so, you won't have any place to hook the "only
> on msys do this" trick into.
>
> It somehow feels somewhat confusing that we define a sub with the
> same name as the system one, while not overriding it entirely but
> delegate back to the system one.  I am debating myself if it is more
> obvious if it is done this way:
>
>         use File::Spec::Functions qw(file_name_is_absolute);
>         if ($^O eq 'msys') {
>                 sub file_name_is_absolute {
>                         return $_[0] =~ /^\// || $_[0] =~ /^[A-Z]:/i;
>                 }
>         }
>

In this case, we end up requiring that module even when we end up
using it, no? Not that I have very strong objections for doing just
that, after all, it appears to be built-in. (As you might understand
from this message, my perl-fu is really lacking :-P)

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
