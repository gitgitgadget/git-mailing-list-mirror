Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CFD1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 09:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeJIRHF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 13:07:05 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:5798 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIRHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 13:07:05 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 9ofGgtiK2VlGZ9ofGgR9XO; Tue, 09 Oct 2018 10:50:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539078655;
        bh=DD/2ocDWyoFaRvsUEC0sDSecH0zsSmyKyGF7OhsAO7Y=;
        h=From:Subject:Reply-To:To:Cc:References:Date:In-Reply-To;
        b=d4Ihw+AjKNyeKq4iWF9cvOrK0wY8o5ewUBsabeb2J+Z/pmTlTyHMoGEowzsKYJm2W
         1CAEOGcr0CU5KEg0VYewVtXRZ4k5DBfx3xzi+hnQ8S6+JmdQyKRP/kMEoHoCqai5dv
         aS52VA3tvpUYLYkwaxyl9hk596rQ+iQw6gV0BjG4=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=8AHkEIZyAAAA:8 a=asdIWTdbZCsiAFU7btQA:9
 a=LqkPHphmLaGG62Lb:21 a=Kzso-JcZHcFmjcCb:21 a=QEXdDO2ut3YA:10
 a=rtb7j84pXIkA:10 a=IjBj6na_V8MA:10 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
Subject: [RFC PATCH 3/3] diff: add
 --color-moved-ws=allow-mixed-indentation-change
Reply-To: phillip.wood@dunelm.org.uk
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20180924100604.32208-4-phillip.wood@talktalk.net>
 <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
Message-ID: <b3d29d34-616d-5d12-bb86-19ea488a766d@talktalk.net>
Date:   Tue, 9 Oct 2018 10:50:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIARAVllYsPK9qm4xS39xMgXuviMIKtnsIpDR0snneOgfTjFglDQBTYYocp+DfoUX79oKYbdtCBt6s12fXBTdU7g4IELXMQxITSNtk/x3yshU484zjF+
 S+9zaKDJyjK6d2Q+CGwJQpb9QZHk5WzfxwsagITaLo8nVyIZOddbi56RxfxQZm6eO1DXsBAP4hnPX6nDalG+W0m64jfgUZ7dyRWS55ebLbkPlZCl88R9nij+
 xibm2iFL3YHTEDte1Prq2fdAVX6QajaDuP9eX2uRyHCjvsrgSIxDdkOnG3/rOK8N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

Thanks for all your comments on this, they've been really helpful.

On 25/09/2018 02:07, Stefan Beller wrote:
> On Mon, Sep 24, 2018 at 3:06 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This adds another mode for highlighting lines that have moved with an
>> indentation change. Unlike the existing
>> --color-moved-ws=allow-indentation-change setting this mode uses the
>> visible change in the indentation to group lines, rather than the
>> indentation string.
> 
> Wow! Thanks for putting this RFC out.
> My original vision was to be useful to python users as well,
> which counts 1 tab as 8 spaces IIUC.
> 
> The "visual" indentation you mention here sounds like
> a tab is counted as "up to the next position of (n-1) % 8",
> i.e. stop at positions 8, 16, 24... which would not be pythonic,
> but useful in e.g. our code base.

The docs for python2 state[1]

  Leading whitespace (spaces and tabs) at the beginning of a logical
  line is used to compute the indentation level of the line, which in
  turn is used to determine the grouping of statements.

  First, tabs are replaced (from left to right) by one to eight spaces
  such that the total number of characters up to and including the
  replacement is a multiple of eight (this is intended to be the same
  rule as used by Unix). The total number of spaces preceding the
  first non-blank character then determines the line’s
  indentation. Indentation cannot be split over multiple physical
  lines using backslashes; the whitespace up to the first backslash
  determines the indentation.

As I understand it that fits with the "visual" indentation implemented
by this patch.

For python3 adds a third paragraph[2]

  Indentation is rejected as inconsistent if a source file mixes tabs
  and spaces in a way that makes the meaning dependent on the worth of
  a tab in spaces; a TabError is raised in that case.

