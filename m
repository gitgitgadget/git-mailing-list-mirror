From: Stefan Beller <sbeller@google.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 14:45:07 -0700
Message-ID: <CAGZ79kY_C9wSS+z7XwPEWiM+8vhYuZzs_SPZ0mQR=LB+MPzTJg@mail.gmail.com>
References: <nemal5$mb$1@ger.gmane.org>
	<CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
	<xmqqk2k1jita.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Kelly <steveire@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSb6-00056C-3v
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbcDMVpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:45:10 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33828 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbcDMVpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:45:08 -0400
Received: by mail-io0-f170.google.com with SMTP id 2so85670294ioy.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 14:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UPm3iZkuth3ZcxgoQ42o1XSPW2B3DMHyP6VORnSic+s=;
        b=oQW+GhBEEbBI1rQaKlLOlWVETkiYAaVI5vz+ZI6+lx0zAn/3HVhIXEppqz1pOQKJee
         O4MdWisjDCn/j5KG2+/AzFlmg6mrDZ1qDTnGvBkeE8awb6pC8bEu5lsarHHBdmZHKAAK
         pdXv0f9iAMixH7gna3sAj41PwZw/lkTNDNPLbDuwxXf03Jf/jN0Tc22eIOCTGEiNWmh7
         6psPBK6/r27krVWp6V5G3JOjOI6PONkBeJUUD8BmeUZ68tiSF6jzXjvd1eGGUkMEuDFI
         WN3CM3JiS5+bQOMMerfWrEzADflCWiW0QoaFHIzCottTu/HDcU/Cz4Vyi2cPyHiyKt9m
         WSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UPm3iZkuth3ZcxgoQ42o1XSPW2B3DMHyP6VORnSic+s=;
        b=G53/Ng7K/sTibWyIOrOgE61NfP3zHQc1yL2TGvpnlrBbrIn1eqyydLUeLbZqCXsHqo
         O3jJdIQf1dHCMV7plE59uEdSkHe/N6VvckAyiORlLL20jNIshhgwYQmAyLuyv6yIbAXm
         QWbutsz4K2Pvhw8625r0n8SpWF1vgBQxN8TbmRF/ydj6rCG8ZMKc2WkFqyz+mF9zcTNf
         5e0mFymOHXm+68JI8Wq4jAjpeJ0Ta4qi+XTRAQoPxvf2h7GEpo+jEDQtLJwLFN3RK52p
         nn4vHDOK0Bi4RKKdsMjQVp9FCjhAl9tRLFQBIBK2Us7YW5qT6mb+Q9bLn36qis4eSzrX
         1DGQ==
X-Gm-Message-State: AOPr4FVIshA5rX14VUqbIWLhFmUvs1roOJZpZ7Z7ENmTPTxtJrgs4qNDfTWI+QsL/ipnWioHbA+UtB8Qj36eU/K3
X-Received: by 10.107.184.8 with SMTP id i8mr12555221iof.96.1460583907734;
 Wed, 13 Apr 2016 14:45:07 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 14:45:07 -0700 (PDT)
In-Reply-To: <xmqqk2k1jita.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291490>

On Wed, Apr 13, 2016 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> How would you know(/code) that v1.6.0-rc0~120^2 is a text worth linking?
>> "v1.6.0-rc0" is a custom string as that is how we name tags in this project.
>> It can follow any convention in other projects.
>>
>> Maybe a first approximation is if there is a `~` followed by numbers
>> or a ^ character, inspect the whole thing if it is a reference into the history?
>
> You (as a gitk process running in a repository) know what tags are
> in your repository, so you can find the above pattern and see if the
> prefix matches any of the known tag.  That way, you do not have to
> worry about having to special case HEAD etc.

Sorry for shooting from the hip here[1], that thought was

But it should not be just tags?

We also want to have 4b9ab0ee0130~1^2 to work `right`, in the sense
that not just the hexadecimals are highlighted and linking to 4b9ab0ee0130,
but the whole expression should link to 49e863b02ae177.

[1] My thinking was just like in https://xkcd.com/761/

Stephen Kelly:
> Would it be possible to implement linking for <tagname> optionally followed
> by something like that? Just tags should be links too, right?

right, just tags should work I'd expect.

> What does 'HEAD^' mean? If it is 'the commit before this one', then why not
> link it?

As said I was thinking about the git development, so see 5f3c3a4e6f11deda
for an example:

    files_log_ref_write: new function

    Because HEAD and stash are per-worktree, every refs backend needs to
    go through the files backend to write these refs.

    So create a new function, files_log_ref_write, and add it to
    refs/refs-internal.h. Later, we will use this to handle reflog updates
    for per-worktree symbolic refs (HEAD).

I do not think we would want to link HEAD to anything in that example.
(I'd have no idea what it would link to here, so just not link it?)

Thanks,
Stefan
