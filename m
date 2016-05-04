From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 02:07:50 -0400
Message-ID: <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:08:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axpyp-00070d-H4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbcEDGIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:08:10 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33098 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbcEDGHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:07:51 -0400
Received: by mail-ig0-f193.google.com with SMTP id rc4so4907778igc.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ctQrfXwICwkm83cCkvltxxdu3lmRdKp6cx99VC1ZryA=;
        b=BS+AhCAArOTMiDHhyCR/551k38O2Q//CUN6rnAk0oHjFMUYgtmwxh7+/QOSAynQP/z
         mYQm/BCFsYlwbOcB1eq9aeWLge+fFSbkYAuNy79TvMPVubNELIuy7HC2fqKySWBE6Z/7
         FxtvebngUY3jZKpTpbxyIIvUqt12PM0qLg9JcUUcmqTPEFDvMLpm0FZIpUQE2sk3ZfNG
         LSUJbavkeTfJD2lRou8kpQ6NxILhvNFETEbJ0pFek879MiMFDLr+DQWKvHGiJRx0/Qyc
         /NwQSD+YTBjMCsNKGq9MInn4/KTXASdKoqMyC6V5AuDgWgDz5+C3syptPCFjaFb0G1oR
         8kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ctQrfXwICwkm83cCkvltxxdu3lmRdKp6cx99VC1ZryA=;
        b=GrOJbn3pBl+q8JNt3ZfkxbMRK0dD2eQpsnjhm90Rxa3qQInm/dd1/hVaiM82SC4byN
         iueZt/NOrOllkM55KFKUOzkW+KlB5vtpbUIq56tYqrYwEAZaUuigW9MZqnILAqEY0oZu
         /vRBGGmgg5a8Uc2vL7te02rlALzXOg1kyrZtjM8kaJY0VfEbME71Ji87L51Rcp/gTrvh
         IiO6OySPA4Sj2O6oJi1JhErHHe00nfXxFndO7iarkbnnTn/oJKvjjxGdlXv6kacF7Fv5
         vVQRmC+BMyCLC22HD/wc023Zt7Yxtl1ocO8KbfLoPB62/PMH+P7cipaqGT6429q9vlPj
         KY8g==
X-Gm-Message-State: AOPr4FVpM6iW+rh7+fOvY25U8IIPOzlJjiMNbcudcI5mTcrQJKSG9OZ7pXJaYsogx72/lYfGaLiRKJ8UnCwviQ==
X-Received: by 10.50.3.105 with SMTP id b9mr8532348igb.17.1462342070895; Tue,
 03 May 2016 23:07:50 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 23:07:50 -0700 (PDT)
In-Reply-To: <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: 3WmGDDdHUoGD9QY-xzIMy71hURk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293494>

On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

This subject is too low-level, talking about implementation details,
whereas it should be giving a high-level summary of the change.

> `--next-all` is meant to be used as a sub command to support multiple
> "operation mode" though the current implementation does not contain any
> other sub command along side with `--next-all` but further commits will
> include some more subcommands.

You've spelled this as both "sub command" and "subcommand". Choose one
and stick with it. ("subcommand" is probably more common.)

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>         NULL
>  };
>
> +enum sub_commands {

How about calling this 'enum subcommand' (no underscore, non-plural)?

> +       NEXT_ALL = 1
> +};
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -       int next_all = 0;
> +       int sub_command = 0;

s/sub_command/subcommand/

>         struct option options[] = {
> -               OPT_BOOL(0, "next-all", &next_all,
> -                        N_("perform 'git bisect next'")),
> +               OPT_CMDMODE(0, "next-all", &sub_command,
> +                        N_("perform 'git bisect next'"), NEXT_ALL),
> @@ -23,9 +27,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                              git_bisect_helper_usage, 0);
>
> -       if (!next_all)
> +       if (!sub_command)
>                 usage_with_options(git_bisect_helper_usage, options);
>
> -       /* next-all */
> -       return bisect_next_all(prefix, no_checkout);
> +       switch (sub_command) {
> +       case NEXT_ALL:
> +               return bisect_next_all(prefix, no_checkout);
> +       default:
> +               die(_("bug: unknown subcommand '%d'"), sub_command);

s/bug/BUG/

Also, as this is a programmer error rather than an end-user error, it
does not need to be localized, thus drop the _(...).

> +       }
> +       return 0;
>  }
