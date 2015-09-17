From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/10] git submodule update: Redirect any output to stderr
Date: Thu, 17 Sep 2015 13:38:53 -0700
Message-ID: <CAGZ79kbwOZRnD99UBsKiWZF5xdV8Eg4Q1U81_=2GP6bPLHverQ@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-7-git-send-email-sbeller@google.com>
	<CAPig+cT=vTJvwRkqdHw6w04HYbZM7dsUvZ0pzy9Ppe_2n-2bbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:39:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcfxM-00064v-PS
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 22:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbbIQUi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 16:38:56 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34860 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIQUiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 16:38:55 -0400
Received: by ykdu9 with SMTP id u9so28663132ykd.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zlaRJ2LxAErEvrppDitnSuJklt6EPMD+B0laxIAi120=;
        b=Yepjh17U++rgRrSyPnz3/UlTTcxlhBa3yvCVvctN53qFeFomqRlixizM6ExjGeKMO0
         TIOhQcacrS1IGajmZFHRYkmt42rGU0H7Tkt6m6H/u9gEiHbZn3sIwdgtxb+tMc+M+YsL
         n31DV7KTN51VIAoYPwDFbqCFwquU964sd07MoNAI6ij5DfMAS1Vn7ckWWbB8C0Q6ju+v
         DoW20djK78Z/WzAvMHHIBpds52SDbvNGGOoH2ZD7v3jSloaCshoP7DzYTcmYtDuosJ5t
         0gwweD/FY+Odym7F6oPwpTwtURwcj4eaKmqW0igobUhC8BsJgGIzXy8f2zSz6xd4RrFs
         4TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zlaRJ2LxAErEvrppDitnSuJklt6EPMD+B0laxIAi120=;
        b=AGrH0ReLE73EfxMDme74azWMWIM7ypK+a5nrZUmIKI+seXBgLiiRbPSvvJgg17McXu
         uC3hN6fVs03TmM3k1B5drlkBMDQB8JLNJkSvb+uHQ6xrZKr7MEeNUunlwo8tQ68qfsG9
         4O2ZmteePeCYsiT76ur0qZZF+M+Y3kFftUJr5PkgJdklsOGdt5sluW7KfEvPqe1EX/T0
         M0AYGYQ9Jyakzw2jW1WD3VNpX1EnWscejVafe8nfy0zGdNelHYRzF+i3S7MCh+Ujzf/a
         tvBvBt5QENaDLpwk0VrHsoKGCNUlSD/19zlhH/M5vz1Q7Mafw3JUpgAbF74aRqHxw54Q
         qAEA==
X-Gm-Message-State: ALoCoQng5VN+ZAfBOSSvCWb+sejxuM/fLEZy2JYg2PGzz+RqyTslhMKW2/nn1smJXmMcEPD5DssI
X-Received: by 10.170.196.201 with SMTP id n192mr1361648yke.16.1442522333376;
 Thu, 17 Sep 2015 13:38:53 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 13:38:53 -0700 (PDT)
In-Reply-To: <CAPig+cT=vTJvwRkqdHw6w04HYbZM7dsUvZ0pzy9Ppe_2n-2bbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278167>

On Thu, Sep 17, 2015 at 1:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Sep 16, 2015 at 9:39 PM, Stefan Beller <sbeller@google.com> wrote:
>> git submodule update: Redirect any output to stderr
>
> This commit message seems to be lacking an explanation of why this is
> being done.
>
>> There are no tests, which fail by this.
>
> Not sure what this means. I suppose you're trying to say that this
> patch doesn't break any existing tests, but isn't that an implied goal
> of all patches posted to this list?

Yes they should (but they don't yet).

What I was trying to say:

In a reroll I want to add tests to this as I was surprised
of not breaking a test by this commit (so the behavior
of this is untested which is bad)

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 8b0eb9a..7ef3247 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -663,7 +663,7 @@ cmd_update()
>>                 die_if_unmatched "$mode"
>>                 if test "$stage" = U
>>                 then
>> -                       echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>> +                       say >&2 "Skipping unmerged submodule $prefix$sm_path"
>>                         continue
>>                 fi
>>                 name=$(git submodule--helper name "$sm_path") || exit
>> @@ -684,7 +684,7 @@ cmd_update()
>>
>>                 if test "$update_module" = "none"
>>                 then
>> -                       echo "Skipping submodule '$displaypath'"
>> +                       say >&2 "Skipping submodule '$displaypath'"
>
> These changes seem to be doing more than what the commit message
> claims. The changed code isn't just redirecting to stderr, but is also
> now respecting $GIT_QUIET.

Right, I need to redo the commit message anyways, so I'll mention that.

>
>>                         continue
>>                 fi
>>
>> --
>> 2.6.0.rc0.131.gf624c3d
