Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDED21F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfAaUoD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:44:03 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:43527 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfAaUnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:55 -0500
Received: by mail-vs1-f44.google.com with SMTP id x1so2804655vsc.10
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AS4AiWFLBKznBq/jHK73rlzMhU42wYa6XUTDhHg+PM=;
        b=p62zujlpo4rljMp37qC1ttGqEN0Fs1aQT+qOBN3Y2nijcbEFI3IP3LphkTh7X3VpGd
         YBtMnYkn1rfwLMLtEark2pDm6RT28KjnNr/UNHnKxwsiNwRZJvf/sxwU8xc+NPW+yg11
         EVRoYG6r/3TJJs/B4Vdc5zFQx9urxeiOll+Hec2M8PQwSTvbbe11r0lvfGU+z/ocwnik
         hk+cSf4AQBUC91cWR/uDmgigL31z9WuMW4eOfZy4BRHwqtHKdjjarCwNhtRP/5kTyn2y
         L8EgQ5JvargpcNaMeIX/sdR2XDDa4LTAd6DlcyK6/+AGMSNqhSlXWFRkv7eezA1G3Ptl
         K1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AS4AiWFLBKznBq/jHK73rlzMhU42wYa6XUTDhHg+PM=;
        b=LxNwuBkC/pflfxK5G6ETJ7wNzXhLiABufLZ9Jef3OAoPWVBaG5KBMy6I+4yzOn92ll
         f4/3nVXC4bTqmcLvtZGgWHTDTZ0NqJhfChwRZsx6K2I6jDGseh96aneFId4OhjFObamF
         ZZo0FTFHjAKqQOnBGpvvMUP7upV2f+iEaBm9dnz8VUJa8XFWUsE6pB0C2oTqWrUalMyA
         RDB5RIAyIY6AmeAe6eyjLzU6XjEVM0KZFJvnRMPXMkOREjRia4f9wVdLwHtpAuKbdhUc
         yF5zQFLMlOyNwqqrN7dygjSFRlzCGCCKH4qBaI8QzgRfKw+lJujGR7sEsK37kSE7LH9G
         +wdA==
X-Gm-Message-State: AJcUukequN+hiTH5SuT7F0ot4rppAbpKxhzyaazPFuxRiNgHaB+9vAtA
        HPW72WQpBW54MAuwI05TxndCiX4Va4tXF0hkD7M=
X-Google-Smtp-Source: ALg8bN6xGSqjGpkMvSHiJoqD6ON0Y5oqT5ThLN8PF/9oUB9wc/LX0osQ+7fIFnB+XgdP3LKvJgEuzeyBOHpXAGabvOY=
X-Received: by 2002:a67:f696:: with SMTP id n22mr16384973vso.175.1548967433609;
 Thu, 31 Jan 2019 12:43:53 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
 <xmqq36p83aq4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36p83aq4.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 31 Jan 2019 21:43:42 +0100
Message-ID: <CABPp-BH==w5APkz9cvUYq7m4qieJ3LWCsYySevgJuZ8bi2RzjQ@mail.gmail.com>
Subject: Re: New command/tool: git filter-repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > git-filter-repo[1], a filter-branch-like tool for rewriting repository
> > history, is ready for more widespread testing and feedback.  The rough
> > edges I previously mentioned have been fixed, and it has several useful
> > features already, though more development work is ongoing (docs are a
> > bit sparse right now, though -h provides some help).
> >
> > Why filter-repo vs. filter-branch?
>
> How does it compare with bfg-repo-cleaner?  Somehow I was led to
> believe that all serious users of filter-branch like functionality
> are using bfg-repo-cleaner instead.

No, bfg-repo-cleaner only covers an important subset of the usecases.
bfg-repo-cleaner does a really good job if your goal is to remove a
few big files and/or to remove some sensitive text (matched via
regexes) from all blobs.  It was designed for that specific role and
has more options in this area than filter-repo currently has.  But
even within this design space it was optimized for, it is missing two
things that I really want:

  * pruning of commits which become empty due to filtering
  * providing a way for the user to know what needs to be cleaned up.
It has options like --strip-blobs-bigger-than <size> or
--strip-biggest-blobs <NUM>, but no way for the user to figure out
what <size> or <NUM> should be.  Also, since it just focuses on really
big blobs, it misses cases like someone checking in directories with a
huge number of small-to-moderately sized files (e.g. bower_components/
or node_modules/, though these could also contain a few big blobs
too), or someone checking in a lot of moderately sized files of a
uniform extension (e.g. .webm, .tar.gz, .zip, .mp4, .avi).  I've seen
cases in the wild where the correct cleaning of history was more about
filtering out directories or extensions than a couple big files.
filter-repo's --analyze option creates some reports that help with
this tremendously.  Also, the options to delete files by glob/basename
overlook the fact that renames may have occurred.  Having a report
that mentions renames that have occurred in history (also part of
filter-repo's --analyze option) can be very helpful.

Outside of this specific usecase, bfg-repo-cleaner is not very useful.
It simply lacks more general filtering capabilties:

  * While bfg-repo-cleaner has facilities to remove certain paths, it
has none to say you only want to keep certain paths.  Unlike
filter-branch where you can use a pipeline to list all files, grep to
remove the ones you want to keep from the list, then pipe the
remainder of paths to xargs git rm, bfg-repo-cleaner doesn't have a
facility for shell commands.  Instead in bfg-repo-cleaner you would
need to emulate this by exhaustively listing directories and
paths/globs of file basenames to delete, but that assumes the user
knows all paths that have ever existed making this solution not only
onerous but error prone.  More of the filterings I see these days are
about just keeping a directory (or perhaps a handful of them) rather
than just removing or cleaning a few files.  Also, this makes pruning
of commits which become empty much more important, but as noted above,
bfg-repo-cleaner lacks that ability.
  * It has no facilities for renaming paths.  You'd have to use a
different tool to do that, but then why not use the other tool to do
the whole job?  Even if you do decide to use both tools, some
capabilities of one tool can be neutered by such an approach (e.g.
bfg-repo-cleaner's carefully rewritten commit messages that tried to
ensure abbreviated commit shas referred to the new commit ids)
  * It has no facilities for affecting other parts of history, such as
changing author/committer/tagger names or emails, changing commit
timestamp or timezone, reparenting commits, splicing repository
histories together, filtering files differently based on commit
timestamp, etc. -- all of which can be done with filter-repo (though
some of those things requires writing a small python script; see basic
examples in t/lib-usage/*)

Personally, I also find it kind of annoying that bfg-repo-cleaner
doesn't automatically repack and shrink the repo when it is done and
instead prints multiple commands the user can run to achieve that,
even though it's the core use case for the tool.  Granted, they may
have had last-ditch recovery-of-the-original-repo in mind in case the
user ran in a repository they shouldn't have, but I much prefer to
have the tool just check if the repo looks like a fresh clone and bail
if not, so that users have a far easier recovery mechanism -- just
throw away the clone you were filtering and re-clone.  Once you do
that, auto repacking and shrinking is pretty natural.  (And you can
always provide a --force option to allow filtering & rewriting in a
repo that isn't a fresh clone.)


Elijah
