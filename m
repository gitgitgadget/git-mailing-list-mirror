From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 17:37:03 -0400
Message-ID: <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:37:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJ7z-0006QD-26
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935124AbcCPVhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:37:08 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35781 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934442AbcCPVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:37:05 -0400
Received: by mail-vk0-f50.google.com with SMTP id e6so79172284vkh.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=C80YJOTlnawt4Kqsm/QyAjR48+nrPXaxiDIfSqBBG0U=;
        b=UHlm8UMZ6qT8RFJLar6lD8Xz8fX1j7I77DyYmo3/lnQQe9zEen/4ROJZ45txv+zxfZ
         EK4yqg5QCeMKf+5fmJ5zGgsGqjugWAOhaWDmbqP0eSnWtqfmzjWhT4R/TphPjPoQX5xQ
         ql+SzX1CIu6fIqTV55JCQ55qjEq8jbZl7Dj+zh4/BF+opvIIna27ijc76UFrd9uzNnLQ
         mq1tdzLCQEiHFhFHncMOuSKOhPVLg5nJCoA7AKhWO3v3IWvB83M6NZbg9IHiebpRo+n0
         juCEDuYCqKL5TwRGx8c7M6Immfn0udCl5zIFN8bsj5ON6dBd93mGU51QEarmCpivcl7e
         SSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=C80YJOTlnawt4Kqsm/QyAjR48+nrPXaxiDIfSqBBG0U=;
        b=d70xuiL23JSB7NztTvOwJ8iOZ8OQiGGdxjMi9m0eeiiWnWJq+p9FvRlMtq7ASXC6Hq
         7fRc2AQMW1uuSY8AWaGyGerDAn1HkVqpjKWV4xqSggG1E1Q64ToqOADvFVI1JLJ8+FE/
         8BI3Tp73+oknCudhHVLUmARptu2oRHNPiWVDEsZnrVwLOl96PI0Y0+WBjDSQ6s3c2HOM
         y79KAv62ytfjx23pHG1ii1jJDhb+AJIghWT+vC1Urz7RQfi6s4YKxO2nOCntFpgsZVqq
         0cp9jaYzh8gPQD+SwE9o793T+kPg6NpiQPAle+gUmzSrORBTBXmFom6KBjRTfPxEXeLA
         LsHw==
X-Gm-Message-State: AD7BkJKKSY6G8f92tS9WkVVW+CHPA+sAAzXBpX09W45tUgDmvYIImq7nONgrc9ObJWpElLTfGGQkOq8vgqAxJQ==
X-Received: by 10.31.8.142 with SMTP id 136mr7816972vki.14.1458164223842; Wed,
 16 Mar 2016 14:37:03 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 16 Mar 2016 14:37:03 -0700 (PDT)
In-Reply-To: <20160316212308.GA4538@sigill.intra.peff.net>
X-Google-Sender-Auth: Wt7lXe1fwtG1iBXUebkjIzbAxxo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289044>

On Wed, Mar 16, 2016 at 5:23 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 17, 2016 at 02:36:51AM +0530, Pranit Bauva wrote:
>> I agree to you on the point that parse-options should not care about
>> the value passed to it. But I think plainly incrementing the value of
>> the variable is not a very nice way. I have an another approach to it.
>> The parse-options will first store a temporary structure. If there is
>> some changes (not the "--no-" ones) then it sets the respective
>> variable in temporary structure to the set value. If "--no-" is passed
>> then it writes the "reset" value to the respective variable in
>> temporary structure. If nothing about that options is specified then
>> it copies the respective variable from original to temporary. After
>> completing the entire process, it can copy temporary structure to the
>> original structure.
>>
>> What are your opinions about this?
>
> I don't think that would produce the wrong behavior, but it seems like a
> very complicated solution to a problem that can easily be solved by just
> following the usual conventions (that verbose starts at 0, options make
> it go up or down, and "--no-" resets it to zero).

I agree that this is overly complicated.

> Perhaps it would make more sense if I understood what your goal was in
> setting verbose to -1 in the first place.

The goal comes from his GSoC microproject. Specifically, Pranit wants
an "unspecified" value. The reason is that he is adding a
commit.verbose=<level> config variable to back the existing git-commit
--verbose option. Any use of --verbose (one or more times) or
--no-verbose should override the config.verbose value altogether, so
he wants a way to know if --verbose or --no-verbose was used; hence
the "unspecified" value. And, really, this issue isn't necessarily
specific to git-commit. It could apply to any command that understands
verbosity levels and wants to be able to get them from both a config
variable and a command-line option.

A much easier solution would be to update OPT_VERBOSE() to understand
that negative values are "unspecified", and then --verbose would
(pseudocode):

    if (value < 0)
        value = 0
    value++;

and --no-verbose would:

    value = 0

That should be compatible with existing clients of OPT__VERBOSE()
which initialize the value to 0, and should satisfy Pranit's case; he
can initialize it to -1, and if it is still -1 when option parsing is
done, then he knows that neither --verbose nor --no-verbose was seen.
