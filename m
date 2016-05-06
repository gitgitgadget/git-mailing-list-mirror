From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to
 simplify tests
Date: Thu, 5 May 2016 22:51:50 -0700
Message-ID: <CAGZ79kZ59K5BoSVsbt4YM-Try9Q1CVdFeBW8GE5E1dJpSBWzVA@mail.gmail.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
	<CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
	<xmqqeg9f7v1l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:51:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayYg7-0002SR-RG
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 07:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcEFFvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 01:51:52 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34828 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbcEFFvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 01:51:51 -0400
Received: by mail-io0-f176.google.com with SMTP id d62so105437662iof.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PFTwIMhw2O8GOUb9jZ6tyqzuEI2ZNVdKipXH1TJYhbA=;
        b=ZMSwF4pDslMgXOeMNw1wCAvj2bdt45JYjYdpLP0Nl9QPqTj7NpN6fNmB9jR5QWV9/o
         KF9L+3lUET303uGL+ToMI4XWuMNhH83rOh+OGndm5SPnqKRewvx3d9xRNqeLTwSsNBgb
         k47l+9hvdptLnMurEEarlhDwSVWwy7XDjgObyr4v4Nr9I1KBolZGunW0xOUG1xOhCC50
         Hh4akkKhCVle03nkZOOu3FDwWk2KNhXkRV07mpaAG83uv3aJMMmPYQHtFSK8G62PihJm
         j087uxQqyGbIpZTEo0BgaRVg0lWkksHdexjfae0dcrO2Y2aZ40+xzhLSxyviFaYlw6ln
         RNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PFTwIMhw2O8GOUb9jZ6tyqzuEI2ZNVdKipXH1TJYhbA=;
        b=cvdJQYkbjjZlGzZ2QfNVwNQ4Jw9RE1/XVDSxsBRrZHx7reAsyfoNa0QlziIU9QF8mC
         LLo4JafEF8YK2VKdpvsd0orhue6FMfyCtWMxs5cPXJ1pGW0gc95c5WFw5402Ls7AfSBf
         QoKu4OjDrtLtDAAeNQs2JLfb0/8TB6SATjzpM/fOHUPQwrVvHUzFmOFymxtpKl1bhBSK
         dXZ0S05h82Rtxd6zbvGLN1z1KTqTVbo/aC94NBUcxMVPLW46c30G/LgS32a3OlfvEXfI
         E4d172kBylCcf4NIHHE0iEDNCWRPBpXsKiXlV699QPx5KHuKQ1C7CZ7fs4LaAhihla94
         Mp5g==
X-Gm-Message-State: AOPr4FW4EFcgB3LvBGbyeds1UYM5fi842lahCbNMAssy6V6aPflrHz5TErbY5M8vsb1h9vePEgRL9KDNR8UNypSW
X-Received: by 10.107.161.68 with SMTP id k65mr24283447ioe.110.1462513910760;
 Thu, 05 May 2016 22:51:50 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 22:51:50 -0700 (PDT)
In-Reply-To: <xmqqeg9f7v1l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293741>

