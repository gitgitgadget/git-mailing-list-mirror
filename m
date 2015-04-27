From: Quentin Neill <quentin.neill@gmail.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Mon, 27 Apr 2015 08:46:14 -0500
Message-ID: <CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 15:46:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmjMa-0002O9-2A
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 15:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbbD0NqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 09:46:15 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35750 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbD0NqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 09:46:15 -0400
Received: by qgej70 with SMTP id j70so49462790qge.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QhbJ+P7GAqh7UFyma1Y4f9gnCFfDfUa8xbMFZFNigO0=;
        b=NXBTXd5dAIKYGrO5i6KQH5emrCdJyw6++CR2Q13DPFFnfwljB7aB3zAx3ba/n4P7rB
         a5bRJuTmWzn7PuEZaQ3ddSWAI9qCotnryggwBUtLKaf/eptVtrsU3Fd5ztoU4oCwUz2u
         J3mdb2ucP5ayUMB/l8NLKuApWUJcZNOjW1sWoalZeh96cmrIZOqIdng3sI6TlFR4x6nM
         TTZvqGAwiVgRKzqqkEsZA5Lnw+BKaJvS7N2ZpeDdmDIAgj2zL3CHUTAYSr7h3RPWiHWP
         DLK+5bXqJGPWTYackExvtYVQxvebjBVh3sAbHjOra6cQbGVZwC4KQkAw34+fcBDczxQL
         uAnQ==
X-Received: by 10.140.30.245 with SMTP id d108mr7252714qgd.93.1430142374163;
 Mon, 27 Apr 2015 06:46:14 -0700 (PDT)
Received: by 10.140.89.229 with HTTP; Mon, 27 Apr 2015 06:46:14 -0700 (PDT)
In-Reply-To: <CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267855>

Thanks for the thorough review!
I have adjusted the commit messages and updated the documentation changes.
I'm in trying to add tests, I'll probably have some issues but will
post something that works soon.
As for the comments on behavior, see my responses below.

--
Quentin

"There! His Majesty can now read my name without glasses. And he can
double the reward on my head!" - John Hancock, upon signing the
Declaration of Independence



On Fri, Apr 24, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Thanks for the submission. See comments below...
>
> On Thu, Apr 23, 2015 at 10:13 PM, Quentin Neill <quentin.neill@gmail.com> wrote:
>> From: Quentin Neill <quentin.neill@gmail.com>
>
> You should drop this line. git-am will pluck your name and email
> automatically from the email From: header.
>
>>         If you prefer seeing emails in your git blame output, rather
>>         than sprinkling '-e' options everywhere you can just set
>>         the new config blame.showemail to true.
>
> Drop the indentation from the commit message.
>
> It's not clear what "everywhere" means in the above. It might be
> sufficient to rephrase more simply as:
>
>     Complement existing --show-email option with fallback
>     configuration variable.
>
> or something.
>
>> ---
>
> Missing Signed-off-by:. See Documentation/SubmittingPatches.
>
>> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
>> index b299b59..9326115 100644
>> --- a/Documentation/blame-options.txt
>> +++ b/Documentation/blame-options.txt
>> @@ -1,6 +1,11 @@
>>  -b::
>>         Show blank SHA-1 for boundary commits.  This can also
>>         be controlled via the `blame.blankboundary` config option.
>> +-e::
>> +--show-email::
>
> Insert a blank line before the "-e" line to separate it from the "-b" paragraph.
>
>> +       Show the author email instead of author name (Default: off).
>> +       This can also be controlled via the `blame.showemail` config
>> +       option.
>
> Despite being case-insensitive and despite existing inconsistencies,
> in documentation, it is customary to use camelCase for configuration
> options, so "blame.showEmail".
>
> Also blame.showEmail probably ought to be documented in
> Documentation/config.txt (although there is some inconsistency here in
> that documentation for the other blame-specific variables is missing
> from config.txt, so perhaps that's something that could be addressed
> separately).
>
>>  --root::
>>         Do not treat root commits as boundaries.  This can also be
>> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
>> index 9f23a86..50a9030 100644
>> --- a/Documentation/git-blame.txt
>> +++ b/Documentation/git-blame.txt
>> @@ -73,10 +73,6 @@ include::blame-options.txt[]
>>  -s::
>>         Suppress the author name and timestamp from the output.
>>
>> --e::
>> ---show-email::
>> -       Show the author email instead of author name (Default: off).
>> -
>
> It's not clear why you relocated documentation of --show-email from
> git-blame.txt to blame-options.txt, and the commit message does not
> explain the move. If there's a good reason for the relocation, the
> justification should be spelled out so that people reviewing the patch
> or looking through history later on will not have to guess about it.

I moved it to be with the other variables that had configuration
options, but I will move it back.

> It might also make sense to do the relocation as a separate
> preparatory patch of a 2-patch series, in which the patch adding
> blame.showemail is the second of the two.

If you think it should be relocated, I will address in a separate patch.

>>  -w::
>>         Ignore whitespace when comparing the parent's version and
>>         the child's to find where the lines came from.
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 06484c2..70bfd0a 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -44,6 +44,7 @@ static int max_score_digits;
>>  static int show_root;
>>  static int reverse;
>>  static int blank_boundary;
>> +static int show_email;
>>  static int incremental;
>>  static int xdl_opts;
>>  static int abbrev = -1;
>> @@ -1926,7 +1927,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>>                 printf("%.*s", length, hex);
>>                 if (opt & OUTPUT_ANNOTATE_COMPAT) {
>>                         const char *name;
>> -                       if (opt & OUTPUT_SHOW_EMAIL)
>> +                       if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
>
> The desired behavior is for a configuration setting to provide a
> fallback, and for a command-line option to override the fallback. So,
> for instance, if blame.showemail is "true", then --no-show-email
> should countermand that. Unfortunately, the way this patch is
> implemented, it's impossible to override the setting from the
> command-line since show_email==true will always win (when
> blame.showemail is "true").
>
> More below.

I followed the code for blame.showRoot and blame.blankboundary.

I think the desired behavior for the other switches would go in a
separate patch, the question is should it precede this one adding
'blame.showemail'?

>>                                 name = ci.author_mail.buf;
>>                         else
>>                                 name = ci.author.buf;
>> @@ -2185,6 +2186,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>>                 blank_boundary = git_config_bool(var, value);
>>                 return 0;
>>         }
>> +       if (!strcmp(var, "blame.showemail")) {
>> +               show_email = git_config_bool(var, value);
>> +               return 0;
>> +       }
>>         if (!strcmp(var, "blame.date")) {
>>                 if (!value)
>>                         return config_error_nonbool(var);
>
> You'll also want to add tests for the new blame.showemail
> configuration. There's already one test in t8002-blame.sh which checks
> that --show-email works, but you will want tests to ensure that you
> get the expected results for all combinations of blame.showemail and
> --show-email (including when --show-email is not specified).

Agreed, but again I don't see tests for the other switches with options.
