Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227BB678
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="GG+PnGUN"
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED561B6
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:13:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so20911245ad.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698426835; x=1699031635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPDyM+iPZn0+1vOfM12FmTQNVHgxVRv7qRqh4fWIuP8=;
        b=GG+PnGUN1QfXCctdfjuhlNuDOSg37xAO0iipm2AyOoedH3SoHzYa8xJ5pQNitleTW+
         REbmSDir5WvQ4cV8F1MdkO1QdXZoAge6PxLEdfspk8St4mulEb0Osn7XzbydlHL8Anyy
         pDS8sUhi+l6mX28+HmA7BfqulFdrcCC3dJBgnYojirLoCOnIvQOrMUfT4LLaiI4sp2Nh
         NEWwiabFi4KiYy+eG++oX15qHd+C3ak2lPKKptHOP/+HWMwz1QLfwIcNQjoPUdKMb31V
         XXVME2qk3jT2EA1uReX9F/yYpCcSqPyNeJMoqZhc8/qN9comEae0bBfWewwqNbadtZ4a
         bTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698426835; x=1699031635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPDyM+iPZn0+1vOfM12FmTQNVHgxVRv7qRqh4fWIuP8=;
        b=GYge4GnK7PbHE+pgli4WpkwkGcIC2F39gBBuzMBl9zTcLo2VLvKAmyOnMujqB+tY1L
         MImtGuODaDvRQyLYs5/490L7jajj2iGtf04cOQhzyUkd5shaVJH0ylOvBQXWRRnJRPf6
         /ejM159g83E97lmP3HhESZ/uHPs0TOQ8KoTslMnArr+/8a2PzIfeNr7J/lTvjVpSb7Rx
         arM3HK+RPRRE3uNvkrlzoVadGuTZUYlB73I4Mc3gE5kfGMsNrWCn3EMzVaips4j8HGsE
         Xv9ymmVMSP+VN+n5zasfkjbDri1ERK+DyIBjQEsuP1lbaIMMP56HZ1E4FEgzzHTM/h0g
         IWuA==
X-Gm-Message-State: AOJu0YwGN2TXleLaBayDvk7rrjYVRnZ+BhrosFiKCG51QOSsMylzgdqr
	9cPMGrcP9xcR/874I7RUtp1yTE30kSjR9MMvbuQ=
X-Google-Smtp-Source: AGHT+IHTHgQihU8zjXgymFKfgmgGeaQfEhe+6NHwV/94cbTF9YdBPBNA3ovbSWTB/W2CMo+0RO3wLg==
X-Received: by 2002:a17:902:d4cf:b0:1cc:1686:37ac with SMTP id o15-20020a170902d4cf00b001cc168637acmr4193957plg.55.1698426835118;
        Fri, 27 Oct 2023 10:13:55 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902eb5100b001cc25cfec58sm839204pli.226.2023.10.27.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 10:13:54 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:13:51 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Message-ID: <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>

On Fri, Oct 27, 2023 at 03:32:40PM +0200, Dragan Simic wrote:
> On 2023-10-27 00:46, Jacob Stopak wrote:
> > Take into account reviewer feedback by doing several things differently:
> > 
> >   * Rename this feature (for now) as "noob format mode" (or just "noob
> >     mode") instead of the original "--table" verbiage. As pointed out,
> >     this no longer ties the name of the setting to it's proposed
> >     implementation detail as a table. Noob mode is not necessarily the
> >     right name, just a placeholder for now. Unless people like it :D
> > 
> >   * Instead of manually having to invoke the -t, --table every time this
> >     format is to be used, set the config option "status.noob" to true.
> >     Although this is logically tied to the status command, there are
> > many
> >     commands that produce status output, (and this series adds more), so
> >     assume that if the user wants to see the status this way, that it
> >     should be enabled whenever the status info is displayed.
> 
> How would "status.noob" relate to and coexist with possible future
> configuration options named "<command>.verbose", which would be somewhat
> similar to the currently existing "commit.verbose" option?  IOW, perhaps it
> would be better to have per-command options "<command>.verbose = noob" or,
> even better, "<command>.verbose = extended", to make it all more
> future-proof and more granular.

Hmm, do there currently exist other <command>.verbose config settings
besides for commit? From what I can tell from "git help config", the
commit.verbose setting is the only one I see, and it just adds the diff
info into the editor if the user runs git commit without the -m flag, but
otherwise there seems to be no extra verbosity outputted.

I noticed that git add and git mv have "verbose" (-v, --verbose) cli flags
which just output the name of the file being added or renamed, and that
certain other commands like git branch has a verbose output which includes
the branch head commit hash and message in the output, so I guess this one
is actually kindof verbose in that it outputs more than the non-empty
default output.

So it seems like currently "verbose" is used for various things among the
command set, sometimes meaning "add something into the template if one is
used" or "add some tiny output to a command that has no default output"
(which still seems more "--shy" than "--verbose" :P) or "add some
additional output to a command that already has some sparse output".

Another thing is that commands like status have multiple flags that can be
used to specify the output format, such as --short, --long, --porcelain,
etc, but only --short seems to be configurable as a git config setting.
Is there a reason (besides backward compatibility I guess) that these
aren't rolled into a single thing like --format=<type>? This seems like
it would be the easiest way to future proof for new formats like
--format=verbose, --format=noob, --format=extended, etc.

From a noob's perspective though, does adding a config setting for each
command really make sense? I'm kindof envisioning this setting now as a
"mode" that is either enabled for all commands it affects or for none.
And it's highly unlikely a newish user would individually discover which
commands this "extended" format is available for, and run "git config
<command>.verbose = extended" for every one. I mean we could do that
in case there are folks who only want it for specific commands, but to
fulfill it's purpose I think there should definetely be some general way
to enable the setting for all commands that have it.
