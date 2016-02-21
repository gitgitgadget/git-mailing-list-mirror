From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] merge-recursive: test rename threshold option
Date: Sun, 21 Feb 2016 15:45:32 -0500
Message-ID: <CAPig+cQ5h4hjOwO6-xXii6QQP0J8B_bHYUwWniR6HdQN2dB_1A@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-4-git-send-email-felipegassis@gmail.com>
	<CAPig+cTpngfi6EF+MbD-fQ1nM_9TTeVZJ_fBviD5=4Q9uN-8aA@mail.gmail.com>
	<CALMa68qhCBJ5MnT7i6UT989OKKzzOF_bTqo38thSPMwq0mbj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 21:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXass-00060l-Fo
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 21:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcBUUpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 15:45:35 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35496 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcBUUpd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 15:45:33 -0500
Received: by mail-vk0-f50.google.com with SMTP id e6so113777414vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xwJOzL5765cPXgMHRAP3nvdZdYRA1my1LBh1lERHxjM=;
        b=LFVEv5fXqVXwALb946s9Uy1JzqYFRfysPBBqf8iQUEQC2EykoZKYknGSXsUbnUsS6x
         qOkrDEvLmABC7hvPEZcGIwASTBBCuzbeRDq3PPN5voCOtFJCBKIkHPEbAh41khD9UZ0p
         C1jC12M7zHdL8y+/i+AlWhKJnknGF7Ep3mA+XlXIjI55g5iFvDMzLX7jpyuIDVjO9Aqt
         rMiLWNJauzK6sicoHqzMThgiPsFNjymJJdpqqKMl3hbsn/5dETxf60RRsuEA1/9ue9sp
         ZdJOWUGmVDCdaNF4uqBN1dvXwq/VLL/jVd1bP2ILEYgNA9t30cxiDc6JKeA9ZG/yqGRS
         Rwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xwJOzL5765cPXgMHRAP3nvdZdYRA1my1LBh1lERHxjM=;
        b=DLGELAsQiqaxmMw0ibPn94ixNkWooLWFbNBFpyXdlnb/WNeY1zIilA8/eoEC3+hN+C
         hO2P1YwxtWOjjDmBqhL3utxFA07parOhy9/llRLumQxRWVWJMTY8gr6irGS91Gu7YpI2
         4sHeQiUE3XeZEyoUzcMfOKsRct/mZ2y0w8iNnXtaAIRxmu+eIkcph7Wd5dR85SNDmb5v
         eQ5KE7O9wPyW9KO7jbdZtQqOaSyb8o3SdAvWelMNavUrFJYLJLjfM6su+YRr3GT79fFy
         xQ7WLCFuwtbcPvqB7uhidW9CfdL958cR9qR/EtFg46/H03Gs/KAUsdjLC2OZd27gqIkm
         Dcpw==
X-Gm-Message-State: AG10YORxg+EFw5wopW1g3Kz/ZBmgnzwBnpmlX5Qln9RCFgSnhKmiYqf66REt83F/L16glln6yQ4+WqnHZQjIUg==
X-Received: by 10.31.41.14 with SMTP id p14mr20433985vkp.151.1456087532667;
 Sun, 21 Feb 2016 12:45:32 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 12:45:32 -0800 (PST)
In-Reply-To: <CALMa68qhCBJ5MnT7i6UT989OKKzzOF_bTqo38thSPMwq0mbj6g@mail.gmail.com>
X-Google-Sender-Auth: FguleWFLYndPFCwfTG1-vbkq4jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286829>

On Sun, Feb 21, 2016 at 1:55 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> On 21 February 2016 at 14:52, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
>> On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
>> <felipeg.assis@gmail.com> wrote:
>>> +test_expect_success 'rename threshold is truncated' '
>>> +       git read-tree --reset -u HEAD &&
>>> +       test_must_fail git merge-recursive --rename-threshold=3D200=
% HEAD^ -- HEAD master &&
>>> +       check_find_renames_100
>>> +'
>>
>> Is this truncation documented behavior or is it just a detail of the
>> current implementation. (Genuine question; I haven't checked the
>> documentation or source.) If just an implementation detail, then it
>> might not be desirable to formalize it via a test.
>
> Not documented. I will remove this. If you prefer to have it
> documented and the test added back later, I can do that.

Looking at the code itself and its history, this seems to be a
deliberate decision, so the test may be appropriate, however, I defer
to Junio's judgment.

>>> +test_expect_success 'last wins in --rename-threshold=3D<m> --renam=
e-threshold=3D<n>' '
>>> +       git read-tree --reset -u HEAD &&
>>> +       test_must_fail git merge-recursive --rename-threshold=3D25 =
--rename-threshold=3D75 HEAD^ -- HEAD master &&
>>> +       check_find_renames_75
>>> +'
>>
>> Would it make sense to add tests checking that invalid
>> --rename-threshold=3D arguments, such as negative and non-numbers,
>> correctly error out?
>
> I guess so. Can I ask you for a suggestion on how to check this?
>
> Given that merges here usually fail anyway because of the conflicts,
> what is the best way of checking the effect of an argument rejection?
> 1. Check that the merge fails but the index is not changed
> 2. Check for a specific exit code
> 3. Use another setup so that the merges succeed

The last option would be most straightforward, however, looking at
diff.c:parse_rename_score(), I see that it never actually errors out
(by returning -1), so you may not (presently) be able to test these
cases. It seems (presently) that merge-recursive.c:parse_merge_opt()
can only catch a usage error if nothing follows the '=3D'.
