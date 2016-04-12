From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v13 2/6] test-parse-options: print quiet as integer
Date: Wed, 13 Apr 2016 03:46:28 +0530
Message-ID: <CAFZEwPPSY+k9qc8hZ685o9_U3UktbgK-e00zrG2+7GehG-47dQ@mail.gmail.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcbb-adadd774-db3a-43ce-b908-d08ac1312b31-000000@eu-west-1.amazonses.com>
	<xmqq60vmpl5c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq6bq-00019z-J9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbcDLWQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:16:30 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33094 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbcDLWQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:16:29 -0400
Received: by mail-yw0-f194.google.com with SMTP id o63so4227631ywe.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/66mmrVHZ8X7DJzTvcuW/D9OAlH9EcnaECih/4bkM88=;
        b=e9qPN/WSS8bLL/6DWQeviZfnLpQzKRirBWtzg9Br/LMA7u8YyfvBMWFskKc818jhBH
         bolx68r2gnRCc1pCgw7keJ7gxRPKWDFZBqnoFypaEz3djKI0Up9pxruvKB2au81Vkk9j
         +SewY2c0kf0agHF93++rFQZw+MCXupb1eGwuGMXTE1q8ljbS4coHLuLLFYRAAef0EaH7
         0O3PYJPcsNKIcr5d4i04xLK4nWuEyvO7JKzc+cDiAHLPLxffnZf/NI10kTk7xmG7JSTr
         t2Q4Mg6R/cqmbl4L2NhsGa2p8bm5p+MXRV1X5oJl31P2FTdij6LYLpR62L/srprth5SJ
         MnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/66mmrVHZ8X7DJzTvcuW/D9OAlH9EcnaECih/4bkM88=;
        b=kzrr5WwjEjvBChCMvq6dgWet0FEJl2oA+JLcly2M7gbUzfqMhGp/edJJnnmJe5qqqK
         TMei/4YKcYyrjr1A8hCpyoz0+RW66QvIacFuqxp3zm3nQP1bbR484rjVv8SN9UMLi/Wp
         CI59oZkdfChWYNPG9C+ixzNgNOJxQZfBw/Xi/IQXMcww2lorHRrq7lgsFebxNIiarJl1
         gITaLRASMVYVpuhwBZ1gQPUgDyynhOLc8hjNzLLkpMZ1bFN3kO4rKDmSlja+Qrp7tile
         wdI7MAE+bvUzpnFR16SqDqfgl7V3n1avgu8SNdX3HOz6ID/ACzJp+No4oh8m7yeO16xi
         AgsQ==
X-Gm-Message-State: AOPr4FU7ChfdHR0w2Bx2l5cFRRIteNhcL45/G+vAGVv3X/f4O+K/iyyWhReO0n/RxZ3mH4gyrKM5+/D8sMkQhw==
X-Received: by 10.37.207.141 with SMTP id f135mr3060650ybg.154.1460499388485;
 Tue, 12 Apr 2016 15:16:28 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 12 Apr 2016 15:16:28 -0700 (PDT)
In-Reply-To: <xmqq60vmpl5c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291301>

On Wed, Apr 13, 2016 at 3:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>> and not boolean and thus it is more appropriate to print it as integer
>> to avoid confusion.
>
> There is no "confusion" factor involved, as we do not use native
> "boolean" type in our C code.  IIUC, the reason why we want to do
> this is because we may want to see how it would affect the value of
> the underlying variable to give multiple --quiet options from the
> command line, which is a policy issue (i.e. we want to allow
> commands to react to multiple quiet options differently), not an
> implementation one (i.e. "current implementation happens to use
> integer").
>
>         We would want to see how multiple --quiet options affect the
>         value of the underlying variable (we may want "--quiet --quiet"
>         to still be 1, or we may want to see the value incremented
>         to 2).  Show the value as integer to allow us to inspect it.
>
> perhaps?

This commit message does look a lot better. I will re-roll this.
Should I just send an update of this patch or the whole series?