My impression is that people generally avoid mixing tabs and spaces in
python3 code, in which case I wonder if the "visual" indentation
combined with a suitable setting for core.whitespace to highlight
erroneous tabs/spaces would be enough. (I'm not a python programmer so I
could be completely wrong on that)

In any case the more I think about it the more convinced I am that
having a move detection mode for "pythonic" indentation is a mistake. If
a line is added with dodgy indentation then it is a problem whether or
not it has been moved so I think this should be handled by the
whitespace error highlighting. This would allow a single mode for move
detection with an indentation change.

[1] https://docs.python.org/2.7/reference/lexical_analysis.html#indentation
[2] https://docs.python.org/3.7/reference/lexical_analysis.html#indentation

>> This means it works with files that use a mix of
>> tabs and spaces for indentation and can cope with whitespace errors
>> where there is a space before a tab
> 
> Cool!
> 
>> (it's the job of
>> --ws-error-highlight to deal with those errors, it should affect the
>> move detection).
> 
> Not sure I understand this side note. So --ws-error-highlight can
> highlight them, but the move detection should *not*(?) be affected
> by the highlighted parts, or it should do things differently on
> whether  --ws-error-highlight is given?

I just meant that the move detection should pretend the whitespace
errors do not exist.

>> It will also group the lines either
>> side of a blank line if their indentation change matches so short
>> lines followed by a blank line followed by more lines with the same
>> indentation change will be correctly highlighted.
> 
> That sounds very useful (at least for my editor, that strips
> blank lines to be empty lines), but I would think this feature is
> worth its own commit/patch.
> 
> I wonder how much this feature is orthogonal to the existing
> problem of detecting the moved indented blocks (existing
> allow-indentation-change vs the new feature discussed first
> above)

It only works if the blank lines get moved with the non-blank lines
around it, then it matches the normal moved behavior I think. I'd like
to have it include blank context lines where the lines either side have
the same indentation change but that is trickier to implement.

>>
>> This is a RFC as there are a number of questions about how to proceed
>> from here:
>>  1) Do we need a second option or should this implementation replace
>>     --color-moved-ws=allow-indentation-change. I'm unclear if that mode
>>     has any advantages for some people. There seems to have been an
>>     intention [1] to get it working with mixes of tabs and spaces but
>>     nothing ever came of it.
> 
> Oh, yeah, I was working on that, but dropped the ball.
> 
> I am not sure what the best end goal is, or if there are many different
> modes that are useful to different target audiences.
> My own itch at the time was (de-/)in-dented code from refactoring
> patches for git.git and JGit (so Java, C, shell); and I think not hurting
> python would also be good.

As I said above I've more or less come to the view that the correctness
of pythonic indentation is orthogonal to move detection as it affects
all additions, not just those that correspond to moved lines.

> ignoring the mixture of ws seems like it would also cater free text or
> other more exotic languages.
> 
> What is your use case, what kind of content do you process that
> this patch would help you?

I wrote this because I was re-factoring some shell code than was using a
indentation step of four spaces but with tabs in the leading indentation
which the current mode does not handle.

> I am not overly attached to the current implementation of
>  --color-moved-ws=allow-indentation-change,
> and I think Junio has expressed the fear of "too many options"
> already in this problem space, so if possible I would extend/replace
> the current option.
> 
>>  2) If we keep two options what should this option be called, the name
>>     is long and ambiguous at the moment - mixed could refer to mixed
>>     indentation length rather than a mix of tabs and spaces.
> 
> Let's first read the code to have an opinion, or re-state the question
> from above ("What is this used for?") as I could imagine one of the
> modes could be "ws-pythonic" and allow for whitespace indentation
> that would have the whole block count as an indented by the same
> amount, (e.g. if you wrap a couple functions in python by a class).
> 
>> +++ b/diff.c
>> @@ -304,7 +304,11 @@ static int parse_color_moved_ws(const char *arg)
>>                 else if (!strcmp(sb.buf, "ignore-all-space"))
>>                         ret |= XDF_IGNORE_WHITESPACE;
>>                 else if (!strcmp(sb.buf, "allow-indentation-change"))
>> -                       ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
>> +                       ret = COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
>> +                        (ret & ~COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE);
> 
> So this RFC lets "allow-indentation-change" override
> "allow-mixed-indentation-change" and vice versa. That
> also solves the issue of configuring one and giving the other
> as a command line option. Nice.
> 
>>         if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
>>             (ret & XDF_WHITESPACE_FLAGS))
>>                 die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
>> +       else if ((ret & COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) &&
>> +                (ret & XDF_WHITESPACE_FLAGS))
>> +               die(_("color-moved-ws: allow-mixed-indentation-change cannot be combined with other white space modes"));
> 
> Do we want to open a bit mask for all indentation change options? e.g.
> #define COLOR_MOVED_WS_INDENTATION_MASK \
>     (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE | \
>      COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE)

