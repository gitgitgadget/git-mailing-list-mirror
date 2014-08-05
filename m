From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Pluggable backends for refs,wip
Date: Tue, 5 Aug 2014 15:23:55 -0700
Message-ID: <CAL=YDWnYQJVTkCW0GYE6qOK9a+VBiO6ozUOPWkGNEr8H0-4a4w@mail.gmail.com>
References: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
	<CAK3OfOiu39H8oZMKjra97ZNLHNatNYtFwr8Do_QwoxGXzg4SGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:24:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEn9E-0004vC-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaHEWX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:23:57 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:53747 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaHEWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 18:23:56 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so2725893vcb.22
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 15:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mxm6cEZwOgCDT9pzmLDPf+sML+cTkfBuLUZt0o9lzlI=;
        b=aufvo1XR/MoD48pRUtq26EsK7dtMnU/mUh+3MQcUppuH65DajU4rorhv8LOA4yvgMR
         qmw/WYwWpOB6d+fHlZcrokM5uViJmlpaeVPu2skoRJwVrM3mgIrACpnf+pD1OnTXWPNd
         7ss/x+emsef8IF91fwAxRzHLca6dRT/zXTKIfYycTakuTW82lfZuhW52KkSI9fdWhZLY
         QtUmfaBA1Ea0O36eEvVnoedo3E7KPCulR405x0CGY0HPTtIkXaNsXaePsOJXUX9iqt0Y
         ggLGKd0ccDVknBdBl4LsfFgkSrZKhBGt0+hoDnY9CHDpPoWm8YCxrkX8mVUgEeNb97mb
         ep9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mxm6cEZwOgCDT9pzmLDPf+sML+cTkfBuLUZt0o9lzlI=;
        b=JDPYxucjmmArYgfNK+vtzWL5SU3g3ZFEwOqoyYgTqDH5aEWatgWbrjMKXfltvSg+ye
         EPv9Y/c7AYMW9MsqAULzZpKQsJ2sXEkqNCJuJrVxEcxdyN4BuB0ZlxUDzn6SLv+/BqJA
         36+eTjFCXxtzwuWVQSkCUeJVX96MP2xDOdVSwQRf2GObROtEhYMKUahWX1uaZonTHLNn
         UxcrN+EC8VygYeHVq82zgQJ1E6mTY+TKwiKTzbC17WPs+ltt9iUJO/YzaRuIV5TRUG6U
         8EZxn5RdfIIXvdBUS2F6SiGGF7nepvgO44jL3YaERw59/4/bA7wAWHsAIaSMilIAEY/k
         ihiA==
X-Gm-Message-State: ALoCoQmQFFuebDQByuwWujJ09Q7ZEBPg0xehkRIiLcPetnAH+/S6jQF8271G/DpD9NgShrR3m6nM
X-Received: by 10.52.38.67 with SMTP id e3mr6090349vdk.56.1407277435292; Tue,
 05 Aug 2014 15:23:55 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Tue, 5 Aug 2014 15:23:55 -0700 (PDT)
In-Reply-To: <CAK3OfOiu39H8oZMKjra97ZNLHNatNYtFwr8Do_QwoxGXzg4SGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254836>

On Tue, Aug 5, 2014 at 2:56 PM, Nico Williams <nico@cryptonector.com> wrote:
> Personally (a user of, not a maintainer of, git) I really want some
> alternative backends.  In particular I'm after something like Fossil's
> use of SQLite3; I want a SQLite3 backend for several reasons, not the
> least of which is the power of SQL for looking at history.
>
> I'm not sure that I necessarily want a daemon/background process.  I
> get the appeal (add inotify and bingo, very fast git status, always),
> but it seems likely to add obnoxious failure modes.
>
> As to a SQLite3-type backend, I am of two minds: either add it as a
> bolt-on to the builtin backend, or add it as a first-class backend
> that replaces the builtin one.  The former is nice because the SQLite3
> DB becomes more of a cache/index and query engine than a store, and
> can be used without migrating any repos, but the latter is also nice
> because SQLite3 provides strong ACID transactional semantics on local
> filesystems.


This will allow you to do either or both, depending on what you want.

I am adding one new first-class backend to talk to a separate daemon :
  refs-be-db.c
which then talks to a separate daemon   refsd-tdb.c

refsd-tdb.c is 7 RPCs and ~500 lines of code for a naive
implementation for a standalone separate daemon implementation.


If you rather want want a new first-class backend builtin to git
itself instead of as a separate daemon, then that will be possible
too.
It just means that you will have to base the work on refs-be-db.c
which is a much larger and complex code base than refsd-tdb.c.

But yeah, once this work is finished, you will be able to build new
first-class ref backends if you so wish.
Please see refs-be-db.c  that is the file and the methods you will
need to implement in order to have a first-class SQL* backend.


regards
ronnie sahlberg
