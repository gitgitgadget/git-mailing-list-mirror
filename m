From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 12 Mar 2016 12:19:13 +0530
Message-ID: <CA+DCAeSF5UJ-CVe0bFrvx=iixs-wjZ8T_OALCvMA9oN+SfYWoA@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 07:49:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aedMX-0007lO-1B
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 07:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbcCLGtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 01:49:15 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36377 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcCLGtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 01:49:14 -0500
Received: by mail-qg0-f52.google.com with SMTP id u110so116362748qge.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=bUl5LhDiA7dKAAkQTvdovSynynngY3L0wk9zPO8y+vs=;
        b=SFZ7lpWnxtnGUssyNk3b5NTpByaZfH7UcRLbAjXqgboHxilhBik+EiAK8Pi+lFIdza
         D9gpvK/hZC2+RSwG+0kBT1RH9NSPZ0C5F2HaZCHcYrqNrORYS1LCte+qf2bfnkuzF3YF
         w2sUizD43oJVl72AYAzhAYEJWuSLixHCpavyzgkQYFdf1e9aOsJaeBygjtx+4I4QkVqN
         ixV9hJV/NktiD9I1Y7Y62z2b9QwnZoQ2i7TuW9Mz9b/auss7Phq7aNqgA2izLp6uPkJ+
         40SohizlREgK5Av3J0+Su2DW0MaSR2MX0GY68PAoCRb1wRnTzxrexEu81W6f/YdPR7+e
         efhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bUl5LhDiA7dKAAkQTvdovSynynngY3L0wk9zPO8y+vs=;
        b=BK/CBcutk4XWSddvcdlDbWUqPA4+3jNdHD71kNoLLpG2rX69SJFz19/kOUIoh2Nkl4
         AuEaXmjc4PFCemn1PamDP2lWdvZUe9iFb2gF7nugb+tB3QK2x0/gMU+yQN+ZGuBVrEch
         JZIzgt54qyAhwlhG6c0VRT+u4lMdiPItQFtddfZjtZJ6NXyECt+5F61ruVYepA5jvMAb
         TBWTS8R6BSmKY9yMRpt+l9Dpjod/0rMW0zCzvoYXzakFLm7sVKpypS++LZbYUum5JSte
         iAKFwEVK2+ZnKaGCaAkY1nk7rMaOKx50lt9FNpdj9xvjH50LIoo1we0uPXUi3Ol80I7R
         NowA==
X-Gm-Message-State: AD7BkJKFZoB/eLdTM93OphKbl7+dabEzivkD1sSp7IWCnDoiM9Iowv0fblRy0nA4zYz3UklWPa6xU54Yh/IV0g==
X-Received: by 10.140.86.213 with SMTP id p79mr16536298qgd.76.1457765353812;
 Fri, 11 Mar 2016 22:49:13 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Fri, 11 Mar 2016 22:49:13 -0800 (PST)
In-Reply-To: <CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288726>

On Fri, Mar 11, 2016 at 10:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Stepping back a bit, the only reason why we introduced opt_autostash =
> -1 as a possible value is because we need to detect if
> --[no-]autostash is being used with git-merge. I consider that a
> kludge, because if git-merge supports --autostash as well (possibly in
> the future), then we will not need this -1 value.

No, there is one more reason for which opt_autostash = -1 is required.
When user calls "git pull --rebase" then config_autostash value will
be used to perform --[no-]autostash task but if user calls "git pull
--rebase --[no-]autostash" then config_autostash value should not be
read at all as this option is supposed to override config_autostash
value. So if opt_autostash defaults to 0 then how will the code
understand if "--[no-]autostash" flag is passed or not?

As per the current patch, the value opt_autostash = 0 or 1  tells us
that the user has explicitly asked for --no-autostash or --autostash
respectively, and -1 value tells us that user has not specified
anything and thus we should read config_autostash value to perform
--[no-]autostash.

One way to do this was to read rebase.autoStash before parse_options(),
but now  as we have introduced a callback function git_pull_config(),
reading this config variable before parse_option() will now require
calling git_config(git_pull_config, NULL) before parse_option() and
doing opt_autostash = config_autostash there only.This may lead to
some problems (I'm not sure of that), as git_config() reads many other
config variables too.

Thanks,
Mehul