That's a good idea if we retain two separate modes

> 
>> @@ -763,11 +770,65 @@ struct moved_entry {
>>   * comparision is longer than the second.
>>   */
>>  struct ws_delta {
>> -       char *string;
>> +       union {
>> +               int delta;
>> +               char *string;
>> +       };
>>         unsigned int current_longer : 1;
>> +       unsigned int have_string : 1;
>>  };
>>  #define WS_DELTA_INIT { NULL, 0 }
>>
>> +static int compute_mixed_ws_delta(const struct emitted_diff_symbol *a,
>> +                                 const struct emitted_diff_symbol *b,
>> +                                 int *delta)
>> +{
>> +       unsigned int i = 0, j = 0;
>> +       int la, lb;
>> +       int ta = a->flags & WS_TAB_WIDTH_MASK;
>> +       int tb = b->flags & WS_TAB_WIDTH_MASK;
>> +       const char *sa = a->line;
>> +       const char *sb = b->line;
>> +
>> +       if (xdiff_is_blankline(sa, a->len, 0) &&
>> +           xdiff_is_blankline(sb, b->len, 0)) {
>> +               *delta = INT_MIN;
>> +               return 1;
>> +       }
>> +
>> +       /* skip any \v \f \r at start of indentation */
>> +       while (sa[i] == '\f' || sa[i] == '\v' ||
>> +              (sa[i] == '\r' && i < a->len - 1))
> 
> I do not understand the use of parens here.
> I would have expected all comparisons in one
> block which is then &&'d to the length requirement.
> But this seems to tread \r special if not at EOL.

I only want to skip '\r' if it isn't part of "\r\n" at the end of the
line. (similar to way --ignore-cr-at-eol does not ignore a trailing '\r'
on an incomplete line)

>> +               i++;
>> +       while (sb[j] == '\f' || sb[j] == '\v' ||
>> +              (sb[j] == '\r' && j < b->len - 1))
>> +               j++;
>> +
>> +       for (la = 0; ; i++) {
>> +               if (sa[i] == ' ')
>> +                       la++;
>> +               else if (sa[i] == '\t')
>> +                       la = ((la + ta) / ta) * ta;
> 
> multiplication/division may be expensive,
> would something like
> 
>   la = la - (la % ta) + ta;
> 
> work instead? (the modulo is a hidden division,
> but at least we do not have another multiplication)
> 
> Further I'd find it slightly easier to understand as it
> "fills up to the next multiple of <ta>" whereas the
> divide and re-multiply trick relies on integer logic, but
> that might be just me.  Maybe just add a comment.

I agree your version is clearer and it is marginally (~1%) faster

>> +               else
>> +                       break;
>> +       }
>> +       for (lb = 0; ; j++) {
>> +               if (sb[j] == ' ')
>> +                       lb++;
>> +               else if (sb[j] == '\t')
>> +                       lb = ((lb + tb) / tb) * tb;
>> +               else
>> +                       break;
>> +       }
>> +       if (a->s == DIFF_SYMBOL_PLUS)
>> +               *delta = la - lb;
>> +       else
>> +               *delta = lb - la;
> 
> When writing the original feature I had reasons
> not to rely on the symbol, as you could have
> moved things from + to - (or the other way round)
> and added or removed indentation. That is what the
> `current_longer` is used for. But given that you only
> count here, we can have negative numbers, so it
> would work either way for adding or removing indentation.
> 
> But then, why do we need to have a different sign
> depending on the sign of the line?

The check means that we get the same delta whichever way round the lines
are compared. I think I added this because without it the highlighting
gets broken if there is increase in indentation followed by an identical
decrease on the next line.

>> +
>> +       return (a->len - i == b->len - j) &&
>> +               !memcmp(sa + i, sb + j, a->len - i);
>> +}
>> +
>>  static int compute_ws_delta(const struct emitted_diff_symbol *a,
>>                              const struct emitted_diff_symbol *b,
>>                              struct ws_delta *out)
>> @@ -778,6 +839,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
>>
>>         out->string = xmemdupz(longer->line, d);
>>         out->current_longer = (a == longer);
>> +       out->have_string = 1;
>>
>>         return !strncmp(longer->line + d, shorter->line, shorter->len);
>>  }
>> @@ -820,15 +882,34 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
>>          * To do so we need to compare 'l' to 'cur', adjusting the
>>          * one of them for the white spaces, depending which was longer.
>>          */
> 
> The comment above would only apply to the original mode?

