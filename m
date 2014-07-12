From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Sat, 12 Jul 2014 09:56:17 +0700
Message-ID: <CACsJy8BOdQwht_b2D48cZP-NFosT2FxGg+hkEthsGBvW7EE=FQ@mail.gmail.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>
 <xmqqa98i7aqt.fsf@gitster.dls.corp.google.com> <53C036CD.902@gmail.com>
 <xmqq4myn34xo.fsf@gitster.dls.corp.google.com> <53C076B8.9030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBB4GHQKPAKGQECW7BPMI@googlegroups.com Sat Jul 12 04:56:51 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBB4GHQKPAKGQECW7BPMI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f56.google.com ([209.85.219.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBB4GHQKPAKGQECW7BPMI@googlegroups.com>)
	id 1X5nUX-00085e-Ti
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 04:56:50 +0200
Received: by mail-oa0-f56.google.com with SMTP id l6sf429575oag.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 19:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=q7K6xSXI7dMXpAo1TGV897NvG3jH3btzm1sDWaplzeg=;
        b=ybzoDZ5t2g4t0SLrHYH5cBauVO+kccncG0DeyKfZzFtAxovpsgb6XcO3UUlWIdUJvL
         gaB5CTaLqISJXOVSk88ae8GOnnWOB+aluaC4g0eLrPmyxH+r1NxFdDj1Xm4mgM/49bx7
         ymgMysuJJ7TYcn6Zj0a+T9lHrZNQRw5TMJUF8jUrThY20grSHxsZ91BQ+CseFDpv1Mg4
         asL4EJfXjljM3K9++z1lt+zxxCM14ivVArg3wHX/hcr4v7W2CkRCkIR1PsL3xcr2UIYz
         CUrb0bxKaet2e47aGx08jRtI/rljPSBK0AIHi2+Wgkuv1g57mlBqfw8JATLKdMRovtE9
         CDnA==
X-Received: by 10.140.80.229 with SMTP id c92mr40720qgd.5.1405133809031;
        Fri, 11 Jul 2014 19:56:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.17.19 with SMTP id 19ls555091qgc.69.gmail; Fri, 11 Jul
 2014 19:56:48 -0700 (PDT)
X-Received: by 10.58.94.166 with SMTP id dd6mr1506062veb.12.1405133808496;
        Fri, 11 Jul 2014 19:56:48 -0700 (PDT)
Received: from mail-oa0-x234.google.com (mail-oa0-x234.google.com [2607:f8b0:4003:c02::234])
        by gmr-mx.google.com with ESMTPS id nv5si21640igb.3.2014.07.11.19.56.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 19:56:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4003:c02::234 as permitted sender) client-ip=2607:f8b0:4003:c02::234;
Received: by mail-oa0-f52.google.com with SMTP id o6so147677oag.39
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 19:56:48 -0700 (PDT)
X-Received: by 10.182.20.68 with SMTP id l4mr3287421obe.51.1405133808187; Fri,
 11 Jul 2014 19:56:48 -0700 (PDT)
Received: by 10.182.197.42 with HTTP; Fri, 11 Jul 2014 19:56:17 -0700 (PDT)
In-Reply-To: <53C076B8.9030209@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4003:c02::234
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253375>

On Sat, Jul 12, 2014 at 6:43 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 12.07.2014 00:29, schrieb Junio C Hamano:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> Anyways, I'd like to kindly withdraw this patch in favor of Duy's version.
>>>
>>> http://article.gmane.org/gmane.comp.version-control.git/248310
>>
>> Thanks; I've already reverted it from 'next'.
>>
>> Is Duy's patch still viable?
>>
>
> I think so. It fixes the segfault with long paths on Windows as well
> (Tested-by: <me>), uses strbuf APIs as Peff suggested, and initializes the
> strbuf with PATH_MAX (i.e. no reallocs in the common case either ;-) ).
>
> AFAICT the first two patches of that series are also completely unrelated
> to the untracked-cache, so we may want to fast-track these?
>
> [01/20] dir.c: coding style fix
> [02/20] dir.h: move struct exclude declaration to top level
> [03/20] prep_exclude: remove the artificial PATH_MAX limit
>
> ...perhaps with s/if (!dir->basebuf.alloc)/if (!dir->basebuf.buf)/
>
> @Duy any reason for not signing off that series?

That series still need a lot more work, but for those first three, if
you want to fast track, you have my sign-offs.
-- 
Duy

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
