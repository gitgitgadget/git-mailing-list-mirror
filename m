From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 11:20:45 -0700
Message-ID: <CAGZ79kaawUGOtxcFPEdx+tSn60Zzv=jLAMU-BnS6GGp_1wBWWg@mail.gmail.com>
References: <20160517032247.25092-1-sbeller@google.com> <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
 <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com> <xmqqinycwnx2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:20:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jbw-0005Wk-6a
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcEQSUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:20:48 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34669 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcEQSUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:20:47 -0400
Received: by mail-io0-f182.google.com with SMTP id 190so34508167iow.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wl6/HTYZbpKWr2Gu97bD1Me6EsoxiDKAVgd+s4f1SHM=;
        b=lNzqrhmSoxV9rQRpc0uCya6OmcjKyEmymINAns0FLOTk631AhrVxSVwhQtRRRQGkFL
         P2xVxEntdQiUSMY4si+rMuex1K0+Ty9zz1iBq+LuCLZVNgjvOkX90ZpKZy3Kur9Xs7hK
         //msc30Hswstl0YIC6ybkI7El4py186tuytt2rUgIgGqc/fvffkn1Bn1P2Iuf7sW9dgm
         N+EEbJFB3xmcKQeQ7q3//xCqbTnliczTwZ5h+5A6s78DmH1//jwtvXPCeUXjSBz8nu3W
         LYU8ERJxSIYDWJdfIVAX1yjULRW/gy/9IB1G15dM2U3s7uvxCvL7vJF/ulX9Yh6hox3C
         iHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wl6/HTYZbpKWr2Gu97bD1Me6EsoxiDKAVgd+s4f1SHM=;
        b=kVGXfMz0ZRtVmQSkSWa0A6ROeTHX6bBs87nsrwlTaRIYWpiz+91zGHoHlsU/1o4Pqv
         r/dd59ZevWq9kAxJ5atp7Ecj22XnquR7tNCy/3wrPBhu80YeMRiMhR7i/aLZ492QW6V9
         P7aWMruJjDMQ7YEK4AXyZLLsXaQ2EPW23f+xDRPY2ZUzSt+nrFp//wgrAeznUmqCFWtH
         rOKaqP6H6g8Vyv8ovA8z9x03bD/knrt5R/QTOjg/aieB33JHUwbmzg5ed2qQvDp4PDJG
         HTb9ppHwyzkGHFIINpq3f8/ELIF0kEoa6C/X8r76JkKutnngXVcj4PwalUSY8tx9MlH/
         Zw3g==
X-Gm-Message-State: AOPr4FU+6yKcdk5NZ6agzXsvPNCn+ns/UdTsu9XmEanfMYpF7RxuFvj0EDmkTSveWBudMsVfDwjWohY6y2HrKQWL
X-Received: by 10.36.107.129 with SMTP id v123mr14304453itc.52.1463509246291;
 Tue, 17 May 2016 11:20:46 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 17 May 2016 11:20:45 -0700 (PDT)
In-Reply-To: <xmqqinycwnx2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294891>

On Tue, May 17, 2016 at 11:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So as a developer I wish we would close all leaks that are non-concerning.
>
> Valgrind suppression (and if you use other tools, suppression for
> them) sounds like the way to go, I would think.
>
> Reducing false positive is a good goal; it helps to highlight the
> real problems.  But we need to find a way to do so without hurting
> the use by the end users by making them pay the unnecessary cost to
> free() at the end and by cluttering the code with #ifdefs that makes
> it easier to introduce subtle bugs.

That's why I think the `optional_free` is a good thing as it doesn't clutter
the code?

>
>> David writes:
>>> AFAIK, nothing in the "definitely lost" category is fixed by your rev-parse patch.
>>>
>>> I don't think we care that much about "still reachable" memory -- I only care about lost memory.  I could imagine, I guess, something that happens to save a pointer to a bunch of memory that should be freed, but I don't think that's the common case.
>>
>> As said above I'd want them to be fixed for me as a developer for
>> better automated tooling and detection. (The alternative to fix the automated
>> tooling is a no-no for me ;)
>
> Does the word "no-no" mean what you seem to think it means?  It
> sounds as if you are saying "fixing tools to reduce false positives
> is fundamentally wrong, I refuse to go in that direction".
>

I just mean, that I have not enough time to do that, so I won't.
I know however how to send patches to this list.
