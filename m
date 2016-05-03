From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 14:48:24 +0530
Message-ID: <CAFZEwPOYi0rv-WhVuV5ALwd=2_w2F2aeKN61EoZxswQQRGqcnA@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
	<CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
	<CAPig+cQC0r6Lm9kOFQ2xukN-GiU0iTV5BNc7W8t4f0trkdtHsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 11:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axWTU-0005qE-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 11:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbcECJS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 05:18:27 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34636 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbcECJSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 05:18:25 -0400
Received: by mail-yw0-f194.google.com with SMTP id i22so1119175ywc.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=I4UVacYwLv5xqoZ1ZjjTmGpOPA3KLvsPnFAbpZr99Tg=;
        b=K5AfHt6JwK88sEKoVh63J6IUOZwhLVSLvHNlz+ZeQXvqV0xW0RT76WWhyvNXsi+QbS
         doM48NNx71at1qw5ZDEaISrLoi93deJgRiW3RWgw7hpW4b6vKudp6iYUyjH4rfdlzq5F
         UDLF30+8P2sxoIKj/zkvdrd0i7aiKVYQgU23pCFwMOiX0BMzbeTF5+Oo6x6Eub71fGqF
         WYP0e3ZFmDhhtJN0MGK4V1bBquDvpWekNd8KvpNRJ0eKCMWJQW2WXxMd8llhSIt8QiY6
         2C5YcgPkEIPMWNoUlt7q2mq7CiGCRY4qdoYsG7Qb7eE4z1rigJEw0oY4AUyRsOQuGF1F
         7QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=I4UVacYwLv5xqoZ1ZjjTmGpOPA3KLvsPnFAbpZr99Tg=;
        b=k+urTPPHaoicbVtwtcr9Ld6tLv9nCblEaTbq52n6yRBkXbfgEGvtwhYraKSawopwVe
         D/Guxj1LdPRxg1WlLIUNSqGVWJBuik3Z3SYFO3YLUK6wgdSifq7OIWdB0QVML6HHUZAi
         yFr81CcRBk3mdvn/6bBZ+G7VH/808zf8Sq/TcwPHrL91ADjL5gfzsLigoiFwwzYUFDTy
         6kWzRuO6lq9Tl8l42H49mjx/56p05Kn1l79QCaSoMQxwA8FWBXp5RvgxQr28/M88Wfis
         oQkxa3aGA6UUsgE/zrVlI2k039+PbZeAZgTS8hL8QPy6NYJCz9Qyg3ea8dzHvW2AACN4
         er7A==
X-Gm-Message-State: AOPr4FWcydP1Yls7SF37dh3RV7IkxPRdkPl5nG5zB5xEtZSqviYHB32c3lkeaINPbOq9fh47qHw89QeWum5Agg==
X-Received: by 10.129.134.133 with SMTP id w127mr506547ywf.252.1462267104856;
 Tue, 03 May 2016 02:18:24 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 3 May 2016 02:18:24 -0700 (PDT)
In-Reply-To: <CAPig+cQC0r6Lm9kOFQ2xukN-GiU0iTV5BNc7W8t4f0trkdtHsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293347>

On Tue, May 3, 2016 at 12:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 3, 2016 at 2:42 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Tue, May 3, 2016 at 10:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Mon, May 2, 2016 at 11:39 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> I agree that using test_expect_failure would be a better way of going
>>>> with this thing. Thanks. Will send an updated patch for this.
>>>
>>> Please don't. test_expect_failure() is not warranted.
>>
>> I got confused between test_must_fail and test_expect_failure. I
>> thought Junio mentioned to use test_must_fail and remove the " ! "
>> sign.
>>
>>> Step back a moment and recall why these tests were added. Earlier
>>> rounds of this series were buggy and caused regressions in git-status.
>>> As a consequence, reviewers suggested[1,2] that you improve test
>>> coverage to ensure that such breakage is caught early.
>>>
>>> The problems which caused the regressions were addressed in later
>>> versions of the series, thus using test_expect_success() is indeed
>>> correct, whereas test_expect_failure(), which illustrates broken
>>> behavior, would be the wrong choice.
>>>
>>> The point of these new tests is to prevent regressions caused by
>>> *subsequent* changes, which is why it was suggested that these tests
>>> be added early (as a "preparatory patch"[3]), not at the very end of
>>> the series as done here in v15.
>>>
>>> This patch's commit message is perhaps a bit too detailed about what
>>> could have gone wrong in earlier patches in this series; indeed, it
>>> misled Junio into thinking that patches in this series did break
>>> behavior, when in fact, it was instead previous rounds of this series
>>> which were buggy. If you instead make this a preparatory patch[3],
>>> then you can sell it more simply by explaining that git-commit and
>>> git-status share implementation (without necessarily going into detail
>>> about exactly what is shared), and that you're improving test coverage
>>> to ensure that changes specific to git-commit don't accidentally
>>> impact git-status, as well.
>>
>> Sure! I just wanted the commit message to be detailed as per the
>> guidelines given by SubmittingPatches. I will swap the patch 6/7 and
>> patch 7/7 changing the commit message. Also I will make the commit
>> message less detailed.
>
> This patch should be inserted before 4/7 since it needs to protect
> against breakage which might occur when 4/7 changes the behavior of
> OPTION_COUNTUP.

I forgot to mention about this earlier. When I was rebasing, this stroked me.
I guess making any changes in ordering the commits will make one of
the test as absurd. One of the test uses a configuration variable
'commit.verbose' will won't be effective before the patch 6/7. So I
guess I will have to only change the commit message to reflect as
"improving test coverage".
