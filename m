From: Stefan Beller <sbeller@google.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 14:53:17 -0700
Message-ID: <CAGZ79kbbAv=PukD+sftmoO8u3GX=S1YCYGV8zcNMxrZ+E41-UA@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
	<CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
	<20160316214442.GC4441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:53:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJNb-0001ri-C6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbcCPVxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:53:19 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37474 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcCPVxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:53:18 -0400
Received: by mail-ig0-f181.google.com with SMTP id mh10so55528079igb.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jFBmHg/vjdk4XQ8hL53tKv66lKlxP4j1g5aJRch8qPU=;
        b=pCGGEu5LiDw/10r/Oe0ghkPTEOdjuZpz26gIwHCpqWhC1G3U74nk4qZI5Ji/ZA9Flo
         iylumfQBdINrdmGA4/5QDLvsvusiKw0LFqtWfcQGkuph+r87rseiLid6WwVGVFvua4sG
         1dNRBJVwa+MsGgZoLHXyJz4dSfXtYy4iMnDjbgTpCO/MAPfqSVb2WjhF7SyALhaq8Fmr
         6mwiBguVlg5jBZDfeliAMeBUgwb0Q55N0+gTGzCH6+CrA9sx4+RTW7vVO1XIFOeRZBec
         qsyUYu3saMgsD8y62XLIyGinRVuJX7qnWCZ0Tr5R5EyoHkL0gCoTCDekYjSRr3iCPW+3
         veuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jFBmHg/vjdk4XQ8hL53tKv66lKlxP4j1g5aJRch8qPU=;
        b=GZVxF3BryjbxQ1B9rl15Br3AXOtwh07CVeUYTNDcMQq7g5WiNAjsUyzHQzRzG+03jr
         GnHBeQKuq2MFBwQowqoAZbQWEBBzW215hQIq7cI09CQvymbAwaJqU+bLyBwheORoARr3
         zK/Inl5nQsvNK/AuwCQJoVbD5cqhTMgPn50NHf+PHUGtWcKZz9l81qrawQ6DFXmk4toT
         q/GFbxzoaMnnaxtTIw8qrs530GaKyHZDCS70wT5VbgvxHKFwdmI/HsFY3cH9xwpE+iy+
         6r7zpM/bJjMbthBEA+RPRzx4qYOqy2bHim2pM90SByN628IDV0gspHoXhwENKqDaS1D6
         YRqA==
X-Gm-Message-State: AD7BkJJbERY236Lv6YnBy4LgBVpnXqTPT9hIbPGmIH23QO32RYxcH0E7pNBw68lo93GFZtg9qFQYbY4zaJtnowTO
X-Received: by 10.50.23.43 with SMTP id j11mr20388320igf.94.1458165197286;
 Wed, 16 Mar 2016 14:53:17 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 14:53:17 -0700 (PDT)
In-Reply-To: <20160316214442.GC4441@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289050>

On Wed, Mar 16, 2016 at 2:44 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 16, 2016 at 05:37:03PM -0400, Eric Sunshine wrote:
>
>> A much easier solution would be to update OPT_VERBOSE() to understand
>> that negative values are "unspecified", and then --verbose would
>> (pseudocode):
>>
>>     if (value < 0)
>>         value = 0
>>     value++;
>>
>> and --no-verbose would:
>>
>>     value = 0
>>
>> That should be compatible with existing clients of OPT__VERBOSE()
>> which initialize the value to 0, and should satisfy Pranit's case; he
>> can initialize it to -1, and if it is still -1 when option parsing is
>> done, then he knows that neither --verbose nor --no-verbose was seen.
>
> Yes, that makes much more sense to me. Thanks for the back-story.
>
> -Peff

Is there any command which needs more than one --no-verbose?
(as an abuse to stacking --quiet multiple times)?
