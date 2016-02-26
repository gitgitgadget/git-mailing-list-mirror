From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 3/3] git: submodule honor -c credential.* from command line
Date: Fri, 26 Feb 2016 14:19:32 -0800
Message-ID: <CA+P7+xpArLkv2_3juxMFBct1=31hf-gdaOT43pN9CbpuHaz5AQ@mail.gmail.com>
References: <1456514268-8241-1-git-send-email-jacob.e.keller@intel.com>
 <1456514268-8241-3-git-send-email-jacob.e.keller@intel.com> <CAGZ79kZnR3EsESCFdORq84awWnRZZ9A_+mcH_54ULZZJfD8xyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:34:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQyG-0008R3-DE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbcBZWem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:34:42 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36933 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933955AbcBZWTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:19:52 -0500
Received: by mail-ig0-f180.google.com with SMTP id z8so44979933ige.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gJT6Q5nulne/dpXgbNHud8Qfr9vEiEtzZ+co+/QF42M=;
        b=fbAqj11n9ia9XDhQ3pU+mA8C83ERRU2DNBOVJH4GsWIqF7kuRzyoVifl5DcXWKMihm
         yyGL/9q3RsoKwCLzZ8Gk1cPt5PG1rVX1K6SFQNV/ONFoulZDGOPl8E3YbFH/PdC4ejEx
         cM5Q0xubwd1zrn0b9lQt9eQp1Q663zLm18m5u6OmFzvzYLubMBSNDNDEwipjvzOhJ2To
         vEjP7UMSM5Y/nYsR8DGYe0ckAdXxXGptppjX09ckhj2JFtm6CC57ZDCiZGEhmPwNXAyr
         t1uyu7tWZPKWIljnE5Z2cudgCvr9j15mzW5j3m+nI49j9ujq+u9ld0MrmQrkq4tItKSQ
         It0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gJT6Q5nulne/dpXgbNHud8Qfr9vEiEtzZ+co+/QF42M=;
        b=PkFCV238/p/vaMIDM6anB1cYW8OS4WQe2Y3LYfruQqlk9gLTg44fSTti1t0kjQ7zpi
         avGntX8W89iJlYqQVm5/ZwYenP+Ql4KTVqNzbCTqd3Ns/W7zB/VxvbL5ALlySa9mDagp
         a7vnHpViK/ebIxMlRrXn8E3silcifM+KEQ1MS1wur2yob4B8UjpqGpBK3XKncLMFOB/j
         bvh+Rkh5O317xYwmZciSEGWth6UVGMX9LNhvvKabW/iUvfBjTGst2uDjfID2TSrcr2lX
         gEVwBcfPZgGCQo5tnzxt7EKpNl1qIoUL7Jgb67h9HJNWH79uLYSJQ1Qos+Tsm8KfJlYr
         dRbg==
X-Gm-Message-State: AD7BkJLUn+SLTLkkVE2n4src4V7rjlFEPCLfTGuWg6PFKsEj2a4t7PHPHBnUMcyN6oQXROnFNuKWN67tMeIcQQ==
X-Received: by 10.50.108.112 with SMTP id hj16mr223292igb.35.1456525191868;
 Fri, 26 Feb 2016 14:19:51 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 14:19:32 -0800 (PST)
In-Reply-To: <CAGZ79kZnR3EsESCFdORq84awWnRZZ9A_+mcH_54ULZZJfD8xyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287630>

On Fri, Feb 26, 2016 at 11:41 AM, Stefan Beller <sbeller@google.com> wrote:
>
> In the future, would you mind to try interdiffs in a cover letter?
>
> (I do git diff HEAD...$(previousSeries) with previousSerier either
> local branch or rather what Junio picked up already. There is also tbdiff,
> which should be better and easier than this work flow)
>

Yes, I should do that. I could just use the reflog for this actually,
for my workflow.

>
>> +                */
>> +               strbuf_addstr(&quoted, var);
>> +               strbuf_addch(&quoted, '=');
>> +               strbuf_addstr(&quoted, value);
>
> This could be `strbuf_addf("%s=%s", var, value);` (?)
> which then gets quoted below
>

Is there such a thing as sq_quote_buf equivalent of this? If not,
should I add one? I think that might be preferable since we'd drop the
entire extra strbuf variable.

>> +                       git_config_from_parameters(sanitize_submodule_config,
>> +                                                  &sanitized_config);
>> +                       argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
>
> like here?
>

Ya, I just wasn't thinking of strbuf_addf. But I think I'd rather have
sq_quote_f or something created instead to drop the need of a separate
strbuf.

>> -                       subsha1=$(clear_local_git_env; cd "$sm_path" &&
>> +                       subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
>>                                 git rev-parse --verify HEAD) ||
>
> While at it, we could discuss if we want to replace the pattern cd
> <somewhere> && git-command
> by `git -C <somewhere> <command>` eventually (not in this patch) ?

Yes, we should use git -C instead, but probably not worth too much
effort if our plan is to drop the shell code eventually? Might be
worth the cleanup, especially if it lets us avoid a subshell. If we
still need the subshell for other non-git commands I would prefer to
leave it as "(cd <somewhere> && git command && other commands && ...
&& )

Thanks,
Jake
