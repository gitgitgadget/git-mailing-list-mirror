From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/6] Miscellaneous merge fixes
Date: Fri, 15 Apr 2016 14:14:12 -0700
Message-ID: <CABPp-BEui_OVUES28TmUnWH3aGTJoMsgbAX2APVKNhx0eBAGJQ@mail.gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
	<xmqqd1pumhdr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arB4E-0005SC-1H
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcDOVON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:14:13 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34763 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcDOVON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:14:13 -0400
Received: by mail-ig0-f196.google.com with SMTP id qu10so4356237igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nwA/tdhHDh/Yxbi01qCxuvctSuZfasaJm96J3G7qs90=;
        b=zVXGajRkc/J0JYzGBp2sKXul56QgJNf6w4FHGXNCd4vNXprtjxWjvGFv0yus8nli/0
         A163c4m8HTxJQdA9Z6aRC5Ix1hqjTOcoEct0GGJuBB9SkmwFf9up3soou8HKqF0rHvRt
         WkuLT3gjkaghYm/bkaRcHnJL8qWcIGo1/jAubuErMWXlCq1yUJ1pr9kCOo1wOa9M1e79
         F5oBBLfwE5Sc3epWAOjHtkPVM2fcIVUXCOd0MzAqX7SAznOKA6OCqyWcLTujcQQeiUpx
         D6JZEqag64Quuz7GzZSWSQhP348SSqlzAEWRA6zio+h6TXymsG0OhfuNkzVlkYnsdzb1
         //nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nwA/tdhHDh/Yxbi01qCxuvctSuZfasaJm96J3G7qs90=;
        b=AB048U25LsJsyCJqvApmhAaXFLriulw8nCtHG3Xpvgnc0EKfMKgnP5kPSCMlss3x5b
         +1girTDi4zxGXFfrVBmk6dwEZw4ArIQEK8+bBtZLqsnIGhvdroMPrVzvRjFTsJO6e7PH
         1YQgc38ntnwSzSRL6tB4Cz6CiwHoYE3329lee1l94mlXT3An4/hlYXl3oP0VBEE5Zocn
         XsaRjzUthdHPwVbGzX9NFfVc5germj3qwSG+efAt+qquaf79wMAHhy4DgHE7heCzdtMO
         JnL2TQo1YojoQrRg2yvSrn+XOCMQq2UkSm+QZ8l2JLGSlxbBiKYDQyx9oypXiv0hYexC
         QjKw==
X-Gm-Message-State: AOPr4FXmHTw0p6rAumoi8y31waGcnUidESdYBsXkh8f0AiW3AkO/LiFaUigQOZ1bqCqtpzpgVVwKzcUvMue4fQ==
X-Received: by 10.50.29.114 with SMTP id j18mr7386444igh.62.1460754852057;
 Fri, 15 Apr 2016 14:14:12 -0700 (PDT)
Received: by 10.64.238.41 with HTTP; Fri, 15 Apr 2016 14:14:12 -0700 (PDT)
In-Reply-To: <xmqqd1pumhdr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291663>

Hi,

On Tue, Apr 12, 2016 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> Elijah Newren (6):
>>   Remove duplicate code
>>   Avoid checking working copy when creating a virtual merge base
>>   Add merge testcases for when index doesn't match HEAD
>>   merge-octopus: Abort if index does not match HEAD
>>   Add a testcase demonstrating a bug with trivial merges
>>   builtin/merge.c: Fix a bug with trivial merges
>
> Please be careful when giving titles to your patches.  They will be
> shown in a context that is much wider than the area your attention
> is currently concentrated on.  E.g. does "Remove duplicate code"
> tell readers of "git shortlog --no-merges v2.8.0..v2.9.0" what the
> change was about when it eventually appears in the upcoming release?

I will try to do better on that.  For the patch you mention, how about:
   merge-recursive: Remove a few lines of duplicate code
?

I can resubmit the series correcting both that subject and the subject
of the second patch using your suggestion elsewhere in this thread.
The other four already provide some context on their area; am I
correct to assume those provide enough?

Elijah
