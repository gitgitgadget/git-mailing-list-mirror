From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Experimental TDB support for GIT REFS
Date: Wed, 2 Jul 2014 15:34:08 -0700
Message-ID: <CAL=YDWmBqOvRyPk3=LKCM_k2=2XRW8zUwZJv-GzBLPo9w_BYfw@mail.gmail.com>
References: <CAL=YDWn-CGZGr5bXNTiZmzr4-w_8CERx3r2bmLWbczqJ0Sn7dg@mail.gmail.com>
	<CAJo=hJu3QD09JccSvUrpnNSpFE5ppDHEzozkKyZZAyutvCQTGg@mail.gmail.com>
	<CAL=YDW=pHB4sjpxjYvO_w=RadK4Rhq6Zp+pc+NAqWT3hWjkWXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2T6V-0003LN-31
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbaGBWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:34:11 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:63673 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbaGBWeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:34:10 -0400
Received: by mail-ve0-f178.google.com with SMTP id oy12so12045646veb.23
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7qG6zFlhafmH3SL0wttglzyJXkubu/HJe7tYhaJuOyc=;
        b=hIzWGNkBMzL9E4Ahgf9oGv4k9LVa+XFPzJgNgkjbBKzvgO2iKwYFK4Y1ZsvY7NnPtp
         ePFIOopNiUGm6eUijBOL3nhCccAeljuBj5sXtaHsWAo4Qwfmf0/RVsYAW9gfaezJ3xgC
         hGJtO+fr5wGRZEdnk6grsy+ujWdx8vYXjq99NSkIsLzOthSuKBWfe7wUcUfUwTLiuypS
         gPupt3x/v2t4uUPcBm0hDrpnBivzjM5OSMjv9K+zlvrY1Y0dMkY4tdRUnmmKXsy2MsqA
         3wEchqTrS+IVRh5Md7LdiI+uKjThggSi/NskIwnCrz3sMcVXirHBd/aewaM0+Xp+lUE0
         Igyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7qG6zFlhafmH3SL0wttglzyJXkubu/HJe7tYhaJuOyc=;
        b=SJsTSih8l9pydGQMTRgn7W5UXhfPalBMrjsiD0H3ufsTJlbdy6ExYYaSBvnOw39S9C
         DVMbCwl3cAK/9JKQBDL+AmUE333f5CjFv10IGeSKF0VRsAtW+Erv0JZydtPHwKSksJln
         x4LUMax1nconEe4UGLC6ntmHezez95BtIrKe0/ilpl4a1Fg76bev6lx+xw5jqoMitU7T
         fhHRRm5SVT8da7a4qx1fyeSGLL/x8FkSdI4xQCNs8H8INHd/TPlixd/txnRkxS4eGtb2
         ztFDXfpCotXCfI2nU1mMiRHp3OqfQqsbu/n/2sZ1pAa+OZgk28VJgYQc/nZl3Q8vJCuq
         dohQ==
X-Gm-Message-State: ALoCoQnz8TMJucyvpMU1FKKIKtxkigsPsNwsd1pz2bFYiifVQB4E0MBiblC/5gdBbNDL8vjjs+wQ
X-Received: by 10.221.4.66 with SMTP id ob2mr441698vcb.28.1404340448970; Wed,
 02 Jul 2014 15:34:08 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 2 Jul 2014 15:34:08 -0700 (PDT)
In-Reply-To: <CAL=YDW=pHB4sjpxjYvO_w=RadK4Rhq6Zp+pc+NAqWT3hWjkWXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252850>

On Wed, Jul 2, 2014 at 10:11 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Fri, Jun 27, 2014 at 5:37 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Fri, Jun 27, 2014 at 2:30 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>>> List,
>>>
>>> One of my ref transaction aims is to make define a stable public API
>>> for accessing refs.
>>> Once this is done I want to make it possible to replace the current
>>> .git/refs/* model with a
>>> different type of backend.
>>> In my case I want to add support to store all refs and reflogs in a TDB database
>>> but once we have a pluggable backend framework for refs, if someone
>>> wants to store the refs
>>> in a SQL database, that should be fairly trivial too.
>>>
>>> There are a few series queued before this becomes possible, but is
>>> anyone wants to test or play with my "git can use TDB database" you
>>> can find an implementation of this at
>>>
>>> https://github.com/rsahlberg/git/tree/backend-struct-tdb
>>
>> Interesting! But the link 404s :(
>
>
> Yeah, sorry but there were issues :-(   Issues solved now though and
> refactoring done.
>
> Please see
> https://github.com/rsahlberg/git/tree/backend-struct-db
>
> This branch adds a refs backend that communicates via a domain socket
> to a refs daemon.
> The refs daemon in turn interfaces with the actual database.
>
> My branch contains one hack refs daemon that uses a TDB database for
> the refs storage.
> This daemon is only about 600 lines of code, most of which is
> marshalling and socket handling and only a small amount of
> TDB specific code.
> This small daemon should make it easy for folks to add arbitrary
> database interfaces easily.
> Taking refsd-tdb.c  and modifying it to instead attach to a SQL
> database should only take a few hundred lines of changes or so.
>
>
> To build the daemon and start it :
>
> $ gcc refsd-tdb.c -o refsd-tdb -ltdb
> <create /var/lib/git and /var/log/git>
> $ ./refsd-tdb /var/lib/git/refs.socket /var/lib/git /var/log/git/refsd.log
>
> Then you can inspect the database with
> tdbdump /var/lib/git/refs.tdb
>
>
> You can then create a repository that uses this database :
> $ git init --db-repo-name=ROCC --db-socket=/var/lib/git/refs.socket .
>
> Then further commands will operate on the refs tdb.
>
> See this as a prototype to experiment with and see the direction of
> the refs transaction and pluggable backend support.
> There is a lot additional work and cleanup that needs to be done
> before this will become production code.
>
> (yes I know we should not do hand marshalling and unmarshalling for
> the PDUs on the domain socket. We should use some lightweight encoding
> library like XDR and rpcgen or similar.)
>
>
> Please test, comment and have fun.

One enhancement to this could be to make it easier to use for trivial
users that do not want to share one database across multiple repos.

We could have something like
$ git init --db=tdb .

core.db=tdb could then mean that instead of connecting to a domain
socket for a shared daemon instead it would just
popen("refsd-<core.db> ...", "rw")
and automaticallt set the asguments ro refsd-tdb to point to the local
.git directory.

This would make the setup simpler for the trivial usecase since it
would avoid having to manuallt initializing a dedicated daemon before
the git commands will start working.
