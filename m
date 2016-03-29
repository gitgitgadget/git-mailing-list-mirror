From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 14:04:38 -0400
Message-ID: <CAPig+cSUr1FK68qhHOf+M_tHqELW_ocJFU4-4kpjGVFV0R+F2g@mail.gmail.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
	<20160329105402.GB1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ray Zhang <zhanglei002@gmail.com>, Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:05:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aky0g-0001Tz-AC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbcC2SEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:04:41 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32849 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322AbcC2SEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:04:40 -0400
Received: by mail-vk0-f67.google.com with SMTP id a62so3351770vkh.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+x757InCG6j6vKyL1EmBsFIosg5OMjLmntZ+qTRJ/VM=;
        b=lpywDLYaarpcwYCWTQj2pZdi0OaoLmmCWKWAL6H5f4pGGk96vHAEdew+rjX+C5W1b4
         4q0IEr6uCWxnmieO2NOX/gsj6fWiffssYivpTyArSbLPqGBg1NlpUfa9WEaUlCOLYGVx
         XfVW2BuWZiQCw2EYqATC1TpoJTL9CfJAdq3kTpaQYickmfHCkVrkayA6fqUqeCa5hTdk
         peXNldfV7KaF//gIHgl/lMyNxyaZAKjoSmrgT+5FhnI1iYZK0VSYVzw6EK4BnWfW/579
         eI/TxBV/NQYaIR1WdV6hLanJ/NWfq3mO4VVMJirJ50+BuGKipEiWJgtw2+wL+Twgp3wY
         1VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+x757InCG6j6vKyL1EmBsFIosg5OMjLmntZ+qTRJ/VM=;
        b=d4ha53Wpg7R4vM4ZNgU6xv/Ognf6CKFzlmexTlW92ZPhabkq8Lfp3wSOERlUdVgJw0
         5Ryt4ufOM84FeELgI2qEb0Z3ynfaBXfGiZtyCJSPVgoJEfZB4Kd+kHsZGmUkOjcqL6Bp
         1T2dT6S6FWfDOMsxDQxjVA4VeuHx2iifuEneAJq4EJb2RugJq2Y1+0R/yQVfaj/JX3Zj
         B+DB2HWu5T8FEi71mMZtcI7ROIHq74FNIFnT32sO3VPhbi801SzLAUKhhCi12brls+Ws
         ulMTtiZuBjbCZX0SKeZk3V9nrqz/I2F/M1xsKRMg+f+YGUS2jfIMUYx35z4De74FVzXC
         1x7g==
X-Gm-Message-State: AD7BkJLYolXz7F+Lpzmjg2DSctH9c7KhCxMex29jEBdPNx/UbtP7i6I127zIDYB3QzLu7md3gcpKcnfjk9cm0Q==
X-Received: by 10.31.150.76 with SMTP id y73mr2279530vkd.84.1459274678913;
 Tue, 29 Mar 2016 11:04:38 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 11:04:38 -0700 (PDT)
In-Reply-To: <20160329105402.GB1578@serenity.lan>
X-Google-Sender-Auth: iOsGLOH9VNJvVIlWnGxM4RFkarE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290153>

On Tue, Mar 29, 2016 at 6:54 AM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Mar 29, 2016 at 10:11:01AM +0000, Ray Zhang wrote:
>>       With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
>>       in linkgit:git-checkout[1].
>>
>> +--[no-]checkout::
>
> This should be:
>
> --checkout::
> --no-checkout::
>
> (see for example --progress in Documentation/merge-options.txt).

[1] suggested either form without stating a preference since existing
Git documentation uses a mixture of the two. See, for instance,
git-format-patch.txt. However, I see now that --[no-]-option is the
minority.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289840