On Thu, May 5, 2016 at 7:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> instead of filtering afterwards, i.e. each strbuf_add is guarded by
>> an
>>
>>      if (is_interesting_output(...))
>>         strbuf_add(...)
>
> That's a good approach.
>
> The implementation gets a bit trickier than the previous one, but it
> would look like this.  Discard 2/3 and 3/3 and replace them with
> this one.
>
> The external interface on the input side is no different, but on the
> output side, this version has "expected '%s', got '%s'" error, in
> the same spirit as the output from "test_cmp", added in.
>
> Instead of checking the entire output line-by-line for each expected
> output (in case you did not notice, you can give --expect='quiet: 3'
> --expect='abbrev: 7' and both must match), this one will check each
> output line against each expected pattern.  We wouldn't have too
> many entries in the variable dump and we wouldn't be taking too many
> --expect options, so the matching performance would not matter,
> though.
>
>
>  t/t0040-parse-options.sh |  1 +
>  test-parse-options.c     | 88 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 75 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index dbaee55..d678fbf 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -45,6 +45,7 @@ Standard options
>      -v, --verbose         be verbose
>      -n, --dry-run         dry run
>      -q, --quiet           be quiet
> +    --expect <string>     expected output in the variable dump
>
>  EOF
>
> diff --git a/test-parse-options.c b/test-parse-options.c
> index b5f4e90..e3f25df 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -39,6 +39,61 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
>         return 0;
>  }
>
> +static int collect_expect(const struct option *opt, const char *arg, int unset)
> +{
> +       struct string_list *expect;
> +       struct string_list_item *item;
> +       struct strbuf label = STRBUF_INIT;
> +       const char *colon;
> +
> +       if (!arg || unset)
> +               die("malformed --expect option");
> +
> +       expect = (struct string_list *)opt->value;
> +       colon = strchr(arg, ':');
> +       if (!colon)
> +               die("malformed --expect option, lacking a colon");
> +       strbuf_add(&label, arg, colon - arg);
> +       item = string_list_insert(expect, strbuf_detach(&label, NULL));
> +       if (item->util)
> +               die("malformed --expect option, duplicate %s", label.buf);
> +       item->util = (void *)arg;
> +       return 0;
> +}
> +
> +__attribute__((format (printf,3,4)))
> +static void show(struct string_list *expect, int *status, const char *fmt, ...)
> +{
> +       struct string_list_item *item;
> +       struct strbuf buf = STRBUF_INIT;
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       strbuf_vaddf(&buf, fmt, args);
> +       va_end(args);
> +
> +       if (!expect->nr)
> +               printf("%s\n", buf.buf);
> +       else {
> +               char *colon = strchr(buf.buf, ':');
> +               if (!colon)
> +                       die("malformed output format, output lacking colon: %s", fmt);
> +               *colon = '\0';
> +               item = string_list_lookup(expect, buf.buf);
> +               *colon = ':';

I have been staring at this for a good couple of minutes and wondered if this
low level string manipulation is really the best way to do it.

(It feels very C idiomatic, not using a lot of Gits own data
structures. I would have
expected some sort of skip_prefix just with partial regular expression or a
string_list_split_in_place for the splitting. But this "set and reset *colon"
seems to be optimal here)

> +               if (!item)
> +                       ; /* not among entries being checked */
> +               else {
> +                       if (strcmp((const char *)item->util, buf.buf)) {
> +                               printf("expected '%s', got '%s'\n",
> +                                      (char *)item->util, buf.buf);
> +                               *status = 1;
> +                       }
> +               }
> +       }
> +       strbuf_reset(&buf);

strbuf_release ?

> +}
> +
>  int main(int argc, char **argv)
>  {
>         const char *prefix = "prefix/";
> @@ -46,6 +101,7 @@ int main(int argc, char **argv)
>                 "test-parse-options <options>",
>                 NULL
>         };
> +       struct string_list expect = STRING_LIST_INIT_NODUP;
>         struct option options[] = {
>                 OPT_BOOL(0, "yes", &boolean, "get a boolean"),
>                 OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
> @@ -86,34 +142,38 @@ int main(int argc, char **argv)
>                 OPT__VERBOSE(&verbose, "be verbose"),
>                 OPT__DRY_RUN(&dry_run, "dry run"),
>                 OPT__QUIET(&quiet, "be quiet"),
> +               OPT_CALLBACK(0, "expect", &expect, "string",
> +                            "expected output in the variable dump",
> +                            collect_expect),
>                 OPT_END(),
>         };
>         int i;
> +       int ret = 0;
>
>         argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
>
>         if (length_cb.called) {
>                 const char *arg = length_cb.arg;
>                 int unset = length_cb.unset;
> -               printf("Callback: \"%s\", %d\n",
> -                      (arg ? arg : "not set"), unset);
> +               show(&expect, &ret, "Callback: \"%s\", %d",
> +                    (arg ? arg : "not set"), unset);
>         }
> -       printf("boolean: %d\n", boolean);
> -       printf("integer: %d\n", integer);
> -       printf("magnitude: %lu\n", magnitude);
> -       printf("timestamp: %lu\n", timestamp);
> -       printf("string: %s\n", string ? string : "(not set)");
> -       printf("abbrev: %d\n", abbrev);
> -       printf("verbose: %d\n", verbose);
> -       printf("quiet: %d\n", quiet);
> -       printf("dry run: %s\n", dry_run ? "yes" : "no");
> -       printf("file: %s\n", file ? file : "(not set)");
> +       show(&expect, &ret, "boolean: %d", boolean);
> +       show(&expect, &ret, "integer: %d", integer);
> +       show(&expect, &ret, "magnitude: %lu", magnitude);
> +       show(&expect, &ret, "timestamp: %lu", timestamp);
> +       show(&expect, &ret, "string: %s", string ? string : "(not set)");
> +       show(&expect, &ret, "abbrev: %d", abbrev);
> +       show(&expect, &ret, "verbose: %d", verbose);
> +       show(&expect, &ret, "quiet: %d", quiet);
> +       show(&expect, &ret, "dry run: %s", dry_run ? "yes" : "no");
> +       show(&expect, &ret, "file: %s", file ? file : "(not set)");
>
>         for (i = 0; i < list.nr; i++)
> -               printf("list: %s\n", list.items[i].string);
> +               show(&expect, &ret, "list: %s", list.items[i].string);
>
>         for (i = 0; i < argc; i++)
> -               printf("arg %02d: %s\n", i, argv[i]);
> +               show(&expect, &ret, "arg %02d: %s", i, argv[i]);
>
>         return 0;

    return ret; ? Otherwise `ret` is unused.

>  }
