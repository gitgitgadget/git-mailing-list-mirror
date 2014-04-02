From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 08/11] trailer: add tests for "git interpret-trailers"
Date: Wed, 2 Apr 2014 08:02:35 +0200
Message-ID: <CAP8UFD3dr=p-=zf5Dt4YZA0DEGaqMtFd3GuAzJnC1fPyvUn2Kw@mail.gmail.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.56221.chriscool@tuxfamily.org>
	<xmqqa9c4y823.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:15:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeIp-0006sp-8O
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbaDBGCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 02:02:38 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38075 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaDBGCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 02:02:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so8322876wgh.3
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H3oZKC3Iq49Qc5No+VD1gc0ZUwXevIrOiFkxCRTrVSQ=;
        b=0qsEm5E2SHTpEz27HDjU0z+7SKHJU5NdhFYZ4qCAbyxNgN7qpWc/ZBjVrOMomhUYfH
         ANfVQ4hvJiEIKIgVVpkyQtwCKgo73aAhsRQDc0FPeGhDcLoxHSqwQAS5Rx9b1IXRFf9k
         Uh0+TvP6D5RcucK+bUYeWusl+A3B7tsegoOLpH8a4rfXc/sD67Sy3NVh6NSsv9JtuSRy
         oayzsDfZd5wY3DaYptsrVo2lcVIFO22uEoWsNLFw7V2dSiTbIj1LdV/6wUFQF/dQ6Ed2
         fPjT6+CEY0Kx3KBAeJfVDaeb555yWnh7ZHSD5BmQE5V0LQ8wwEq8nFV33cvY/p1meiU3
         JDGA==
X-Received: by 10.180.100.169 with SMTP id ez9mr25737674wib.15.1396418556024;
 Tue, 01 Apr 2014 23:02:36 -0700 (PDT)
Received: by 10.216.174.68 with HTTP; Tue, 1 Apr 2014 23:02:35 -0700 (PDT)
In-Reply-To: <xmqqa9c4y823.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245710>

On Wed, Apr 2, 2014 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> +test_expect_success '--trim-empty without config' '
>> +     cat >expected <<-\EOF &&
>> +             ack: Peff
>> +             Acked-by: Johan
>> +     EOF
>> +     git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
>> +     test_cmp expected actual
>> +'
>
> Let's avoid these overlong and unreadable lines by doing something
> like this (just one hunk shown for illustration):
>
>                 ack: Peff
>                 Acked-by: Johan
>         EOF
> -       git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
> +       git interpret-trailers --trim-empty "ack = Peff" \
> +               "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
>         test_cmp expected actual
>  '

Ok.

> I've queued the series on 'pu' with the 'chop-overlong-lines' and
> another minor fix squashed in; hopefully we can merge to 'next'
> soonish.

Great!

Thanks,
Christian.
