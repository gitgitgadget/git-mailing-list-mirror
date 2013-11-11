From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] test-hg.sh: help user correlate verbose output with
 email test
Date: Mon, 11 Nov 2013 13:29:08 -0600
Message-ID: <CAMP44s00iTM00mU-+ESicBHeK=VH9MQTiZw6pFRXjTv2-xb_AQ@mail.gmail.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-7-git-send-email-rhansen@bbn.com>
	<5280c2c3e066c_6841541e7824@nysa.notmuch>
	<52812DD2.9030506@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfxAh-00027L-4T
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab3KKT3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:29:12 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44713 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab3KKT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:29:09 -0500
Received: by mail-lb0-f170.google.com with SMTP id z5so273859lbh.15
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6jbfG7VfIlodp7nCEsJ3869Sa/pYE35qw4C3iqXIAAk=;
        b=tpm62nOHoleWsL47326EMH2bNI4v228FA3z6AEmLQloElwofCZILVfyCTiBZQg2m+p
         7eMCS/UPvBFFy0XFv9rjwaz/BtywF/b+Zge5iQ7sbKpgRBmnBqD3C1tXvDtdTRWNPsbA
         s5ecoKS3uQkjoija+jjS+QiShDUDyPAxsDBUadU91LMo4IzuauzyLAxngBaTnpUiZf1D
         s7WIfOeC8HdzLu1jahLJErAEHwERfWU/KMep+Ja6nCAY+1CvEPhpC+XS6vIm/OsRPjBW
         ablHsB6DV8Aff1A3ZSdPQdSQWDQq5KkyIjS+TOYlKT3dcS3TWtNHs0ym2ZF5Jzt3fgWq
         dsWw==
X-Received: by 10.152.228.130 with SMTP id si2mr2942588lac.32.1384198148464;
 Mon, 11 Nov 2013 11:29:08 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 11:29:08 -0800 (PST)
In-Reply-To: <52812DD2.9030506@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237638>

On Mon, Nov 11, 2013 at 1:19 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-11-11 06:42, Felipe Contreras wrote:
>> Richard Hansen wrote:
>>> It's hard to tell which author conversion test failed when the email
>>> addresses look similar.
>>>
>>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>>> ---
>>>  contrib/remote-helpers/test-hg.sh | 20 ++++++++++----------
>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
>>> index 84c67ff..5eda265 100755
>>> --- a/contrib/remote-helpers/test-hg.sh
>>> +++ b/contrib/remote-helpers/test-hg.sh
>>> @@ -209,16 +209,16 @@ test_expect_success 'authors' '
>>>
>>>      >../expected &&
>>>      author_test alpha "" "H G Wells <wells@example.com>" &&
>>> -    author_test beta "test" "test <unknown>" &&
>>> -    author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
>
> Notice the two betas here in the original code.

Ahh, that's a bug.

>>> -    author_test gamma "<test@example.com>" "Unknown <test@example.com>" &&
>>> -    author_test delta "name<test@example.com>" "name <test@example.com>" &&
>>> -    author_test epsilon "name <test@example.com" "name <test@example.com>" &&
>>> -    author_test zeta " test " "test <unknown>" &&
>>> -    author_test eta "test < test@example.com >" "test <test@example.com>" &&
>>> -    author_test theta "test >test@example.com>" "test <test@example.com>" &&
>>> -    author_test iota "test < test <at> example <dot> com>" "test <unknown>" &&
>>> -    author_test kappa "test@example.com" "Unknown <test@example.com>"
>>> +    author_test beta "beta" "beta <unknown>" &&
>>> +    author_test beta "beta <test@example.com> (comment)" "beta <test@example.com>" &&
>>
>> Two betas?
>
> See above.  I can change them to beta1 and beta2, or if you'd prefer I
> can change them to beta and gamma and increment the subsequent entries.

Yeah, I would prefer that in two patches, one that fixes the sequence,
and the other one that changes the emails. If you don't have time for
that the original patch is OK by me. The problem with the sequence can
be fixed later.

Cheers.

-- 
Felipe Contreras
