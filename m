Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2091F453
	for <e@80x24.org>; Tue, 19 Feb 2019 16:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBSQYL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 11:24:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:32983 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfBSQYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 11:24:11 -0500
Received: by mail-it1-f195.google.com with SMTP id g137so3410084ita.0
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8ZZz/r/wiWL4bwk3RuD8HjxyTwcanHbPmltlKwo964=;
        b=Z2LrmEuLbofxGp6jZmz6FIdZdqm7z9NjTTVc+ii4kzLbuuKHweZICp4yelrxPSMFJb
         ZnyYJ+e9em+Lo7pWv/vdStr84SlMqKduoo0ZAsB7uEi9VJgBkwZiB9IVeGBBzNqGn9O1
         yfNiagtrPcYQ6fg3BXfUDh4y5wzDY/U4gMadWscAAxZBz+zh/MW/S9mveI/sRuPAm3tj
         /mlorDLfCJg+lNZyYTyScLaklnsDkTnUwVjkW0IjB7E6hMcvEzkRJ9t1uQK/z43vSyn2
         T62kkobicaZET7pMitRLvHLmiF7sV9+/vMvET7UYXtnh9zXdF7BGiSWyEKTEXFnwpa5B
         q5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8ZZz/r/wiWL4bwk3RuD8HjxyTwcanHbPmltlKwo964=;
        b=PmU95nWTbIvJx0Kqgx6BTKAG/5MpSFSeNuxfIBT0y/H8vUxtrfNG7Ru8p3zxc/wIO7
         oT7t91XYDWgdj+etQdcNzckVh/gFbt6oGo1lbtOtYrq3CXVuT3NiMydgb/XT8Ac2rTQu
         +AnGIcXO5AYuzQdgNyV92e6uX0cdySoZ5m63mTmlurL3E9BbKm0VM6Cnq/qeKe1VD5uw
         +LLah92b5G+1DzUkUX42yGZkGNlKtQU5aI1K3QFm5jfWxnkBs52REuU37toUC7LIijSp
         YOdK29XuHfBM6Qq2ULdqP3VoGpqFVMJZWZnVyRbnF2nDdmmwIiQ+CCHU/rb7faZ0oVOL
         G8ww==
X-Gm-Message-State: AHQUAua0bqjm09C/i8v/naUiWL6rOT3oR7aq1I1zmmerhZPWsSZLcXjZ
        VET9nXWcotG5upT8ja/WWqlEWSdx1wlG0vzwam3oIw==
X-Google-Smtp-Source: AHgI3IbGRjs75sj5wLw5wsac/CLuxd8M+wy0IfjKwwUHx87nchtJ+JRcDLuKWWVvsykcHRi5BxHP+T5gd7+NC4Jx0/8=
X-Received: by 2002:a24:8788:: with SMTP id f130mr2590443ite.90.1550593450106;
 Tue, 19 Feb 2019 08:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br> <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com> <20190218233541.GK6085@hank.intra.tgummerer.com>
In-Reply-To: <20190218233541.GK6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 19 Feb 2019 13:23:58 -0300
Message-ID: <CAHd-oW6m6JSgxwdE6U5vBw=DcPigK+P8eODoie0_Mag3Lg_eYw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 8:35 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> >
> > You are right. I didn't know the differences from lstat and stat. And
> > reflecting on this now, I realize that the problem is even deeper:
> > copy_or_link_directory follows symlinks but dir-iterator don't, so I
> > cannot use dir-iterator without falling back to recursion on
> > copy_or_link_directory. Because of that, I thought off adding an
> > option for dir-iterator to follow symlinks. Does this seem like a good
> > idea?
>
> Hmm looking at how this function is actually called, I don't think we
> need to worry about symlinks too much.  It only copies the
> .git/objects directory, which normally shouldn't contain any
> symlinks.  I think it's still good to preserve the warning, in case
> someone gave some object directories bad permissions, but following
> symlinks in there may be overly paranoid, dunno.
>
> Adding an option to dir-iterator to follow symlinks may be a good
> idea, but it raises a few questions I think, e.g. how are we going to
> deal with symlinks that point to a parent directory.  The answer for
> this function is that we currently don't and just keep recursing,
> until 'stat()' fails, but that is probably not the behaviour we'd want
> if we were to add this functionality to dir-iterator.
>
> At this point I'm almost convinced that not following symlinks may be
> the better solution here.  That is a change in behaviour though, and
> it should be described in the commit message why that change is a good
> change.
>

Ok, so I will add this note at v2's commit message.

