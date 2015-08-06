From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] builtin/mv: remove get_pathspec()
Date: Thu, 6 Aug 2015 11:58:41 -0700
Message-ID: <CAGZ79kZ7oS+AQgq91WRaFTCKGUnZj-cZB1YPkjQo9KAueqEN3w@mail.gmail.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
	<1438885632-26470-1-git-send-email-sbeller@google.com>
	<1438885632-26470-2-git-send-email-sbeller@google.com>
	<CAPig+cRREzwRJV-az-p-r1E7JyDqDZ4GPvM1cQQzXXNyLjGPUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNQNM-0001rp-A3
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbbHFS6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:58:44 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35024 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbHFS6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:58:42 -0400
Received: by ykcq64 with SMTP id q64so65571543ykc.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mHt+hx9L4teyB9BQeqyrK5Yb8AX6FzcVsbgbP/JzRSs=;
        b=KbicQxm0kSgqbo4EYjnnFhds0DBt8OXODXF/xy0+OYM7orMYDnSOy+BRkcW7S9OxNB
         lKXRBDqtUHk0uY1/CwWlI6fzLWwXD6aK3pEEd13kv8IrfPjBpqNiIqhqdGaWJ29RT2zP
         RfSdTpXN2AraExqKH/hK+oV5B7ingb8yA+Y0oJZc26r11dvYtdlGYv3oaVAxv0t50W2h
         5uWvvdKyZNq87W0Qve+AIBWzFBU62EKTeoEVHeiE2CR7WNEjSD61puPaQVkhgoDorYv0
         xhYfcnvfk6d+ALqxZ49q8bcPq1xb5tyMpHZecSE1+S/+liwomhdQPFH2pREF2HwgytLe
         RlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mHt+hx9L4teyB9BQeqyrK5Yb8AX6FzcVsbgbP/JzRSs=;
        b=Vt6SO2OKtSNWpVr7OcAe3ezrjFgjwY6Iv3k3VixpSyhEJneDuGP+ZrBqxBeiVHS7QM
         8vJjvd4Lh/LwVmxrmSWczT5jXpVeAu/BJYsvN9efgv7Uj6v26zw6r2uuGMlMJzqGs/Pl
         jI7uYtSsM7KUbz0GLx8ULELDxgtainHsUxMG9zSFDWbftmcbkIAYdhE+qEoNIB8aRgUM
         NGb8fHoE4jAkt4IemRR8adUGpbet7cbFoa4L0RqkITDD1bBmyPbt2PWALC5r1ArvtmhG
         gLPtXY1eUHL9tEqSTGMqzAEdzLyVFIaPTrxwRw3v55xCqLwSfzQi5aO2bc0wiH3XpraI
         j5SQ==
X-Gm-Message-State: ALoCoQkqOxqG2lHOeO49Bh2fH9OfWB9HFR3RUusQMddB0LuhoHoFddWRkX+ROqJ6eA1dHcT//suI
X-Received: by 10.170.212.65 with SMTP id d62mr3691131ykf.115.1438887522023;
 Thu, 06 Aug 2015 11:58:42 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Thu, 6 Aug 2015 11:58:41 -0700 (PDT)
In-Reply-To: <CAPig+cRREzwRJV-az-p-r1E7JyDqDZ4GPvM1cQQzXXNyLjGPUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275438>

On Thu, Aug 6, 2015 at 11:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Aug 6, 2015 at 2:27 PM, Stefan Beller <sbeller@google.com> wrote:
>>  builtin/mv: remove get_pathspec()
>
> Misleading. Perhaps rephrase as:
>
>     mv: drop dependency upon deprecated get_pathspec
>
>> `get_pathspec` is deprecated and builtin/mv.c is its last caller, so
>> reimplement `get_pathspec` literally in builtin/mv.c
>
> Curious. Since this is just moving code around, rather than doing the
> actual work to complete the final step as stated by the NEEDSWORK
> comment, isn't it just moving the "problem" from one location to
> another? Is it worth the code churn?

Yeah it is moving around the problem a bit. And the code churn is
unfortunate. Though when I was reading the documentation on
pathspecs, literally the first sentence was "Do not use get_pathspec,
it is out dated". And that was a sad taste for reading documentation.

It's ok to have such warnings in the docs, but as the first sentence as if
there was nothing more important than avoiding the out dated stuff? I
mean I want to understand the actual code and how I can use it, right?

And there are different approaches to solving the problem.
I could have just reworded or even just rearranged the documentation.

The approach I take here includes a bit of code churn, but it moves the
problematic pieces all in one spot.

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index d1d4316..99e9b3c 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -10,6 +10,7 @@
>>  #include "string-list.h"
>>  #include "parse-options.h"
>>  #include "submodule.h"
>> +#include "pathspec.h"
>>
>>  static const char * const builtin_mv_usage[] = {
>>         N_("git mv [<options>] <source>... <destination>"),
>> @@ -20,13 +21,16 @@ static const char * const builtin_mv_usage[] = {
>>  #define KEEP_TRAILING_SLASH 2
>>
>>  static const char **internal_copy_pathspec(const char *prefix,
>> -                                          const char **pathspec,
>> +                                          const char **argv,
>
> What is this change about? It doesn't seem to be related to anything
> else in the patch or to its stated purpose, and makes the argument's
> purpose less clear, so it's not obvious why it is a good change.
>
>>                                            int count, unsigned flags)
>>  {
>>         int i;
>> +       struct pathspec ps;
>>         const char **result = xmalloc((count + 1) * sizeof(const char *));
>> -       memcpy(result, pathspec, count * sizeof(const char *));
>> +       memcpy(result, argv, count * sizeof(const char *));
>>         result[count] = NULL;
>> +
>> +       /* NEEDSWORK: Move these preprocessing steps into parse_pathspec */
>>         for (i = 0; i < count; i++) {
>>                 int length = strlen(result[i]);
>>                 int to_copy = length;
>> @@ -42,7 +46,13 @@ static const char **internal_copy_pathspec(const char *prefix,
>>                                 result[i] = it;
>>                 }
>>         }
>> -       return get_pathspec(prefix, result);
>> +
>> +       parse_pathspec(&ps,
>> +                      PATHSPEC_ALL_MAGIC &
>> +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
>> +                      PATHSPEC_PREFER_CWD,
>> +                      prefix, result);
>> +       return ps._raw;
>>  }
>>
>>  static const char *add_slash(const char *path)
>> --
>> 2.5.0.239.g9728e1d.dirty
