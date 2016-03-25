From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 18:29:43 -0400
Message-ID: <CAPig+cT=UZdueU+sRa1K637nb6FVYhR2z=-SrUsJKnoG+-+Odw@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
	<CA+DCAeRbD3S5Ltse3A6vBcvhKwh9t5av=Fnz98fD2ES5pbAN=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 23:29:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajaEs-0005lI-Hg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbcCYW3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:29:45 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33456 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbcCYW3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:29:44 -0400
Received: by mail-vk0-f68.google.com with SMTP id a62so8413534vkh.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=L4peN+364+4hiGtDCsE7Ok7V8Zd8ang3VtgIsa629p8=;
        b=oIkBMf/7jA7g7sPCbBEgpiS/M1jkTYBhvh11Q/ZsG6CL+wSeEbqgNzoNxWQKpPdl6x
         d7BaWKhnw5cx1w1m9YdUk6UnSWfdqUIT8vNUBxQFMdtVRTg+k5xp5p9IzYBpPHtf71Qp
         GJbiauTXZCIm4jKBN4G7zCNDMc8YPFvXFHBcVUhkgpfw7u8AdA62wcruiVVLlcQYV3uX
         WRSqW1oli8V3kcPGGdFKH0KKHon/fWrpl6xOnRSRj2HW0QQlMAvZiGvMhAUm1By7t3zC
         XxnW9/nV7dTZ3jEpldTpd6sRv2bLJaXsXqmMtx/5EWyuQhr74qPDCNzy5WCeBa3gvhoH
         mznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L4peN+364+4hiGtDCsE7Ok7V8Zd8ang3VtgIsa629p8=;
        b=aNeRDOEfs4IoRKKA9ztDu3KPEUwTqiGADwji0TyfWPED3FkPShdz21IadzVNb9WUkS
         uL3NOlmAfjGJDR40JhHtp5mffJ6MczrjPo3ZxQBVBSHIiBVB6WWjT6a+bd3JwWZnPHqe
         zWYWJJ48rWNgsBLdVig7jfnplBRjBakrr1WMDaLBAUORQm8kiLRUCHtgrYD/fwdP4WVR
         kXwGj27eFiLaWK3Yt6aYCXgwzsxpqD3GUCHsuG1qI9WsT6UTtj0Zj72VNyMuXrVPo36r
         0AZRKcxKiAV8E7wH9mvM0Gl+AkK3PWz01qoQ3MuWTxcz9DL6p9TkJUWCaFiCE6IG/Eu7
         I37Q==
X-Gm-Message-State: AD7BkJK6f7AJDVMgc3O0PTNDW70fEtVbXXrR1ydkc+hcmm1ileeiXyvG/ZGDNRtyVPDD651nVCIKACg7j+bEHw==
X-Received: by 10.159.37.101 with SMTP id 92mr8514744uaz.66.1458944983304;
 Fri, 25 Mar 2016 15:29:43 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 15:29:43 -0700 (PDT)
In-Reply-To: <CA+DCAeRbD3S5Ltse3A6vBcvhKwh9t5av=Fnz98fD2ES5pbAN=Q@mail.gmail.com>
X-Google-Sender-Auth: lCZWQaJTbWKOswgH6Q7X663lGho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289957>

On Fri, Mar 25, 2016 at 2:07 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 2:01 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Nit: Some of the test titles spell this as "rebase.autostash" while
>> others use "rebase.autoStash".
>> [...]
>> The title says that this is testing with rebase.autoStash unset,
>> however, the test itself doesn't take any action to ensure that it is
>> indeed unset. As with the two above tests which explicitly set
>> rebase.autoStash, this test should explicitly unset rebase.autoStash
>> to ensure consistent results even if some future change somehow
>> pollutes the configuration globally. Therefore:
>> [...]
>> With the addition of these three new tests, aside from the
>> introductory 'test_{un}config', this exact sequence of commands is now
>> repeated four times in the script. Such repetition suggests that the
>> common code should be moved to a function. For instance:
>
> I agree with all of these comments. I will introduce two new function to
> reduce the code and the above mention loop. Also the work on Matthieu's
> comment.
>
> I feel that most of your comments are necessary and should be there in
> the next patch. But I have a doubt regarding the next patch. As Junio has
> merged v10 of current series in next branch (as noticed from his mail),
> sending a new patch should be based on the current patch (i.e. on next
> branch) or master branch (i.e. continuing with this series)?

I hadn't noticed that v10 was already in 'next'. In this case, the
suggested changes should be a new patch series which makes incremental
changes to what is already in 'next'. Be sure to mention in the cover
letter that the new series should be applied atop
mj/pull-rebase-autostash.
