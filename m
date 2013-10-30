From: Vicent Marti <vicent@github.com>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Wed, 30 Oct 2013 17:11:45 +0100
Message-ID: <CAFFjANSjFRwRYep_itVBAHuR2jYm=nspRWcUY02zXsEK=V5Reg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com>
 <20131025032144.GB26283@sigill.intra.peff.net> <CAJo=hJvmL0=MN7W-NW4bACK0m+Y39+LBVZ+ufXTEh8KzyjFbKg@mail.gmail.com>
 <20131030075040.GJ11317@sigill.intra.peff.net> <CAJo=hJvOb=oooJ3O0wjxt77caGOMeKwT0VRaV=znMAzm0yNCYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Colby Ranger <cranger@google.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYNT-0008T9-4m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab3J3QMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:12:08 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:55949 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab3J3QMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:12:06 -0400
Received: by mail-ve0-f181.google.com with SMTP id jz11so1153684veb.12
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3ESDqQiKh0JWXn3ro31b0ElrrTlncIDIArPSvXIrjBE=;
        b=ZKtdNvxns2L00iwXNmeoMVv8DIO3ag1fEADSMdlvMGW0vW2ltYIpmCBqcb2tGZ3Q3h
         AVgfHqlt7nfQ8Zca/YzU2ff9Lx+W/MrPugleMxVAYW2MHdF/eSRKnqw3VHXCpPtvFeLU
         adtOn4ZOjAkmXZazteSQmTYAqDHJYrslzQnuDlyWTDIINx63+oO9L8p+JGbP9xung1Gt
         KzuIkvcpnGgBS0fArjdWeJ2o6RCyeDTdt8faVoIteuOFEjLMlx+F8SzpRH5st3JA4uOQ
         FTIEJyF+gnjceMPsYD0is9bU+VCcqltWU+MrSsmZU98NwPtopACKLhIGTSSLSsGdpgZL
         9m7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3ESDqQiKh0JWXn3ro31b0ElrrTlncIDIArPSvXIrjBE=;
        b=EedyiS9lwk9cQWxRYWWYz2zyZgYLzZ1oeu3S2y2xEaNCKxTaM02jyfOZqPlaAZssRk
         aZ5UPLxXjXNuCOZ5N8BCKvejCaZyJh+f1uEFbxenRAUSNkR2kbvKTeuu+6F9dEU2yymp
         J4BietJxRbioC7Mmzsc9KCf4DKfOOt372aCSc=
X-Received: by 10.52.230.35 with SMTP id sv3mr3035056vdc.27.1383149525262;
 Wed, 30 Oct 2013 09:12:05 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Wed, 30 Oct 2013 09:11:45 -0700 (PDT)
In-Reply-To: <CAJo=hJvOb=oooJ3O0wjxt77caGOMeKwT0VRaV=znMAzm0yNCYw@mail.gmail.com>
X-Google-Sender-Auth: HJeRq6ZtJT5LPiKF3yCh2q_splA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237031>

On Wed, Oct 30, 2013 at 11:23 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Wed, Oct 30, 2013 at 7:50 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Oct 25, 2013 at 01:47:06PM +0000, Shawn O. Pearce wrote:
>>
>>> I think Colby and I talked about having additional optional sections
>>> in this file, but Colby didn't want to overcomplicate the format early
>>> on. So v1 is probably not very extensible and we may have to go to v2
>>> to safely create an extension with the name hash cache used in this
>>> series.
>>>
>>> Given that the JGit v1 bitmap format has been shipping since JGit 3.0
>>> and in Gerrit Code Review 2.6, its in use in the wild. So we aren't
>>> going to go back and redefine v1.
>>
>> I don't think either course of action affects how JGit in the wild will
>> react. If we add a new flag to v1, existing JGit barfs. If we move to
>> v2, existing JGit barfs.  In either case, the simplest fix for JGit is
>> to ignore the new section.
>
> Fair point. Then we can use v1 with the flag for now, JGit will barf and...

Shawn, I'm proposing the following patch to JGit (actually Kevin is,
because I don't have the CLA, but whatevs):

https://git.eclipse.org/r/#/c/17894/

It's a very small change (using an "and" to check for the flags on the
bitmap instead of a switch), but I think it's very clean. In the
spirit of "Be conservative in what you send, be liberal in what you
accept", this patch lets JGit read V1 bitmaps emited from git.git
*even* if they have the extended Name Cache extension, and has no
effect on any JGit bitmap that has been generated up to date, or any
JGit bitmap generated from git.git without name caches.

I don't think it *changes* the semantics of the bitmap V1 format,
because with only one bit value set so far, those semantics weren't
really there, and it'll allow newer versions of JGit to never barf.

Love,
vmg
