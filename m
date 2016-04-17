From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sun, 17 Apr 2016 02:36:24 -0400
Message-ID: <CAPig+cTOa2yaMikOJHQXpSjY_EtyUXaqVz4KobQwO2xn=Q6h_w@mail.gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
	<1460823230-45692-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
	<20160417035414.GA30002@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 17 08:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1argJq-0002mb-1n
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 08:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcDQGg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 02:36:26 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33540 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcDQGgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 02:36:25 -0400
Received: by mail-ig0-f193.google.com with SMTP id g8so7465773igr.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=KXieTM5ASegvNaMqE5IfUfdUxgDN+gg84vb5MM6Q3aE=;
        b=ERY0h1L0ANmoeY05Ohgbcn16MlFNOXK4pyWAh6/lY9C1X/6ABLcPBfaaXjXbNOevKW
         qR7ZKU0kSnWfPc5FXVxExAOoQwVm2EiawSr3mPxYa0JB4QRvrb647eQuj73KtwRViX7n
         wau+xS7Y4DqVK7PpbEhPgyiTrf3Wj0FGIrNqSAC0QnHiX1ALPcIG6XJMC8i+0iCNo34F
         iydAitlkP2UF++SMYIIrozXmofOspIv1nVGu3GhRoL7+ozaB6s3xrqBObC33e1j9OW0u
         vYAK4sxmaG5EwJbeOQJ5ztbCbcJ8L3b3Kw6U+hjnSR8awFgI/5e1YpiEbIOL3m0dOhSR
         OHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KXieTM5ASegvNaMqE5IfUfdUxgDN+gg84vb5MM6Q3aE=;
        b=XvvhX4P8jdSBCrGp8pBOGKGi/suBJuW36ehf1xy2LCEmGNjazEPm7nVOO4Lv3eyXqD
         CU1EKKTxVPxjdKhV0OZ7kv3cyb64gjadn/TPgCL8IGss58wX/m59dgoCcUIXVb9luFqn
         HOxB2tCK+OqNBCSfdj3zBiHMKWnWOh2mQF3iWlgTEFrGj3UV/hyewSHm2KGYTkttG4t0
         4HM9E8K/o/wGT+uFlwMa8LdxwcmueqxLjOt0FKTSL8mFBLYHyjcHljy5xTpBlYvvZjiY
         ChkjB3ogoaiAZRbZMh7e7YEcXD8s4FrTK8B+erlPtFXHHUW50Zr86ellRhqly30aqCY7
         rlWg==
X-Gm-Message-State: AOPr4FWr5dMMhBkUVgttMoUtUn80kKnk3CLT0hsu5U4TWMOB/lsM4O0bERVmmjVTcb5XdUyHceMXx0vvKx8vFg==
X-Received: by 10.50.92.37 with SMTP id cj5mr13335553igb.91.1460874984796;
 Sat, 16 Apr 2016 23:36:24 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sat, 16 Apr 2016 23:36:24 -0700 (PDT)
In-Reply-To: <20160417035414.GA30002@sigill.intra.peff.net>
X-Google-Sender-Auth: Yff7S4BbbAjATECka8DCescp-PU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291747>

On Sat, Apr 16, 2016 at 11:54 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 16, 2016 at 11:07:02PM -0400, Eric Sunshine wrote:
>> > test_stdout accepts an expection and a command to execute.  It will execute
>> > the command and then compare the stdout from that command to an expectation.
>> > If the expectation is not met, a mock diff output is written to stderr.
>>
>> I wonder if this deserves more flexibility by accepting a comparison
>> operator, such as = and !=, similar to test_line_count()? Although, I
>> suppose such functionality could be added later if deemed useful.
>
> [...] Though I do actually find that:
>
>   test_stdout false git rev-parse --whatever
>
> isn't great, because there's no syntactic separator between the expected
> output and the actual command to run. So I dunno, maybe it would be
> better as:
>
>   test_stdout false = git rev-parse --whatever
>
> [...] We could also do:
>
>   test_stdout git rev-parse --whatever <<-\EOF
>   false
>   EOF
>
> which is more robust for multi-line output, but I think part of the
> point is to keep these as simple one-liners. You're not buying all that
> much over:
>
>   cat >expect <<-\EOF &&
>   false
>   EOF
>   git rev-parse --whatever >actual &&
>   test_cmp expect actual
>
> Though I do admit I've considered such a helper for some tests where
> that pattern is repeated ad nauseam.

Agreed. I wouldn't mind the version where test_stdout grabs "expected"
from <<EOF, but, as you say, it doesn't buy much over the manually
prepared test_cmp version.

I suppose that the one-liner form of test_stdout could have its uses,
however, it bothers me for a couple reasons: (1) it's not generally
useful like the version which grabs "expected" from <<EOF, (2) it
squats on a nice concise name which would better suit the <<EOF
version.

Anyhow, this may all be moot (for now) since I think this patch series
is going in the wrong direction entirely by abandoning the systematic
approach taken by the original t1500 code, as explained in my
review[1]. If modernization of t1500 retains a systematic approach,
then the repetitive code which prompted the suggestion of test_stdout
won't exist in the first place.

[1]: http://article.gmane.org/gmane.comp.version-control.git/291745
