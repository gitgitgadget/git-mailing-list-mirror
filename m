Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA702021E
	for <e@80x24.org>; Sat, 12 Nov 2016 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966814AbcKLUB4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 15:01:56 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36586 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966752AbcKLUB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 15:01:56 -0500
Received: by mail-yw0-f193.google.com with SMTP id r204so3358482ywb.3
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1FhBsdQgBhnFGkmMHsBAunx6qPZBrK3OG7cisDT+Pj0=;
        b=jPEccq6rkB9OotvFKyAEmZN0/j/nUsPgJYOHrLOAOnYPgN8qg9s3meZrme8ikOa6Ka
         OCzUlv8vxyN43WakPnZLWv59Poa1LA1Pk7vEIxAkmIk608UDLJ+HIhNstab3XcVDLYLC
         HsDDblf1rG2toGdm2h0jXmBLaHYK/YQL4JlteLpTBlpX7dzMff2dtK/GH4Xx6U5HmVr8
         gcHkcsM7f2XL5UXsinHuTUWs1AuTp5IOHZxP7+nss56wdFkkHnc4jKjQLWHCawX4+1q5
         NqHkI//1jpZO0jVqH/kyDyJNkkxEiUd/ehPyuAwhU1iADofBhM4z/rzoWZWiq1dhdXm1
         SAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1FhBsdQgBhnFGkmMHsBAunx6qPZBrK3OG7cisDT+Pj0=;
        b=PJYS3L9VfG1/8rNRVy1etaaE6kHsEwuHvoJc/aRVXrKeRqllOQcDk2U6/f8sGB2ld5
         Q2cwhvCeaEWPyIvg0GmRvyqVZQA1cDEmphmC+XjJLE5IrakPWLym06UwsxTdQMh28SZz
         g2EDCrnbp6xh0k17n91gesnWUWGFntVDzqk3a0492/Ti4SNcIKWFXHjr0Xos3GZlJqAI
         /FA8vasuXDU7k17uUljdH7Je8PoqnDwIPTl9HTaJLtmYl/9qJTShuif/mLSwsShshgJn
         oHrmqpuyiaqVgWDE/4q4gUiPs7pyVgSI/xvkPZjiGNOpb0yYM92+FxXFQ1fF0fImiqsL
         l0tA==
X-Gm-Message-State: ABUngvfFYMV/mKkS7/RpFnISmOiFd3HURCtN8oKhyoL18o1/RKN7cWuN4C9vrZ8GCCG/2doO48VzmwHnj1K98Q==
X-Received: by 10.13.200.134 with SMTP id k128mr8513018ywd.72.1478980914855;
 Sat, 12 Nov 2016 12:01:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 12 Nov 2016 12:01:24 -0800 (PST)
In-Reply-To: <CA+P7+xrm-MMRa9RuaHUGNWJmH8UcYPj3RZCsy1uvVRMuLeP0ZQ@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-9-Karthik.188@gmail.com>
 <CA+P7+xrm-MMRa9RuaHUGNWJmH8UcYPj3RZCsy1uvVRMuLeP0ZQ@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 13 Nov 2016 01:31:24 +0530
Message-ID: <CAOLa=ZSYNbsm9vvQwBtC0RwO3DYZTiq0pdeF=G8wNgf5rba00A@mail.gmail.com>
Subject: Re: [PATCH v7 08/17] ref-filter: add support for %(upstream:track,nobracket)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 5:15 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add support for %(upstream:track,nobracket) which will print the
>> tracking information without the brackets (i.e. "ahead N, behind M").
>> This is needed when we port branch.c to use ref-filter's printing APIs.
>>
>
> Makes sense. Seems a bit weird that we have the brackets normally
> rather than adding them as an option, but I think this is ok. We don't
> want to change all previous uses in this case.
>
> My only suggestion here would be to add code so that the options die()
> when we use nobracket along with trackshort or without track. This
> ensures that the nobracket option only applies to track mode?
>

