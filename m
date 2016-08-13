Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7972018E
	for <e@80x24.org>; Sat, 13 Aug 2016 13:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbcHMNub (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 09:50:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33223 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbcHMNua (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 09:50:30 -0400
Received: by mail-yw0-f194.google.com with SMTP id z8so583502ywa.0
        for <git@vger.kernel.org>; Sat, 13 Aug 2016 06:50:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wCmQaR/mPNwaBSKgg4w58QJ5PzOckXXAl9Sdq/xR1xU=;
        b=r25lZVWXcwQ3lOctPE30cN3i5eYuZS24gWU8IbqBGD7AybPtk6r0lWsSd/4UEC0A7Q
         lfcYzqST4YRHH8gThIACrEzAMlV+3o0FEVArmfF8AFszIhsKDnm8nOsYuLUa7Xd+NEU5
         FqvK+HzYV5kASTf4HgIHz0c2B6I9GskzEkvO7X4AlAQsXc7z4LjirXdIfOpKG8wJGAKJ
         o/IWcvh34NjOEsRL7gI9/Dpy8xlK294JgAcTcO35aZnBR/U6OuLDM9diqTyFv7P6dVuy
         EVO103Fnb3LqglrHenkVLW4v+jcLKufou/ZDR7zY4SmGea5dOnUjHD34vUyKO491ccR4
         pSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wCmQaR/mPNwaBSKgg4w58QJ5PzOckXXAl9Sdq/xR1xU=;
        b=BMZOiz4ZGlLfVoKtQIzHsmklAaI7NvggcNZHX0F8JByJK4IjuhMSJXHF6B1U3A99cO
         soGStuJbt0GyA7DMvQUdf2GzWm2GQaYg3TNQFRdPozMTX3f9OTCrtJmC4/Bcwi+pQGft
         s+MtduVFmGThEU//Kx+EBWC5DOnpZnKrJAE1FsStLs8b6ZFgdeEYJoDIuL/XWcb9AW5u
         eCrtq8w5FSAxsfnDkk623qUt1S3fmzifkQMHVfR9nZztYa08K+tmpGqhHXNgnQ9Gc8O6
         3ChMArqbC8OZ0qqWW0LjTVHdPHr9Y2fN+lsp47gK2yMhjng52y7nEk79xEr2YOKmlwLN
         mJDA==
X-Gm-Message-State: AEkoouuLtIi2unHzibhGx1IoB+Uu3ukzDJLmK60Fju1ZqBYCt6cXbmxDVAkkxvBCiAWJLbjvLo0RTAhgjZKevw==
X-Received: by 10.129.154.76 with SMTP id r73mr15058980ywg.164.1471096224985;
 Sat, 13 Aug 2016 06:50:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 13 Aug 2016 06:50:24 -0700 (PDT)
In-Reply-To: <CAP8UFD1pUOUKKMQLsyTMtSBUG3s340vOjrGqRpC-CGzuyQXwzA@mail.gmail.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
 <010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
 <CAP8UFD1pUOUKKMQLsyTMtSBUG3s340vOjrGqRpC-CGzuyQXwzA@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Sat, 13 Aug 2016 19:20:24 +0530
Message-ID: <CAFZEwPMn=qUWbkdBfYgo8g8CdPNLX-B2xEBvZ8-otk3=2qjxNQ@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] bisect--helper: `bisect_start` shell function
 partially in C
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Christian,

On Sat, Aug 13, 2016 at 1:04 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Aug 10, 2016 at 11:57 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>
>> @@ -431,6 +434,244 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>>         return 0;
>>  }
>>
>> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
>> +                       const char **argv, int argc)
>> +{
>> +       int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
>> +       int flags, pathspec_pos;
>> +       struct string_list revs = STRING_LIST_INIT_DUP;
>> +       struct string_list states = STRING_LIST_INIT_DUP;
>> +       struct strbuf start_head = STRBUF_INIT;
>> +       struct strbuf bisect_names = STRBUF_INIT;
>> +       struct strbuf orig_args = STRBUF_INIT;
>> +       const char *head;
>> +       unsigned char sha1[20];
>> +       FILE *fp;
>> +       struct object_id oid;
>> +
>> +       if (is_bare_repository())
>> +               no_checkout = 1;
>> +
>> +       for (i = 0; i < argc; i++) {
>> +               char *commit_id = xstrfmt("%s^{commit}", argv[i]);
>> +               if (!strcmp(argv[i], "--")) {
>> +                       has_double_dash = 1;
>> +                       break;
>> +               }
>
> In the shell code there is a loop dedicated to checking if there is a
> double dash in the arguments before the real argument parsing loop.
> There is a reason for that.
> If you do it in the same loop, has_double_dash will not be set when
> the arguments that are before the double dash will be parsed.

I had tried that before. But somehow I couldn't get it to run so I
reverted back. I have now successfully tried it and its working. You
can checkout the PR[1].

>> +               else if (!strcmp(argv[i], "--no-checkout"))
>> +                       no_checkout = 1;
>> +               else if (!strcmp(argv[i], "--term-good") ||
>> +                        !strcmp(argv[i], "--term-old")) {
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_good);
>> +                       strbuf_addstr(&terms->term_good, argv[++i]);
>> +               }
>> +               else if (skip_prefix(argv[i], "--term-good=", &argv[i])) {
>
> (Maybe you could put the "else if (...) {" on the same line as the "}" above.)
>
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_good);
>> +                       strbuf_addstr(&terms->term_good, argv[i]);
>> +               }
>> +               else if (skip_prefix(argv[i], "--term-old=", &argv[i])) {
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_good);
>> +                       strbuf_addstr(&terms->term_good, argv[i]);
>> +               }
>> +               else if (!strcmp(argv[i], "--term-bad") ||
>> +                        !strcmp(argv[i], "--term-new")) {
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_bad);
>> +                       strbuf_addstr(&terms->term_bad, argv[++i]);
>> +               }
>> +               else if (skip_prefix(argv[i], "--term-bad=", &argv[i])) {
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_bad);
>> +                       strbuf_addstr(&terms->term_bad, argv[i]);
>> +               }
>> +               else if (skip_prefix(argv[i], "--term-new=", &argv[i])) {
>> +                       must_write_terms = 1;
>> +                       strbuf_reset(&terms->term_good);
>> +                       strbuf_addstr(&terms->term_good, argv[i]);
>> +               }
>> +               else if (starts_with(argv[i], "--") &&
>> +                        !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
>> +                       string_list_clear(&revs, 0);
>> +                       string_list_clear(&states, 0);
>> +                       die(_("unrecognised option: '%s'"), argv[i]);
>> +               }
>> +               else if (get_oid(argv[i], &oid) && !has_double_dash) {
>
> And here checking "!has_double_dash" has no meaning if you check for a
> double dash in the same loop, because there is a "break" after
> has_double_dash is set above.

I think this is the situation in the shell script too.

>> +                       string_list_clear(&revs, 0);
>> +                       string_list_clear(&states, 0);
>> +                       free(commit_id);
>> +                       die(_("'%s' does not appear to be a valid revision"), argv[i]);
>> +               }
>> +               else {
>> +                       free(commit_id);
>> +                       string_list_append(&revs, oid_to_hex(&oid));
>> +               }
>> +       }
>> +       pathspec_pos = i;
>> +

Regards,
Pranit Bauva
