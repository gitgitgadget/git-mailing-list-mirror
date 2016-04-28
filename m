From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 08:37:10 -0700
Message-ID: <CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de> <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net> <alpine.DEB.2.20.1604281405540.2896@virtualbox>
 <20160428134953.GB25364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avo0Z-0001Tg-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbcD1Phe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:37:34 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35394 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbcD1Phb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:37:31 -0400
Received: by mail-oi0-f53.google.com with SMTP id x19so87624828oix.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FKVGQk3p292rKClhSZYzFe1MY7pTkY8DqrgCpETOqSs=;
        b=W6AN0m6af+YBXytvKCbe9nFupWP5KVtSBTSnEAVZFRX3UZMBhhBpLDxIbSrMZyQarf
         8T976h3pYuWz/0pc5IWkrG4llL0di/c+8ublXtpZ1GngmZepZv8rUnJQe0G6gbbcx8oQ
         CZWAM3hD6cYr0v9uq4YLXMTuUITAtA9UFel0ckCcLZcKWcnwtnchM8Yh2jZblZNYs+aX
         P5ZxGI29sh2JtOL7kG9jAjzNHImCLJ5dyAD4vaZZe8HVk3oN9ydS4rxLqAltwIQSJdpX
         kEn6cZGEcZ5zvJy2VCgrNXeZ6Zo2SQKbeWRTRhfkHJafbgmR5wl5Cu8XqmjfVxcBkFtX
         Bfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FKVGQk3p292rKClhSZYzFe1MY7pTkY8DqrgCpETOqSs=;
        b=VYIS4jJXSWbGHvOnBv8raqFfCWfmcIAZCqFJcZzZYIsvLGfWPIlxlXFGuS+u0+fN39
         rchTUKGJyoTc00xhG2xRIAB/S+syV2dv3fBZVsNZDR4ZrP7IibmkUuacsLCWGnne+dc7
         ldKZu8MWAiELg6fadw/vM7NIWS8fSeGiIjbM1yXOEPc4wQrGtUDb2Hq8DTkA2vF3O9Ja
         a3AA1ECJ7gftWx57nbSJRJ36CbuAz/frMtgUH8vawjb2FQsHXmagBPEDBIOxf2O1ZiqE
         Ti7tkdeL04HOB2RlNomyEb/vYv0If2Nm8OcaCwNQsc6VuMlSbHYp7f0lEjreCoVWHbAX
         CrUA==
X-Gm-Message-State: AOPr4FUXz5Pk9aS7osOZT5xFYPJ+kP5eoQ9ZszHte8TLwjP2IVP6uFSfTmftiCxDdgUp964RT2qtbzsoGi9KDw==
X-Received: by 10.202.58.87 with SMTP id h84mr6976082oia.169.1461857850540;
 Thu, 28 Apr 2016 08:37:30 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:37:10 -0700 (PDT)
In-Reply-To: <20160428134953.GB25364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292906>

On Thu, Apr 28, 2016 at 6:49 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 02:19:37PM +0200, Johannes Schindelin wrote:
>
>> > Should we consider just white-listing all of "http.*"?
>> >
>> > That would help other cases which have come up, like:
>> >
>> >   http://thread.gmane.org/gmane.comp.version-control.git/264840
>> >
>> > which wants to turn off http.sslverify. That would mean it turns off for
>> > every submodule, too, but if you want to be choosy about your http
>> > variables, you should be using the "http.$URL.sslverify" form, to only
>> > affect specific servers (whether they are in submodules or not).
>>
>> I considered that, and thought that it might be dangerous, what with me
>> not vetting carefully which http.* variables are safe to pass on to the
>> submodules' update and which are not.
>>
>> So I had a look now, and the most prominent potential problem is the
>> http.cookieFile setting, which could be reused all of a sudden if we
>> made my patch more general.
>>
>> But then, we are talking about the code that filters what gets passed via
>> the *command-line*. And to be quite honest, I am not sure that we should
>> actually filter out *any* of these settings.
>
> The intent of the whitelist (from my recollection of the discussion) is
> to filter out config that must be repo-specific. E.g., core.worktree or
> core.bare should definitely _not_ be passed to a submodule.
>
> I don't know if there are others. We started with a whitelist because it
> was the smallest and safest change away from the status quo. A blacklist
> would also work, with the risk that we might let through nonsense in
> some cases (but only if the user triggers us to do so).
>
>> The commit message that introduced this particular filtering has this
>> rationale to let only credential.* through:
>>
>>     GIT_CONFIG_PARAMETERS is special, and we actually do want to
>>     preserve these settings. However, we do not want to preserve all
>>     configuration as many things should be left specific to the parent
>>     project.
>>
>>     Add a git submodule--helper function, sanitize-config, which shall be
>>     used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
>>     except a small subset that are known to be safe and necessary.
>>
>> Dunno. I tried to err on the side of caution... But this sounds maybe a
>> bit *too* cautious?
>
> So if we all agree that the sanitizing is really about preventing
> repo-specific variables from leaking, and not any kind of security
> boundary, I think we should generally be pretty liberal in whitelisting
> things.
>
> I can certainly come up with a pathological case where using it as a
> security boundary may have some practical use, but in general I think it
> is mostly getting in the way of what users are trying to do.
>
> -Peff

I think I prefer a blacklist approach, since it reduces the need for
future changes, since most cases will either not put config on the
environment or (based on feedback on the mailing list and bug reports)
the user will believe it should be applied.

A black list which only removed configurations we know are harmful
would be easier to maintain but risks new additions forgetting to do
so. A whitelist means we only fix things as they come up but also
means we aren't "breaking" anything that works today, where as a
blacklist could break something that works today.

Thanks,
Jake