Sure, seems reasonable. There's also the fact that even though nobracket
actually only supports the 'track' option. It might make sense to
leave it as it
is, i.e not die() when used with the other options cause, it kinda stays true to
it being used. e.g. %(upstream:nobracket,trackshort) does give 'trackshort'
without brackets, even though that's the default option and only way we print
'trackshort' information, it seems to make sense from the users point of view.

>> Add test and documentation for the same.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.txt |  8 +++--
>>  ref-filter.c                       | 67 +++++++++++++++++++++++++-------------
>>  t/t6300-for-each-ref.sh            |  2 ++
>>  3 files changed, 51 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index fd365eb..3953431 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -118,9 +118,11 @@ upstream::
>>         `refname` above.  Additionally respects `:track` to show
>>         "[ahead N, behind M]" and `:trackshort` to show the terse
>>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>> -       or "=" (in sync).  Has no effect if the ref does not have
>> -       tracking information associated with it. `:track` also prints
>> -       "[gone]" whenever unknown upstream ref is encountered.
>> +       or "=" (in sync). `:track` also prints "[gone]" whenever
>> +       unknown upstream ref is encountered. Append `:track,nobracket`
>> +       to show tracking information without brackets (i.e "ahead N,
>> +       behind M").  Has no effect if the ref does not have tracking
>> +       information associated with it.
>>
>
> Ok so my comment on the previous patch is fixed here, the new wording
> makes it much more clear that [gone] is not the same thing as no
> information. So I don't think we should bother changing the previous
> patch in the series. This might want to document that nobracket works
> even without track, even if it doesn't actually do anything? Or make
> the code more strict in that we die() if the values are put together
> that make no sense?
>

Speaking from what I said above, maybe it makes sense to leave it like it is?

>>  push::
>>         The name of a local ref which represents the `@{push}` location
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 6d51b80..4d7e414 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -46,8 +46,10 @@ static struct used_atom {
>>         union {
>>                 char color[COLOR_MAXLEN];
>>                 struct align align;
>> -               enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>> -                       remote_ref;
>> +               struct {
>> +                       enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
>> +                       unsigned int nobracket: 1;
>> +               } remote_ref;
>>                 struct {
>>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>>                         unsigned int nlines;
>> @@ -75,16 +77,33 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
>>
>>  static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>>  {
>> -       if (!arg)
>> -               atom->u.remote_ref = RR_NORMAL;
>> -       else if (!strcmp(arg, "short"))
>> -               atom->u.remote_ref = RR_SHORTEN;
>> -       else if (!strcmp(arg, "track"))
>> -               atom->u.remote_ref = RR_TRACK;
>> -       else if (!strcmp(arg, "trackshort"))
>> -               atom->u.remote_ref = RR_TRACKSHORT;
>> -       else
>> -               die(_("unrecognized format: %%(%s)"), atom->name);
>> +       struct string_list params = STRING_LIST_INIT_DUP;
>> +       int i;
>> +
>> +       if (!arg) {
>> +               atom->u.remote_ref.option = RR_NORMAL;
>> +               return;
>> +       }
>> +
>> +       atom->u.remote_ref.nobracket = 0;
>> +       string_list_split(&params, arg, ',', -1);
>> +
>> +       for (i = 0; i < params.nr; i++) {
>> +               const char *s = params.items[i].string;
>> +
>> +               if (!strcmp(s, "short"))
>> +                       atom->u.remote_ref.option = RR_SHORTEN;
>> +               else if (!strcmp(s, "track"))
>
> Should we add die()s here to disallow setting the remote_ref option
> multiple times? Otherwise, we should document that the last one wins?
> Not sure it's really a big deal here, but we could do it to ensure
> consistency for options which don't make sense together?
>

It makes sense to add a small note that the last option wins, I suppose


-- 
Regards,
Karthik Nayak
