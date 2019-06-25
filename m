Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7C61F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFYNuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:50:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33471 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfFYNuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:50:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so27321636edq.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Rafg6rcCwyS+wOqm2pcWLwU3AOqJcYj+t04xEzjUQg=;
        b=ErI+J4bpyNLGhTaZMx/hq4vR9c53M9dmrcJI8AzU+Z+txw+WFfyhnA8lUl+hCDeo2z
         D0MGP9FHaKo18gG0vvwed9eE3znKhpTZ8NlOb4GosPCURZZ+9H+gw3pe3s4ZysHjuNtK
         yjNO3KtZRaclhO/2YeVJi6dWI3X0qvnYtnC0CWKIlJIUBZm+Twkx+Vpp2HAot1y8tl0Y
         5amlTiyexBGtiNbT+Y3A79FnAtxmK0uzqajpYfCFWlM7QeR1Q2QVjMGxph2iSnV6Hfac
         +MXNmBNkqr2JCZBHDotAo8KtHTCkJWpRA55M649quz0KVpAev/QxAA9oVkkKUc7CQKCp
         /dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Rafg6rcCwyS+wOqm2pcWLwU3AOqJcYj+t04xEzjUQg=;
        b=PBSuU5SZL2fivpyHzT+WxcyV4Ihepr6/nDeHFPSE84FAdKb1lTsB58a/rRmIvMm27H
         7+R1BLY/Z5/mMZaigSAi3OxpK1kQzDK7fs8mULK8JOVd/P3ZmF6tX3uXKf9B+C+jJU8J
         qqSIUI8hDL8f4+1in3Le7VsEoxqsCQA3CKIsnjmaH8fo0hmqk2/m1iHcOpfMvE0DK2D1
         zB4a/hWamkLtH8laMWah1PV4IYlI9m5MvflbwxZoRAuE5pHWkfhiOklymt+rzufoJkrH
         DTwicYSu47d/k8E7gzsZsFCeRPeG4Zw0wvLiG1i+3iRcsLK7sqqm5ds5GF/rtyuBwewv
         4mOA==
X-Gm-Message-State: APjAAAVoSEIK+Q5aj/Tj7JW8pOAGwkWj4pF+hxjidXHY9nphsP6QwT3K
        RcBoqO10jRXajqpWbV+/TEtJHHehiappJKrkCVI=
X-Google-Smtp-Source: APXvYqwfdpniH1Uhb5O7TMu+14Vypo3ZFDSXa03k91a+YhsZgo3gw8hI5MoShd1T9+ddzs0tr6Xio9lsde6HqVlisQw=
X-Received: by 2002:a17:906:4808:: with SMTP id w8mr10595398ejq.53.1561470632541;
 Tue, 25 Jun 2019 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
 <20190409161116.30256-5-chriscool@tuxfamily.org> <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
 <CAP8UFD0zvqC2s3_RsWfKwoWQL=2iV6PbaL8+hwUXrWBVe+6sgA@mail.gmail.com>
In-Reply-To: <CAP8UFD0zvqC2s3_RsWfKwoWQL=2iV6PbaL8+hwUXrWBVe+6sgA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Jun 2019 15:50:21 +0200
Message-ID: <CAP8UFD2-BUVsaVcO-pRNY+qc8WBZC=NUOQHnNYbBVKc=q_aOSg@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] promisor-remote: implement promisor_remote_get_direct()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 7:10 AM Christian Couder
<christian.couder@gmail.com> wrote:

> On Thu, May 30, 2019 at 7:21 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 4/9/2019 12:11 PM, Christian Couder wrote:

> > > +{
> > > +     int i, missing_nr = 0;
> > > +     int *missing = xcalloc(oid_nr, sizeof(*missing));
> > > +     struct object_id *old_oids = *oids;
> > > +     struct object_id *new_oids;
> > > +     int old_fetch_if_missing = fetch_if_missing;
> > > +
> > > +     fetch_if_missing = 0;
> >
> > This global 'fetch_if_missing' swap seems very fragile. I'm guessing you are using
> > it to prevent a loop when calling oid_object_info_extended() below. Can you instead
> > pass a flag to the method that disables the fetch_if_missing behavior?
>
> If such a flag existed when I wrote the function I would certainly
> have used it, as I also dislike this kind of messing with a global
> (and globals in general).
>
> I will see if I can do something about it according to what you
> suggest later in this thread.

In the V6 patch series I just sent, the new
OBJECT_INFO_SKIP_FETCH_OBJECT flag that you introduced is used.

> > > +     for (i = 0; i < oid_nr; i++)
> > > +             if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
> >
> > A use of "the_repository" this deep in new code is asking for a refactor later to remove it.
> > Please try to pass a "struct repository *r" through your methods so we minimize references
> > to the_repository (and the amount of work required to remove them later).
>
> Ok, I will take a look at that.

A "struct repository *r" is passed in V6. I forgot to mention that in
the cover letter.

> > > +                     missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
> >
> > Here is the one call, and after this assignment "missing_nr" does mean the number of missing objects.
> > However, I do think this could be clarified by using remaining_nr and remaining_oids.
>
> Ok, I will take a look at using "remaining_nr" and "remaining_oids".

Done in V6 too.

> > > +                     if (missing_nr) {
> > > +                             to_free = 1;
> > > +                             continue;
> > > +                     }
> >
> > Now this block took a bit to grok. You use to_free in the if(to_free) free(missing_oids); below.
> > But it also changes the behavior of remove_fetched_oids(). This means that the first time
> > remove_fetched_oids() will preserve the list (because it is the input list) but all later
> > calls will free the newly-created intermediate list. This checks out.
> >
> > What is confusing to me: is there any reason that missing_nr would be zero in this situation?
>
> I don't think so but I will check again, and maybe add a comment.

Actually missing_nr, or now remaining_nr, would be 0 if all the
promised objects have been fetched.

> > > +             }
> > > +             res = 0;
> > > +             break;
> > > +     }
> > > +
> > > +     if (to_free)
> > > +             free(missing_oids);
> > > +
> > > +     return res;
> > > +}
> >
> > While the test coverage report brought this patch to my attention, it does seem correct.
> > I still think a test exposing this method would be good, especially one that requires
> > a fetch_objects() call to multiple remotes to really exercise the details of remove_fetched_oids().
>
> Yeah, I would like to actually test it. I will take another look at
> what can be done to test this. Perhaps I will look at what can be done
> to still get some objects when fetching from a promisor/partial clone
> remote even when it doesn't have all of the objects we request.

I haven't improved test coverage or looked at how we could better
handle a partial fetch. I plan to look at that soon.

Thanks,
Christian.
