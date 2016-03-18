From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Thu, 17 Mar 2016 23:53:16 -0400
Message-ID: <CAPig+cRmA5qQQxrHhE=3b7QPKWtSQq6ks2qPRc5v0yrE20pRsg@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
	<CA+DCAeSoyKyO+SVYuY7oYF-2YK4pgvQEKpe7FpU6=5Ag+KeT-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 04:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aglTY-0003Lx-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 04:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbcCRDxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 23:53:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35970 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbcCRDxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 23:53:17 -0400
Received: by mail-vk0-f68.google.com with SMTP id j65so8519649vkg.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=O50reMSg49jM75TOUq9qBxyMVgmnfIGAoxSGWHBc/+8=;
        b=QWprMBh4ug86Rcr+mGUMURuFvMhBvJRetQQ0qKCu2dKg6Aqz9lhT3Ed36h3abifTfO
         tPxBw6AhBqf3Zkydbq7sTT2Ih/5cFApmtvr4kQDMte8gAY7pg0A6GR0gkPC3WQJPJJ/l
         aGj4k0V9N8KKbhagDXgnajVvbn9C94uBJhSOEUpcU/pWp3BQ7MY9VCPlCot2zjaPiOIN
         03aYj7LOUvjKC11ws6+T0J+k/ElYJvMZ8VlZLsv9/z8Vdj/m1oVJz22JdY1G0iqNR22Q
         nktwijrVoSQHOG3oExWo/lneIlLmbUohm74T92QaXHtzEZ3YPdTCA9777nGYVKp82P32
         WnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=O50reMSg49jM75TOUq9qBxyMVgmnfIGAoxSGWHBc/+8=;
        b=afTABCjb9UZyhmCpQPnsaOPvyOmS5rco5unqQwGiP8HHumNcrE5RniDEAJhAftbw5t
         WntPNd9MdgAYIMr+9IbeD67wjbtGpj/mmQC66001fPbSkyHhhY5suwEAFrZIrig5KDf+
         Ch+1E1I/BrfgmzYhdspCXa9IFAZ/Hyq376Z+7FgVdp1l216Ah3KSrTjTce6qOs16jpi9
         pZCiZQ+ntBX1spI3Okz3W7Z8UZR8NMLvwhV9qmK5/pD64SdR3LhcQpJJhp9UZ6MJogBT
         Q0HIYt3up25dZEHOwAJWmyA6Lx8fRIm7IjDTisajI+iMd/JmdApskblZkaMZf+mSM1Nm
         5dvw==
X-Gm-Message-State: AD7BkJJFohtQYUgBPsUDvE3vfIaeYqFcoencsgoR68+5jnZOpi9/eRI3qXZVC81llcM1xhODotwLeIm1U1sddQ==
X-Received: by 10.31.141.2 with SMTP id p2mr15256536vkd.37.1458273196789; Thu,
 17 Mar 2016 20:53:16 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 20:53:16 -0700 (PDT)
In-Reply-To: <CA+DCAeSoyKyO+SVYuY7oYF-2YK4pgvQEKpe7FpU6=5Ag+KeT-Q@mail.gmail.com>
X-Google-Sender-Auth: y3d07IKFi-ZXYpkyRATeqUN6yaE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289180>

On Thu, Mar 17, 2016 at 4:17 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> I tried out this approach and here's the result.
>
> +       if(!opt_rebase && opt_autostash != -1)
> +               die(_("--[no-]autostash option is only valid with --rebase."));
> +
>         if (opt_rebase) {
>                 int autostash = config_autostash;
>
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes
> added to the index."));
>
> +               if (opt_autostash != -1)
> +                       autostash = opt_autostash;
> +               else
> +                       opt_autostash = config_autostash;
>                 if (!autostash)
>                         die_on_unclean_work_tree(prefix);
>
> This way of implementation looks a bit less clean to me than
> the previous one because we are using "opt_autostash" to pass
> the "--[no-]autostash"  flag to git-rebase, thus if user does not
> specify anything about stashing in command line then  config_autostash
> value has to be used ( i.e. opt_autostash = config_autostash).
> To do this an "else" case has to be introduced in the code. This
> might effect the readability of the code because the reader might
> wonder why "opt_autostash" is used to assign value to "autostash"
> in one case, and opt_autostash = config_autostash in other case.

That's pretty ugly. Since cmd_pull() is the only caller of
run_rebase(), an alternative would be to pass 'autostash' as an
argument to run_rebase(). However, since run_rebase() is already
accessing other 'opt_foo' globals, it wouldn't make sense to make an
exception of 'autostash' by passing it as an argument. So, in the end,
the original approach is indeed probably cleaner.

> Also I made a mistake in patch 1/2 which I will correct in the next
> version along with other changes suggested by you.

Which mistake would that be?
