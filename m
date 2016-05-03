From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 02:49:25 -0400
Message-ID: <CAPig+cQC0r6Lm9kOFQ2xukN-GiU0iTV5BNc7W8t4f0trkdtHsQ@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
	<CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 08:49:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axU9K-0003E4-6C
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 08:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbcECGt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 02:49:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36276 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbcECGt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 02:49:26 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so1195528iof.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LPvjTxIM5whuWBcJM/MpH5CQQLSl14hup93APj3Oebg=;
        b=eyMueoRy166LKwi/n7b5xMttrvEJDS+gfCHPwQ7dXiTdX/UCdSCmJFG2ZQaEe3g7tr
         Cgky/4IHoVGBb0++oCz6hnt9B4M/czpF47Xt9bNXGv+4ZGR/UwsKeRwbw05TlDWvITex
         7wt0ed7LBsOMY/U06wgU3EmdVpAP8q94omGllZdDAvJa/H8/fQoEm2W94dEgT6jOrpdd
         OcGqjl6TRrhIiMo0Q5aszqwanY31ZbPgOG/dsQf9EsxMBLgbsWDbxM3hUmiUWby1DcPW
         av/yuj0TVrFC/yrNZJh7Me7+xsNZgWsgmfKd9QgIz5kDFiEWHQOBdxl4IJCzr2fzMS9h
         k95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LPvjTxIM5whuWBcJM/MpH5CQQLSl14hup93APj3Oebg=;
        b=OJJOMVfUbe3wccJsyJ2arhZ+h+7nPxu5LhPhomRlFhraP1B3iP7IWGBnMOKdm4AL5n
         2XQZWmnMfbrgvCrbFea7IVQbjqSpeRfY70Br53jmVMVUn2fLSCVOla8lvJANBFrL25np
         IeURe6kQcOjS6leHELQk0KBoUycAK06igUgjuldxFuGwneUrL/HIZFhJQUA2o9dEO1t+
         RgBnU4VxIy+x4R1vzm4ZC4TQ2/lEUtjVGH7GZuXOWwf7vHWO61LSBSAU1hyojoOsCiSw
         iZCFKYHusZSH1FT5/AYhmjqOwBk3DeJZIoi37+7ozzGIOObGKwEbd510s1WwcVEO7oy5
         46tQ==
X-Gm-Message-State: AOPr4FW7gNduMfioNyoKDfFx51nU223CZmZvz881B3BpaCOOnD0kNEoovFQ2VF89XmB+OyW4HHotnjYWOiVg6g==
X-Received: by 10.107.47.37 with SMTP id j37mr1260098ioo.168.1462258165736;
 Mon, 02 May 2016 23:49:25 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 23:49:25 -0700 (PDT)
In-Reply-To: <CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
X-Google-Sender-Auth: 9-NaT_TeoVJsBJOkPi8tKSyqypw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293330>

On Tue, May 3, 2016 at 2:42 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Tue, May 3, 2016 at 10:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, May 2, 2016 at 11:39 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> I agree that using test_expect_failure would be a better way of going
>>> with this thing. Thanks. Will send an updated patch for this.
>>
>> Please don't. test_expect_failure() is not warranted.
>
> I got confused between test_must_fail and test_expect_failure. I
> thought Junio mentioned to use test_must_fail and remove the " ! "
> sign.
>
>> Step back a moment and recall why these tests were added. Earlier
>> rounds of this series were buggy and caused regressions in git-status.
>> As a consequence, reviewers suggested[1,2] that you improve test
>> coverage to ensure that such breakage is caught early.
>>
>> The problems which caused the regressions were addressed in later
>> versions of the series, thus using test_expect_success() is indeed
>> correct, whereas test_expect_failure(), which illustrates broken
>> behavior, would be the wrong choice.
>>
>> The point of these new tests is to prevent regressions caused by
>> *subsequent* changes, which is why it was suggested that these tests
>> be added early (as a "preparatory patch"[3]), not at the very end of
>> the series as done here in v15.
>>
>> This patch's commit message is perhaps a bit too detailed about what
>> could have gone wrong in earlier patches in this series; indeed, it
>> misled Junio into thinking that patches in this series did break
>> behavior, when in fact, it was instead previous rounds of this series
>> which were buggy. If you instead make this a preparatory patch[3],
>> then you can sell it more simply by explaining that git-commit and
>> git-status share implementation (without necessarily going into detail
>> about exactly what is shared), and that you're improving test coverage
>> to ensure that changes specific to git-commit don't accidentally
>> impact git-status, as well.
>
> Sure! I just wanted the commit message to be detailed as per the
> guidelines given by SubmittingPatches. I will swap the patch 6/7 and
> patch 7/7 changing the commit message. Also I will make the commit
> message less detailed.

This patch should be inserted before 4/7 since it needs to protect
against breakage which might occur when 4/7 changes the behavior of
OPTION_COUNTUP.
