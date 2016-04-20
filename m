From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 06/15] index-helper: add --detach
Date: Wed, 20 Apr 2016 16:33:16 +0700
Message-ID: <CACsJy8DbA6Es3-Kb5XXad0+6Mm2VkMtbNCo6rmEio_180L-G0w@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
 <1461108489-29376-7-git-send-email-dturner@twopensource.com>
 <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com> <1461114267.5540.161.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 11:34:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asoWF-0005ht-RI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 11:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbcDTJdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 05:33:50 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33920 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125AbcDTJdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 05:33:47 -0400
Received: by mail-lf0-f48.google.com with SMTP id j11so37250185lfb.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KHcBphNGGfLzjZTywSon3CH7I3VbKvngcmLTeb+NfAA=;
        b=O656/Awujs7ud2gg/mva/tgqotad6xvcHoLDW/jTexdSPJILZD8zLxnPSOwiUTVxZX
         xsEeLO9frAZXG8AJlrWqTH0c2uckCn6nczDaDzg+CD5AM6n9DizFIEr7XcqS51sy7x9T
         uZt/DRAcweIAMZQQoKcd2x1ofy+z7wUPRDENID6WthIxPuA4xMoh0MzIsXYYGFmGJs1G
         XChDsa++jvDKJbV2yXrFo1bxW8HY9nGHHWw8x1Tv1g35/E6Dbz+1BuClNvAXz/yqFcEr
         8fD6ZtnGvf266nW6GU0XxHfvvoWocAaTfFfVyNFU+OLqEZM+MqR8KgHNluJwbtBOSoFG
         V94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KHcBphNGGfLzjZTywSon3CH7I3VbKvngcmLTeb+NfAA=;
        b=SLduSnVqY2igKCdMpLw3uCnHpJJ+CPvmJpd3aChV0cdXH4Xjgs/RDeN0FSDSyXP7V9
         qVB6Nl4QPK3gDVfBeste6wP8BBIHS5JJNO9o1sWTS01afI07ssjOudLSiyuA4Z31+Kbq
         18w4ViJDUUvVmiE99mA1XjJqsRfJP8KdC4eq7ucVdKl7PsYCgdX76I0dk79JW6tcTRoq
         1dO6uLi58C6B928UVJaIPDJnvU1uaozq6Dy/ZpNHBa+iHiHMu+xYakV7vVbt5AA0f+dL
         ZAhQONUl8McsVHODBKT/adMpT6PBkfqPA5+Hqv0AUbzZLHIBaulpALUBU9QDMxwJL7t9
         s3fw==
X-Gm-Message-State: AOPr4FVmwZyykkPDxyWF86v+hOKxI3J+xhM/XVNmq+FrsIF/FYrDyttMxkeQQtgV59nMq1PsihVZZdQbLBylhQ==
X-Received: by 10.25.22.19 with SMTP id m19mr3268427lfi.118.1461144826041;
 Wed, 20 Apr 2016 02:33:46 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 02:33:16 -0700 (PDT)
In-Reply-To: <1461114267.5540.161.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291999>

On Wed, Apr 20, 2016 at 8:04 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-04-20 at 06:50 +0700, Duy Nguyen wrote:
>> On Wed, Apr 20, 2016 at 6:28 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > @@ -317,6 +320,8 @@ int main(int argc, char **argv)
>> >         if (fd < 0)
>> >                 die_errno(_("could not set up index-helper
>> > socket"));
>> >
>> > +       if (detach && daemonize(&daemonized))
>> > +               die_errno(_("unable to detach"));
>>
>> At the least, I think we need to redirect both stdout and stderr to a
>> file, so we can catch errors. The watchman patch uses warning() to
>> report errors, for example. And there is always a chance of die().
>>
>> Then we need to report the errors back. I faced the same problem with
>> daemonizing git-gc, but I'm not sure if we can do exactly the same
>> here like in commit 329e6e8 (gc: save log from daemonized gc --auto
>> and print it next time - 2015-09-19)
>
> I'll add in code to log errors.  I'm not sure where it would make sense
> to report the errors.  Generally, for errors during a client operation,
> we would like to report them to the client, but the client might have
> already disconnected.  I guess in that case it's OK if they just go to
> the log?  The client could warn on a timeout while waiting for index
> -helper and direct people to the log.

Yeah if the client already disconnects, we have no way but saving the
errors somewhere. index-helper can pick up from the log and report to
the next client, if you want to keep it simple. If we're building a
more complicated protocol on top of unix socket, I suggest you use
pkt-line to wrap/unwrap messages. Bonus point, we can trace what's
sending/receiving with GIT_TRACE_PACKET.
-- 
Duy