> > Also, I just noticed that dir-iterator follows hidden paths while
> > copy_or_link_directory don't. Maybe another option to add for
> > dir-iterator?
>
> That feels like quite a special case in 'copy_or_link_directory()'.  I
> don't think it's worth adding a feature like that for now, at least
> not until we find another use case for it.  It's easy enough to skip
> over hidden directories here.
>

Ok, I agree. I noticed copy_or_link_directory only skips hidden
directories, not hidden files. And I couldn't think why we would want
to skip one but not the other... Could that be unintentional? I mean,
maybe the idea was to skip just "." and ".."? If that is the case, I
don't even need to make an if check at copy_or_link_directory, since
dir-iterator already skips "." and "..". What do you think about that?

> > > If there is a good reason to remove the warning, that would be useful
> > > to describe in the commit message.
> > >
> > > > -             if (S_ISDIR(buf.st_mode)) {
> > > > -                     if (de->d_name[0] != '.')
> > > > -                             copy_or_link_directory(src, dest,
> > > > -                                                    src_repo, src_baselen);
> > > > +             strbuf_addstr(dest, iter->relative_path);
> > > > +
> > > > +             if (S_ISDIR(iter->st.st_mode)) {
> > > > +                     if (iter->basename[0] != '.')
> > > > +                             mkdir_if_missing(dest->buf, 0777);
> > > >                       continue;
> > > >               }
> > > >
> > > >               /* Files that cannot be copied bit-for-bit... */
> > > > -             if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> > > > +             if (!strcmp(iter->relative_path, "info/alternates")) {
> > > >                       copy_alternates(src, dest, src_repo);
> > > >                       continue;
> > > >               }
> > > > @@ -463,7 +458,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > > >               if (copy_file_with_time(dest->buf, src->buf, 0666))
> > > >                       die_errno(_("failed to copy file to '%s'"), dest->buf);
> > > >       }
> > > > -     closedir(dir);
> > > > +
> > > > +     if (iter_status != ITER_DONE) {
> > > > +             strbuf_setlen(src, src_len);
> > > > +             die(_("failed to iterate over '%s'"), src->buf);
> > > > +     }
> > >
> > > Interestingly enough, this is not something that can currently
> > > happen if I read the dir-iterator code correctly.  Even though the
> > > dir_iterator_advance function says it can return ITER_ERROR, it never
> > > actually does.  The only way the iter_status can be not ITER_DONE at
> > > this point is if we would 'break' out of the loop.
> > >
> > > I don't think it hurts to be defensive here in case someone decides to
> > > break out of the loop in the future, just something odd I noticed
> > > while reviewing the code.
> > >
> >
> > Yes, I also noticed that. But I thought it would be nice to make this
> > check so that this code stays consistent to the documentation at
> > dir-iterator.h (although implementation is different).
>
> Yeah, I'm not opposed to keep this check to be more defensive against
> future changes of the API and the code here.
>
> > Something I just noticed now is that copy_or_link_directory dies upon
> > an opendir error, but dir-iterator just prints a warning and keeps
> > going (looking for another file/dir to return for the caller). Is this
> > ok? Or should I, perhaps, add a "pedantic" option to dir-iterator so
> > that, when enabled, it immediately returns ITER_ERROR when an error
> > occurs instead of keep going?
>
> Good point, I failed to notice that during my earlier review.  I do
> think a "pedantic" option would be a good idea here, to preserve the
> previous behaviour.
>

Ok, I'm going to work on that. Thanks.

> > I'm proposing some new options to dir-iterator because as the patch
> > that adds it says "There are obviously a lot of features that could
> > easily be added to this class", and maybe those would be useful for
> > other dir-iterator users. But I don't know if that would be the best
> > way of doing it, so any feedback on this will be much appreciated.
> > Also, I saw on public-inbox[1] a patchset from 2017 proposing new
> > features/options for dir-iterator, but I don't really know if (and
> > why) it was rejected. (I couldn't find the patches on master/pu log)
>
> I don't think we should necessarily add new options because the
> original patch said we should do so.  Instead the best way to
> introduce new options is to introduce them when they are actually
> going to be needed in subsequent patches.  So it would be nice to
> implement features that are actually needed by your patches, but I
> don't think it's worth trying to introduce new features that could
> potentially be useful in the future, but where we don't know yet
> whether they really will be or not.
>

Yes, I agree with you. What I meant is that there is some space for
new features at dir-iterator and maybe those that I suggested could be
nice not just for my patch, on clone.c, but for others. But I see your
point. We really should try to keep it simpler and just add the
feature when (and if) there is a more expressive usage for it.

Thanks again for all the help and feedback.
