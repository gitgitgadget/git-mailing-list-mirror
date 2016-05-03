From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 12:12:38 +0530
Message-ID: <CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 08:42:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axU2k-0000f5-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 08:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbcECGmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 02:42:45 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35368 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbcECGmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 02:42:44 -0400
Received: by mail-yw0-f196.google.com with SMTP id v81so858057ywa.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tAIivjIQn1xyl9rg8zGArLJ4+Na6tgJa2WyqfNPpE28=;
        b=SVLQ8oUIOU+KzQcMyjPU3jQZaXlOhTzdv57FuvQFH9bL7cw0JUI8jUbPCxnBdVRDXO
         PixaTUMG77o8BrpbNLlUxDHFNHswWlorCHbvuWFFs2aHm2i+RFJubSuSo63LecMLQ4b/
         S+kk1uH88lWSgZ2rqEtuDuonfu7Ok16XswmN89cp6JoxBybX4eFRYNADlgbOlcb7opHd
         NyfnxQTX8MAQEPnJlVb5uLL2/jem3qR1Sq4+sVjKOwpvcUjX1YRFfyQt0y9+TkdJdKHj
         g0GHuX1+7slJWjclGE1VweEa3b04lmnijcg47NdPWeh9Z3evO6OgWP4SamrCnxr94Ay8
         Hy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tAIivjIQn1xyl9rg8zGArLJ4+Na6tgJa2WyqfNPpE28=;
        b=kt6JCr93GP2eKZB6gt7uFwi+tgEZy7YT93iqVMLpFWNFd+fIfyJIMQjAXEA7l7o9JQ
         ksUE7An8mHfaQ15jaUHTneAVSsc4Zwzqo58g6A53dLB8ZIaPBG+H7O4O8TqBMt6KBQ8a
         wjEOsHfGgRqdRrpAxE1ESofZFEhG/HKiCfvMfH5DkWFHFsR+Ml12RNaXDy/Nw4k5yh8P
         gCwvMnaN49fisIBG6UvVDzIHA1YP8FLSwfGUu8cZ//mNHI8N4Bkpd/IXzMXRet4QpFuq
         RMuu1YiEJvQlNH5aEwEbx1ekg+gv6QZ4rGCUfGEkvjJqHa7p/ThNwqKmPlXMCUTHbRlM
         4F7w==
X-Gm-Message-State: AOPr4FXVLtKpaCD8lEDltTch2efUHdkMszG3rW9X5FymD2XNX/XlyKhhn3QwsTfg3dktzTBS9vDUt+WMZesMgQ==
X-Received: by 10.129.41.8 with SMTP id p8mr280806ywp.154.1462257759007; Mon,
 02 May 2016 23:42:39 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 2 May 2016 23:42:38 -0700 (PDT)
In-Reply-To: <CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293329>

On Tue, May 3, 2016 at 10:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 2, 2016 at 11:39 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Tue, May 3, 2016 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>> Variable named 'verbose' in builtin/commit.c is consumed by git-status
>>>> and git-commit so if a new verbose related behavior is introduced in
>>>> git-commit, then it should not affect the behavior of git-status.
>>>>
>>>> One previous commit (title: commit: add a commit.verbose config
>>>> variable) introduced a new config variable named commit.verbose,
>>>> so care should be taken that it would not affect the behavior of
>>>> status.
>>>>
>>>> Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
>>>> respect "unspecified" values") changes the initial value of verbose
>>>> from 0 to -1. This can cause git-status to display a verbose output even
>>>> when it isn't supposed to.
>>>>
>>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>>
>>> If these are documenting what your previous patches broke, then
>>> there test body should describe what should happen, and then if it
>>> is broken, use test_expect_failure, no?
>>>
>>> Your first test does "run status with commit.verbose is set, and
>>> make sure the "diff --git" does not appear", which is correct, so if
>>> it does not work, test_expect_failure would be the right thing to
>>> use.
>>>
>>> These, especially the latter, look rather unpleasant regressions to
>>> me, and the main commit.verbose change would need to be held back
>>> before they are fixed.
>>
>> I agree that using test_expect_failure would be a better way of going
>> with this thing. Thanks. Will send an updated patch for this.
>
> Please don't. test_expect_failure() is not warranted.

I got confused between test_must_fail and test_expect_failure. I
thought Junio mentioned to use test_must_fail and remove the " ! "
sign.

> Step back a moment and recall why these tests were added. Earlier
> rounds of this series were buggy and caused regressions in git-status.
> As a consequence, reviewers suggested[1,2] that you improve test
> coverage to ensure that such breakage is caught early.
>
> The problems which caused the regressions were addressed in later
> versions of the series, thus using test_expect_success() is indeed
> correct, whereas test_expect_failure(), which illustrates broken
> behavior, would be the wrong choice.
>
> The point of these new tests is to prevent regressions caused by
> *subsequent* changes, which is why it was suggested that these tests
> be added early (as a "preparatory patch"[3]), not at the very end of
> the series as done here in v15.
>
> This patch's commit message is perhaps a bit too detailed about what
> could have gone wrong in earlier patches in this series; indeed, it
> misled Junio into thinking that patches in this series did break
> behavior, when in fact, it was instead previous rounds of this series
> which were buggy. If you instead make this a preparatory patch[3],
> then you can sell it more simply by explaining that git-commit and
> git-status share implementation (without necessarily going into detail
> about exactly what is shared), and that you're improving test coverage
> to ensure that changes specific to git-commit don't accidentally
> impact git-status, as well.

Sure! I just wanted the commit message to be detailed as per the
guidelines given by SubmittingPatches. I will swap the patch 6/7 and
patch 7/7 changing the commit message. Also I will make the commit
message less detailed.

>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/288634/focus=288648
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=289730
> [3]: http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=291468
