From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 01:12:32 -0400
Message-ID: <CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 07:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSdR-0001RH-MV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 07:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbcECFMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 01:12:34 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34554 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbcECFMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 01:12:33 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so1054948iof.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/BmSs5PreXG55PtrxICU0330RiZELQ3xVASR5n0/OlI=;
        b=TnfFPsT/wnbGYO+hN9JJQRpvUk+/dg9y17Ttfzort+hiAOnSoNP55iibZzQZ6tknkB
         LLHcyrdrXlvZTH6MIkiY21+oLKAxVDFMu8HqPA7nrxYaZiOUU3Agpn+oiwoVoi8MW6xl
         E7b7KGK5X9gIX7cS8OgTwIg0h7DlUmRnTV9d3x+zadl/D38HvktSPkqJ3npCSoFKFMA+
         0x4fwLarRfqz3GU6dkbzPgA8UwzH2tBlx7lnHs23sXIOIbUzMuKA3ZD5F8mYyPQz2bxx
         2+3s3gOpibwBXi7bfRHj967uzTNpLhtPRG9ajfUF/S1PbnH4jOx1eFqndc2Mp1P7Imfw
         SemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/BmSs5PreXG55PtrxICU0330RiZELQ3xVASR5n0/OlI=;
        b=NpDCp5KqfKC4aIRCsDgtBJ/IRKOhgh6/SNfYTcUhVIq6hS7RgjPztBQmTmW0GEwGIr
         CxHzl3+5NcXpwzDcQZfPekCOaVjkDzTqcnIUNJtUzoD4CGomViNGROfziqDnw+yJ+OYJ
         D2JEMi9/5e2eyMOaSJ9DXbeqpW970N+OzFQtyOlAm8eFU1I5PL0wynbG6qKFe/c8aJVP
         RnBGs942rV92rUJNMGW8f/dlUaVQ1hn2mFTSvX9HOEm2xCGRmNvbA0KBBi6tPTPFfZke
         g8QnG2ePl0bvlP1TlvSv6ixxqgZl9kO90CAp6oileSJ2X+uYXJauVaH4szjozMtBLCrp
         l0fg==
X-Gm-Message-State: AOPr4FV1qHz/zlNA0G25kd32vXGZ16wANLCqu/tb5Reqz4Qc0cupflPqF1v6nALuYRuxUXj+5TmIj3dem9ERlg==
X-Received: by 10.107.47.37 with SMTP id j37mr918718ioo.168.1462252352069;
 Mon, 02 May 2016 22:12:32 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 22:12:32 -0700 (PDT)
In-Reply-To: <CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
X-Google-Sender-Auth: ub5dDgarWDQ-SqptZqBjyATOmJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293327>

On Mon, May 2, 2016 at 11:39 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Tue, May 3, 2016 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>> Variable named 'verbose' in builtin/commit.c is consumed by git-status
>>> and git-commit so if a new verbose related behavior is introduced in
>>> git-commit, then it should not affect the behavior of git-status.
>>>
>>> One previous commit (title: commit: add a commit.verbose config
>>> variable) introduced a new config variable named commit.verbose,
>>> so care should be taken that it would not affect the behavior of
>>> status.
>>>
>>> Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
>>> respect "unspecified" values") changes the initial value of verbose
>>> from 0 to -1. This can cause git-status to display a verbose output even
>>> when it isn't supposed to.
>>>
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> If these are documenting what your previous patches broke, then
>> there test body should describe what should happen, and then if it
>> is broken, use test_expect_failure, no?
>>
>> Your first test does "run status with commit.verbose is set, and
>> make sure the "diff --git" does not appear", which is correct, so if
>> it does not work, test_expect_failure would be the right thing to
>> use.
>>
>> These, especially the latter, look rather unpleasant regressions to
>> me, and the main commit.verbose change would need to be held back
>> before they are fixed.
>
> I agree that using test_expect_failure would be a better way of going
> with this thing. Thanks. Will send an updated patch for this.

Please don't. test_expect_failure() is not warranted.

Step back a moment and recall why these tests were added. Earlier
rounds of this series were buggy and caused regressions in git-status.
As a consequence, reviewers suggested[1,2] that you improve test
coverage to ensure that such breakage is caught early.

The problems which caused the regressions were addressed in later
versions of the series, thus using test_expect_success() is indeed
correct, whereas test_expect_failure(), which illustrates broken
behavior, would be the wrong choice.

The point of these new tests is to prevent regressions caused by
*subsequent* changes, which is why it was suggested that these tests
be added early (as a "preparatory patch"[3]), not at the very end of
the series as done here in v15.

This patch's commit message is perhaps a bit too detailed about what
could have gone wrong in earlier patches in this series; indeed, it
misled Junio into thinking that patches in this series did break
behavior, when in fact, it was instead previous rounds of this series
which were buggy. If you instead make this a preparatory patch[3],
then you can sell it more simply by explaining that git-commit and
git-status share implementation (without necessarily going into detail
about exactly what is shared), and that you're improving test coverage
to ensure that changes specific to git-commit don't accidentally
impact git-status, as well.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/288634/focus=288648
[2]: http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=289730
[3]: http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=291468
