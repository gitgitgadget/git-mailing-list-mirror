From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 08:40:22 -0700
Message-ID: <CA+P7+xoiyEdKQhcb7QAQOqr2ynhmyNtg3_+Jdi3s6vsfVHMo3w@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133744.GC25319@sigill.intra.peff.net>
 <CA+P7+xoJrU884n7xG_kof46TSg_4NwS=5+nZza8PM7D=YtsXng@mail.gmail.com> <20160428153601.GD31063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:40:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avo3c-0002sH-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbcD1Pkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:40:43 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34850 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcD1Pkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:40:42 -0400
Received: by mail-ob0-f169.google.com with SMTP id n10so35955777obb.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=53A6aea/1b9+J5CkR0CyE0g+rwuAY5+DpnJwDIOspW8=;
        b=Na2BWLuh9WOWps5WUxrGwYF+Zctxi2MuEkyy8UkqL6YTXO/MCXaVBKyumP/rK9VRiU
         jaTAHUJVEevGrnDhlQLFG+oj+vC5mRfzIJmtr4RoiSgo4uohnIBCaxQVUpz29H3XZgXp
         /ZYfNr5x4k9vrB9Owt77MXK9N3E7nZdT6hgpXJxyrrnRloRVHubk3hx8QhqW298PFFXv
         4RTR9CRyMEX0Ts6HRd2+sEPUSTkE5+U8NJ7JCWfIx5aM8WJsUo9Fb09oeCrPx3SCzeqq
         3ySWERrSoYCuASbfoHUrOmhJvE99n1ui8Y9nF6q/oqhoolWTlzsw5Yy/RX2TIuRbB0r9
         jR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=53A6aea/1b9+J5CkR0CyE0g+rwuAY5+DpnJwDIOspW8=;
        b=hc3yGYqNTRn8uVfrj0KiCOtunhGB6S0NHjTulIjTfvwqoAOmwJra3/w1l9nJV1QZPx
         PdKbZNBOhybDyftE7HMopK73dhpwfveNCgSRtu6eStayA/XDTr0WcOjggx3STtI1hBn4
         2AlC4755vM36KTrSmv96KgzOXTztCwpZEwo9x8HhSBBgqViBBJ7XKrUVKxDmu7j5Mgj+
         U2dtjwYB5bPgdB5RLa/sQWIaFsmt0IoUvORbp70HXGGNg7j/qTo3rZ4WfVyVeO1vCGlq
         2zEN3WnGsI57si9Wv+xWSXDwhfJJI+WCsBGsbXcNmQRk9KLwUg2bKlOtW0V2uziQ4e8Z
         N0gQ==
X-Gm-Message-State: AOPr4FWUw4MSwOeyoUqnLoL902r2nwx/qn000lNlAoJ7VnvMbx0/M4EWZa2UYebnB+DjSDP2i2nst4cXpCZugA==
X-Received: by 10.182.48.37 with SMTP id i5mr7372945obn.55.1461858041513; Thu,
 28 Apr 2016 08:40:41 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:40:22 -0700 (PDT)
In-Reply-To: <20160428153601.GD31063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292909>

On Thu, Apr 28, 2016 at 8:36 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 08:28:29AM -0700, Jacob Keller wrote:
>
>> > diff --git a/git-submodule.sh b/git-submodule.sh
>> > index 2a84d7e..3a40d4b 100755
>> > --- a/git-submodule.sh
>> > +++ b/git-submodule.sh
>> > @@ -200,6 +200,7 @@ sanitize_submodule_env()
>> >         sanitized_config=$(git submodule--helper sanitize-config)
>> >         clear_local_git_env
>> >         GIT_CONFIG_PARAMETERS=$sanitized_config
>> > +       export GIT_CONFIG_PARAMETERS
>>
>> why not
>>
>> export GIT_CONFIG_PARAMETERS=$santized_config
>
> Portability. Try:
>
>   $ dash -c 'one="foo bar"; export two=$one; echo $two'
>   foo
>
>   $ bash -c 'one="foo bar"; export two=$one; echo $two'
>   foo bar
>
> I think:
>
>   export GIT_CONFIG_PARAMETERS="$sanitized_config"
>
> solves that. Some antique shells do not like "export x=y" at all, but I
> don't know if any of them are still relevant.
>
> -Peff

Fair enough. quotes would most likely work and I know I am in the
habbit of using quotes a bit more liberally but this will work
correctly so I wouldn't change it.

Thanks,
Jake