Yes that should be changed/moved

>> +       if (o->color_moved_ws_handling &
>> +           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
>> +               wslen = strlen(pmb->wsd->string);
>> +               if (pmb->wsd->current_longer)
>> +                       c += wslen;
>> +               else
>> +                       a += wslen;
>>
>> -       wslen = strlen(pmb->wsd->string);
>> -       if (pmb->wsd->current_longer)
>> -               c += wslen;
>> -       else
>> -               a += wslen;
>> +               if (strcmp(a, c))
>> +                       return 1;
> 
> This could be "return strcmp" instead of falling
> through to the last line in the function in case of 0. But this
> is just indenting code that is already there.

As you say it's keeping the code the same, also while it does not matter
to the caller at the moment I was wary of potentially changing the sign
of the return value.

>> -       if (strcmp(a, c))
>> -               return 1;
>> +               return 0;
>> +       } else if (o->color_moved_ws_handling &
>> +                  COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
>> +               int delta;
>> +
>> +               if (!compute_mixed_ws_delta(cur->es, l, &delta))
>> +                   return 1;
>> +
>> +               if (pmb->wsd->delta == INT_MIN) {
>> +                       pmb->wsd->delta = delta;
>> +                       return 0;
>> +               }
>> +
>> +               return !(delta == pmb->wsd->delta || delta == INT_MIN);
> 
> Most of the code here deals with jumping over empty lines, and the new
> mode is just comparing the two numbers.
> 
>> +       } else {
>> +               BUG("no color_moved_ws_allow_indentation_change set");
> 
> Instead of the BUG here could we have a switch/case (or if/else)
> covering the complete space of delta->have_string instead?
> Then we would not leave a lingering bug in the code base.

I'm not sure what you mean, we cover all the existing
color_moved_ws_handling values, I added the BUG() call to pick up future
omissions if another mode is added. (If we go for a single mode none of
this matters)

>> +       }
>>
>>         return 0;
>>  }
>> @@ -845,7 +926,8 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
>>                          & XDF_WHITESPACE_FLAGS;
>>
>>         if (diffopt->color_moved_ws_handling &
>> -           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>> +           (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
>> +            COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>>                 /*
>>                  * As there is not specific white space config given,
>>                  * we'd need to check for a new block, so ignore all
>> @@ -953,7 +1035,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>>                         pmb[i] = pmb[i]->next_line;
>>                 } else {
>>                         if (pmb[i]->wsd) {
>> -                               free(pmb[i]->wsd->string);
>> +                               if (pmb[i]->wsd->have_string)
>> +                                       free(pmb[i]->wsd->string);
>>                                 FREE_AND_NULL(pmb[i]->wsd);
>>                         }
>>                         pmb[i] = NULL;
>> @@ -1066,7 +1149,8 @@ static void mark_color_as_moved(struct diff_options *o,
>>                         continue;
>>
>>                 if (o->color_moved_ws_handling &
>> -                   COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>> +                   (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
>> +                    COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>>                         pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
>>                 else
>>                         pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
>> @@ -1088,6 +1172,17 @@ static void mark_color_as_moved(struct diff_options *o,
>>                                                 pmb[pmb_nr++] = match;
>>                                         } else
>>                                                 free(wsd);
>> +                               } else if (o->color_moved_ws_handling &
>> +                                          COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
>> +                                       int delta;
>> +
>> +                                       if (compute_mixed_ws_delta(l, match->es, &delta)) {
>> +                                               struct ws_delta *wsd = xmalloc(sizeof(*match->wsd));
>> +                                               wsd->delta = delta;
>> +                                               wsd->have_string = 0;
>> +                                               match->wsd = wsd;
>> +                                               pmb[pmb_nr++] = match;
> 
> I would want to keep mark_color_as_moved and friends smaller, and instead
> move the complexity to compute_ws_delta  which would check for the mode
> in `o` instead of repeating the modes in all these function.
> Just like cmp_in_block_with_wsd takes both modes into account

That makes sense, I'll fix it.

>> +                                       }
>>                                 } else {
>>                                         pmb[pmb_nr++] = match;
>>                                 }
>> @@ -5740,7 +5835,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>>                         struct hashmap add_lines, del_lines;
>>
>>                         if (o->color_moved_ws_handling &
>> -                           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>> +                           (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
>> +                            COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>>                                 o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
>>
>>                         hashmap_init(&del_lines, moved_entry_cmp, o, 0);
>> diff --git a/diff.h b/diff.h
>> index 5e6bcf0926..03628cda45 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -217,6 +217,7 @@ struct diff_options {
>>
>>         /* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
>>         #define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
>> +       #define COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE (1<<6)
>>         int color_moved_ws_handling;
>>  };
>>
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 41facf7abf..737dbd4a42 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -1902,4 +1902,93 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
>>         test_i18ngrep allow-indentation-change err
>>  '
>>
>> +NUL=''
>> +test_expect_success 'compare mixed whitespace delta across moved blocks' '
>> +
>> +       git reset --hard &&
>> +       tr Q_ "\t " <<-EOF >text.txt &&
> 
> So this is the extended version of q_to_tab, as it also
> translates _ to blank.

Exactly

>> +       ${NUL}
> 
> is an empty line? So maybe s/NUL/EMPTY/ ?

That might be clearer

> I think the following test cases may be useful:
> 
>     (3x_) too short without
>     $EMPTY
>     (4x_)  being grouped across blank line
> 
> that will be indented to
> 
>     (3x_+n) too short without
>     $EMPTY
>     (4x_+n)  being grouped across blank line
> 
> i.e. the current test of grouping across an empty line
> always has the same indentation before and after, but we
> only care about the change in indentation, such that
> we should be able to have different indentation levels
> before and after an empty line in the code, and
> still count it as a block when they are indented the
> same amount.

That's a good idea, thanks

> Is it possible for a block to start with an empty line?

Yes, the block in the test starts with an empty line

> How do we handle multiple adjacent empty lines?

We group them all with the moved lines. This is slightly different to
--ignore-blank-lines which has a threshold on how may blank lines it
will ignore.

> Do we need tests for such special cases?

I would probably be best, picking up changes to the behavior of unusual
corner cases is best done with a test.

> I hope this helps, as I gave the feedback above
> mostly unstructured.

It's been really useful, thank for taking the time to look through the
patch so carefully.

Best Wishes

Phillip

> I'm excited about the skip blank lines mode, but
> I am not quite sure about the "just count" mode,
> as that is what I had originally IIRC but Jonathan
> seemed to not be fond of it. Maybe he remembers
> why.
> 
> Thanks,
> Stefan
