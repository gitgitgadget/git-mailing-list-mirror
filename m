From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] cleanup submodule_config a bit.
Date: Wed, 12 Aug 2015 14:34:03 -0700
Message-ID: <CAGZ79kbV45LqxCha516dRNYAjAH71mxce6Xazvfmf1deLMzUxQ@mail.gmail.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
	<1439406838-6290-3-git-send-email-sbeller@google.com>
	<CAPig+cTcWME_U+nYATK7kK0vOSSCjJmGgXmUVmSawBiV5M+02g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPdf1-0005j8-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbbHLVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:34:06 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34454 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbHLVeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:34:05 -0400
Received: by ykdt205 with SMTP id t205so25910285ykd.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KZn8dD53/kCJ/mrJKoK+7QAM2GaZ37sbZSlpLGF0kMQ=;
        b=f3br0g0JXZZ4KBoPKStMD2oWAZVZDZEypl6/7vDTvIT+8zacr6TxQK3DAujuupJFO8
         Cosg4m97lGrjzjuN8MO4yfv7ysUvoXrFCj4Nuflc2WbmBktpQdNrDy5Ra0jNiqDLDJS2
         uZGduzxTiqVFR3jxDS+I9EKAjBVDsKdnylQy45crqrfg1+SMIf8XyB8U5rjZgRw8RrX9
         0cmBqdFISvDLVEi2jp/twE2TPtdRTUUYaqP41X+Y2AO3Rlk3clwSbRi0T7h6K9sAX0xJ
         ENvyW2f/OSHDAkcqJ/EbaCSsFm4S4Ue+YtXPZQJKaOLK1o8medvNW6WpORosaGn/rc8/
         mHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KZn8dD53/kCJ/mrJKoK+7QAM2GaZ37sbZSlpLGF0kMQ=;
        b=gXJ4jwyNZQ5dEX1ihIVsUmF1CUQ0ily/hM8tsB3F1IgwxRzCnji2Ze7Ms1CKOaScvA
         0qtN9iyT4b1Wk8RkmfhSmrD2QI4X4sGiFQaiUW3KWC/fQ7C0LvHMVxar/5Hp5JoeMTWG
         o31xJhgpH0to0wczU7kBgzYghR1vGRo8EWtORgh3P3IZL+kFtUSfSgOjdKaL31yucpTx
         +9/Hb64XUkwTzmHtPcw+yDlO3F+3MI30QKyK3RZHnv7mxczd6K9s+vN2wnK5esJK34mX
         6HF8GKXw1oYrqsJZIA1YcYlmzVnNmJVUh26XDRXM3DsA66toSmual64XO8WQikiYDi0G
         D5TA==
X-Gm-Message-State: ALoCoQnleqJVPPN52BaQ16ptyr1wW9rVtDTQ9OIYXqI0GzxS7XclguobpQETe8oY1/Fkmz22fTct
X-Received: by 10.129.101.135 with SMTP id z129mr34670143ywb.81.1439415243838;
 Wed, 12 Aug 2015 14:34:03 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Wed, 12 Aug 2015 14:34:03 -0700 (PDT)
In-Reply-To: <CAPig+cTcWME_U+nYATK7kK0vOSSCjJmGgXmUVmSawBiV5M+02g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275811>

On Wed, Aug 12, 2015 at 2:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Aug 12, 2015 at 3:13 PM, Stefan Beller <sbeller@google.com> wrote:
>> In the first hunk, `submodule` is NULL all the time, so we can make it clearer
>> by directly returning NULL.
>>
>> In the second hunk, we can directly return the lookup values as it also makes
>> the coder clearer.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule-config.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 199692b..08e93cc 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -387,7 +387,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>         }
>>
>>         if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
>> -               return submodule;
>> +               return NULL;
>
> There are a couple other places which return 'submodule' when it is
> known to be NULL. One could rightly expect that they deserve the same
> treatment, otherwise, the code becomes more confusing since it's not
> obvious why 'return NULL' is used some places but not others.

They were slightly less obvious to me, fixed now as well!

>
>>         switch (lookup_type) {
>>         case lookup_name:
>> @@ -420,14 +420,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>
>>         switch (lookup_type) {
>>         case lookup_name:
>> -               submodule = cache_lookup_name(cache, sha1, key);
>> -               break;
>> +               return cache_lookup_name(cache, sha1, key);
>>         case lookup_path:
>> -               submodule = cache_lookup_path(cache, sha1, key);
>> -               break;
>> +               return cache_lookup_path(cache, sha1, key);
>> +       default:
>> +               return NULL;
>>         }
>> -
>> -       return submodule;
>
> Earlier in the function, there's effectively a clone of this logic to
> which you could apply the same transformation. Changing it here, while
> ignoring the clone, makes the code more confusing (or at least
> inconsistent) rather than less.

Not quite. Note the `if (submodule)` in the earlier version, so in case
cache_lookup_{name, path} return NULL, we keep going. The change I
propose is at the end of the function and we definitely return no matter
if it is NULL or not.

>
>>  }
>>
>>  static const struct submodule *config_from_path(struct submodule_cache *cache,
>> --
>> 2.5.0.234.gefc8a62
