From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 15:51:01 -0800
Message-ID: <CA+P7+xrJkOaqfOBOK7oh1w97dEJytyPN5UbH6ctK+saGUSkZiw@mail.gmail.com>
References: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
 <CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com> <xmqq1t81smu6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:51:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjDU-00076Y-TV
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbcBXXvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:51:23 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35152 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcBXXvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:51:22 -0500
Received: by mail-io0-f177.google.com with SMTP id g203so71034911iof.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 15:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=00tYxuwCd/VpFMMghRV6eATso8owFS9JsPXOxDKiR7c=;
        b=Yg2Oc/Ju+edSFZcF+YwPyjqNb2YZvrMbB58xYumaEjY8+BWkWV8IannwatFfPalI7q
         ttikp1634BH5xB9x8mtg1f12ePYFi0nXdJS6ax6QhEO7u8P8ub5hfFZUjQWF5Z2Xmne5
         fktjceH7/dJfCBBUbkyiT2gKxkEuuQ8U9fEQbM4Ex6nRNG7wTBA9dG3Z5Z71iV0xCHAx
         2KBHJ2TNBPX/996b3bC2zLY/Ylcz3mogZG7DEvieUpuwGfsmfoFO9cpdcmw7hcQjSfSl
         DIdcEkQPb6sisMF8plwhT0kdZIid52hLoWzU3QCoiNHspwqONbABORrTyHShQXkwWnHP
         P1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=00tYxuwCd/VpFMMghRV6eATso8owFS9JsPXOxDKiR7c=;
        b=CJADA3zC3iwXIvYRWes+kJnSPjgfVbhUn3m4KdbHHYFtoVvy+69wSrvTtH/Gev2PUV
         bRfa8TWRJBZ3Wh9neOXnzwsCh/kBb+W5KyTGC42a1p+iFukoTjNYt1W2aKkKM77JGJd8
         Pa9htp7DPqJa9a5kJ9hIiEhBGZx7S9Y2vta2rrfXW0wmJRw+TrTA2NaoYDe0muxRu3sB
         uPNi6lAQSDmTbnG3cpl+NCqZgT3IbDiq1OorX2RJeSR90xNSPGfra7XdIt4kNsejWmvf
         pSbIFbsZVxSTisOKIWm/Qnf4HC31kqrIFqj3DIPWCs3ckAYtVRJ/Jqm0OCkvXFD8T3mh
         V/Gw==
X-Gm-Message-State: AG10YORyIBGvIWv3vDHrjcERp1NHHBq5WNxkoreFSiFeKtAl5H2inuyalHXgdETIhyohzOmk8pD9DPG0UZ/VjA==
X-Received: by 10.107.156.14 with SMTP id f14mr309179ioe.0.1456357881297; Wed,
 24 Feb 2016 15:51:21 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 15:51:01 -0800 (PST)
In-Reply-To: <xmqq1t81smu6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287283>

On Wed, Feb 24, 2016 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Feb 24, 2016 at 12:09 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> From: Jacob Keller <jacob.keller@gmail.com>
>>>
>>> Due to the way that the git-submodule code works, it clears all local
>>> git environment variables before entering submodules. This is normally
>>> a good thing since we want to clear settings such as GIT_WORKTREE and
>>> other variables which would affect the operation of submodule commands.
>>> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
>>> preserve these settings. However, we do not want to preserve all
>>> configuration as many things should be left specific to the parent
>>> project.
>>>
>>> Add a git submodule--helper function which can be used to sanitize the
>>> GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
>>> restrict this to only credential.* settings.
>>
>> I guess for now that subset is fine and will be expanded over time?
>
> I think it is more like "we pass only what is known to be necessary
> and safe, and right now, credential.* are the only such variables."
>
> As the system evolves more, theoretically we might find more, but
> let's not phrase it as if expanding is a good thing and a longer
> term goal.
>

I can reword the commit message to that effect.

Regards,
Jake.
