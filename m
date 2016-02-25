From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 22:19:05 -0800
Message-ID: <CA+P7+xpkbZyuQ7gpC+_KzJPfGo+xHpVFWEmr1oS7FD30jjJSOQ@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com> <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpGs-0008Ie-VA
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbcBYGT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:19:26 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34509 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbcBYGTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:19:25 -0500
Received: by mail-ig0-f176.google.com with SMTP id g6so7733902igt.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 22:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2+dbmBYwwyjiXVBXRjq4RQAeP4ADleGZ0qwG3Zalrf4=;
        b=hzioPqGR7NhPQtBh4QwxIuYccp0likiUrzCsE9ChxZ+Bc0iNENN0Iy6WVsw/S6LHCV
         tr2P04NwXMYZoFBV2G3/xRIXmqlmm4amPZ0xpwgg0i6Smf/UdrSsxIcuOUiyRHVECAAU
         lF6F+TLOApwtJWXDh/qlioodRXjPqUkturWm8pDxU/K7S9ArvLHxOjIB0BOGfwRIHqVh
         Wwb0XafOBSDjjwmm+fBmCOoCmtxqnboac1kGI1TstGti4aM9ecAEArb5jEtdsPHgg3aq
         tCbzt4hgc1tATaOu8Cxtx7wnv7d2eWYLiycNUygepZWOI2SmnScjl60OpKB7GRYqPPh9
         KxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2+dbmBYwwyjiXVBXRjq4RQAeP4ADleGZ0qwG3Zalrf4=;
        b=MQzgNq/9HxOyj5uE08AzvIT2x6nLgEEzrxytjO/JSwAgT70OUw6ZfC5fMqtj5ZeWC6
         NQnT/bknE5pR+pKz98dJSwi97bDBX02QKgT7/T/i+4VgIwrKZEe3zxxn5rUTosxu7PTh
         hoS49Bzfy5PtfsM4tuSw2ui9260uFlr2T3HkyCN8mHl1Mw5f1NBWoOgq0ALOPuS7F0n/
         6nRev8ukhYi6HsB2mRH29ZUvkAiNMH69ZK87rw6Fwosca2Fg2JuGShOBjaOtA0yxInfP
         cbD87PD1FvXqwMfKgb6EuIdWbRz+lPAP4Gu78waEhqPWSIorNHiTis002TYWi9wfA23Z
         i8NQ==
X-Gm-Message-State: AG10YOTC+0eojE20iR4I9WhssqQ0jN0nXHrYsThZ2bGS+WgwM9qi1F0TrEIEqclQcxQb7ZcDn9UOfb49v/NDQg==
X-Received: by 10.50.142.103 with SMTP id rv7mr1494874igb.35.1456381164999;
 Wed, 24 Feb 2016 22:19:24 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 22:19:05 -0800 (PST)
In-Reply-To: <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287331>

On Wed, Feb 24, 2016 at 4:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> ---
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> @@ -255,6 +255,61 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>> +/* Rules to sanitize configuration variables that are Ok to be passed into
>> + * submodule operations from the parent project using "-c". Should only
>> + * include keys which are both (a) safe and (b) necessary for proper
>> + * operation. Right now only "credential.*" fits both criteria.
>> + */
>
> Drop the final sentence for a couple reasons:
>
> 1. It's merely repeating what the code itself already says, and...
> 2. It's likely to become outdated when additional variables are added.
>

Yep. I'll drop that, makes sense.

> Also, style:
>
>     /*
>      * Multi-line comment
>      * style.
>      */
>

Hah. I contribute to the netdev kernel a lot, and for some reason they
prefer the style above (but only in net/ code). I get into a habbit of
doing that too much I'll fix this.

>> +               /* combined all the values before we quote them */
>
> Comment repeats what the code already says, thus not terribly useful.
>
> Also: s/combined/combine/
>

I tend to make comments like this when I change the obvious way it was
done, I commented this because I based it on a scratch patch from Jeff
that didn't have them put together before quoting.

>> +               strbuf_addstr(&quoted, var);
>> +               strbuf_addch(&quoted, '=');
>> +               strbuf_addstr(&quoted, value);
>
> strbuf_addf(&quoted, "%s=%s", var, value);
>
>> +               /* safely quote them for shell use */
>
> Comment repeats what the code already says.
>

Will drop this as well.


>
> Perhaps not a big deal since the program exits immediately after, but you could:
>
>     strbuf_release(&sanitized_config);
>

Yep, just an oversight, same for the quoted string as well.

>> +       local sanitized_config = $(git submodule--helper sanitize-config)
>
> Is 'local' a bashism? (Although, I see that 'local' is already being
> used in relative_path(); perhaps that ought to be cleaned up.)
>

Apparently it is, I wasn't aware of that. It's supported on more than
bash, but it's not POSIX.

>> +
>> +test_description='Basic plumbing support of submodule--helper
>> +
>> +This test tries to verify the submodule--helper plumbing command used
>
> Maybe: s/tries to verify/verifies/
>

Yes. I used "tries" with the intention of needing tests for the actual
functionality as submodule--helper is expected to go away.

Thanks for the review, I'll have these cleaned up in v3

Regards,
Jake
