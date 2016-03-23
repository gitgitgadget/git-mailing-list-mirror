From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
Date: Tue, 22 Mar 2016 17:14:24 -0700
Message-ID: <CA+P7+xoPe7=1ugLJ11iV-76ChiVzMA+WjGYT9KHnnSy9Z8_48g@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <20160322185628.GA19993@google.com> <20160322192309.GA9782@sigill.intra.peff.net>
 <20160322195051.GA20563@sigill.intra.peff.net> <20160322214355.GI28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shin Fan <shinfan@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:14:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiWRl-0004tN-5s
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 01:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcCWAOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 20:14:45 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35210 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcCWAOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 20:14:44 -0400
Received: by mail-io0-f177.google.com with SMTP id o5so5746206iod.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LlPLJNu6dXyqoPBAIVVciw2BxfO8YkgLtIKOCETwDCM=;
        b=VDjmzduV/3K6jPGhm0YFow+gqVy1xb8AhtTf1XkxKgGo5VMUFj2zs7tVWWgTKcQUbg
         pBHj8E2adqzCRTDaXMg2amVd0S5C4bCGhOu0OnCzj1Rrg1KmLzcp0eXKKg6l6CkswZpo
         Uj3OLjXQ8jXeJMJC4Yg9cgCD/NjdOFox6vckttf4zWHJblvDksZ9kH1Wc/AkZNijFLdZ
         3950TN3mOdtXz6LVHD6gFmyx7pGWTJ/o+N3q9RZVs6Ll6Voci2VAHMBJwFw3YONwmfRn
         n1loBvnywajyt9+As6UlV8Sx+VFFrg6jYQzxEn8hGv4n2glOwnVEEJ/VWblWj0UYe4t3
         pg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LlPLJNu6dXyqoPBAIVVciw2BxfO8YkgLtIKOCETwDCM=;
        b=dMyYimV+omeDSr+Hv5q81Yww2sOD38VPV0HF3oy2GwVuV+dzLV6aAH3hdrznbdUwkA
         vkNbAUsNq8l31JsxmKvbFe6UNOB/Q3cv037M38KTdd4GKIM9W0HbxFrtUbh7L5FCN1Yt
         bs52ukueG2Z3CuwXN2+58ijiSH/AZa10I7ncRz44e/FFJLX3zmpsdJQvCr9b5JIEC8QT
         f1xXyC55lRfdLssVsfW+AcJQ+cYuJ7yNuBvRXfktjMrdgqa5ZzWENyLM14m3FrK7ZrFT
         1unsfkgBdADJUjFYDrx4qKlZA1bspjEorjeWTYn8QL3+BEJKkbQopNuTV52Pgk5I/33s
         fYVg==
X-Gm-Message-State: AD7BkJIbwlc6lnoOc4lplQqn4A8b5+Jid1g7/t8m7CK8u50tnGFfUnYtQUWXq21eFA92wvBuLftyQonKbYfiKA==
X-Received: by 10.107.170.80 with SMTP id t77mr467890ioe.71.1458692083566;
 Tue, 22 Mar 2016 17:14:43 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Tue, 22 Mar 2016 17:14:24 -0700 (PDT)
In-Reply-To: <20160322214355.GI28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289589>

On Tue, Mar 22, 2016 at 2:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote[1]:
>
>> Subject: git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
>>
>> The "git -c var=value" option stuffs the config value into
>> $GIT_CONFIG_PARAMETERS, so that sub-processes can see it.
>> When the config is later read via git_config() or similar,
>> we parse it back out of that variable.  The parsing end is a
>> little bit picky; it assumes that each entry was generated
>> with sq_quote_buf(), and that there is no extraneous
>> whitespace.
>>
>> On the generating end, we are careful to append to an
>> existing $GIT_CONFIG_PARAMETERS variable if it exists.
>> However, our test for "should we add a space separator" is
>> too liberal: it will add one even if the environment
>> variable exists but is empty. As a result, you might end up
>> with:
>>
>>    GIT_CONFIG_PARAMETERS=" 'core.foo=bar'"
>>
>> which the parser will choke on.
>>
>> This was hard to trigger in older versions of git, since we
>> only set the variable when we had something to put into it
>> (though you could certainly trigger it manually). But since
>> 14111fc (git: submodule honor -c credential.* from command
>> line, 2016-02-29), the submodule code will unconditionally
>> put the $GIT_CONFIG_PARAMETERS variable into the environment
>> of any operation in the submodule, whether it is empty or
>> not. So any of those operations which themselves use "git
>> -c" will generate the unparseable value and fail.
>>
>> We can easily fix it by catching this case on the generating
>> side. While we're adding a test, let's also check that
>> multiple layers of "git -c" work, which was previously not
>> tested at all.
>>
>> Reported-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I should have mentioned this is
>
> Reported-by: Shin Fan <shinfan@google.com>
>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I just did this on master, and it is standalone. But for the reasons
>> above I think it would also be fine to stick on the tip of the
>> jk/submodule-c-credential topic.
>>
>>  config.c               |  2 +-
>>  t/t1300-repo-config.sh | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for the quick fix.
>
> Sincerely,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/287928/focus=289551


Yep, thanks Jeff. This looked fine to me.

Regards,
Jake
