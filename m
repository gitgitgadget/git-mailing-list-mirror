From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] t6030: explicitly test for bisection cleanup
Date: Sat, 28 May 2016 00:52:21 +0530
Message-ID: <CAFZEwPPMaCtG4VsJ31LKUP=mK_mqEekEPPrwDagyEUHHB0F2hQ@mail.gmail.com>
References: <1463134469-26071-1-git-send-email-pranit.bauva@gmail.com>
	<CAFZEwPMyts8msEgdHOiPfC-_HEXp8SJ7-8FQScr-af=5tSxq7w@mail.gmail.com>
	<CAP8UFD0NfUZa_SH7Q9WizV0=5DbjGq58sOU2COe5NSPSSn=+-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>, chriscool@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 21:22:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6NL1-00044N-55
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 21:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbcE0TWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 15:22:23 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33372 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbcE0TWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 15:22:22 -0400
Received: by mail-yw0-f180.google.com with SMTP id h19so114986328ywc.0
        for <git@vger.kernel.org>; Fri, 27 May 2016 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iuXFcjtBtVw2lPiS6eVcFGjIL0mYriMQxRsoZjTuCBg=;
        b=O7Alkr7QU5DwyhBZdxLtvbrI2mFoMIdTl5wPDGIuNztWsh0L1l9Kpxg05CtO3XZxmp
         OCsnvaH+569YKboataKBiR/pl7NnzDOCGj+302QX33xgxaoWDVtdRp7tur1zda+O0Ekj
         TiyLVDiJRLbdBPrVEWvSXNbH9hZGNQxpIuRpOGcKugMyt2yXr7Zf1ZONCbDE8XnhlrEJ
         8P32Df+xj9S2Al31nUmcdbkCgZdIMcUhbgtQ8LF1IITVPqSuz2cpp2SLojNEQMUbTo0I
         +fdabkrvlEe352OaKxGk1PPDHr+AXrANTFZCjZZmEVJEuZNg2HujsIRsbTYjwzoM1aZf
         RSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iuXFcjtBtVw2lPiS6eVcFGjIL0mYriMQxRsoZjTuCBg=;
        b=C8773KsO53XvercDKIMJ2x28XxdvtDbB57ZNgw4twJa1yQHh39VDqZjvlpHKSw3sb1
         iqfxZ3XfmIiaysegXjpqal6SiP70ycEM99xfEduON1KF1y1hGAM/gZ4UZEI8Fhkokm1E
         qpQA5HNKNFU34EOvlOL69OpgFMJHHFOjLjpQtqPkoAoTdRUwQfsOfqUB3HP979twCp0i
         f6RhZcclKG0bKazEo3DH6g4pMtYobCBGUut/cTqhP5UfDWP7yeiAE+mHsjyh53vHW5w9
         Zzm3UpTy5PRf7iIdZWeesQP0jl9s1sBIwND6uHXJyhxqd84s/BjP/UfRrFMI/Xaw83gx
         sTfQ==
X-Gm-Message-State: ALyK8tL1+ucLohuJTwFrPHIIsJbzrtsl3QT3/FXswPn9x1d9VA/OHlUlbG7AJt6ytQWQSBe+TWtNP82iZ5LJCQ==
X-Received: by 10.129.116.67 with SMTP id p64mr2629858ywc.68.1464376941923;
 Fri, 27 May 2016 12:22:21 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Fri, 27 May 2016 12:22:21 -0700 (PDT)
In-Reply-To: <CAP8UFD0NfUZa_SH7Q9WizV0=5DbjGq58sOU2COe5NSPSSn=+-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295787>

Hey Christian,

On Sat, May 28, 2016 at 12:30 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, May 27, 2016 at 7:57 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>
>> Anyone any comments?
>
> Maybe you could add this patch to, or squash it into, the patch that
> convert bisect_clean_state to C.

Sure!

Regards,
Pranit Bauva

> Thanks,
> Christian.
