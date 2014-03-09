From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Sun, 9 Mar 2014 03:49:53 -0400
Message-ID: <CAPig+cS9Eh7bde90SsVWqeWP+fZqDTV3fk6FryoP5SFg-FyfTw@mail.gmail.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cR0tw4em_mPNLdp1-gNER2G1FyAVCyZAb9_TbtSyuGyaA@mail.gmail.com>
	<CAOLa=ZSjEv+p17--8UPN7=p+DfLWyEftjAXZDnxuaDKo96Lj7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 08:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYUh-0006UR-9y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 08:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbaCIHtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2014 03:49:55 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:38114 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbaCIHty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 03:49:54 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so15814003ykq.0
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n20v4c2KdGwfe+RnTQRem5+2puwOQ/UAbmsYAJHznik=;
        b=edIs0nwfMcTlR5yEoGWF3kAg3TKIw4mK7qsmN5aGXP5VgJt/oHdIeOXuQDIWthVwM/
         LY63I+5lM3zXzs6IqHZmU1kDvwHTTEuVZQpaJWW3S64VUuTyt7B0MjkKffFJXN/RjHKA
         c6muXXbFahrlvapgtVrryOgrd4VYfzpwEDNH+Z3dcy2caFzzrlKgeMaRRGW8QCizlSuU
         B5X1vfct8pvBdPZ9NWmTVJMSpc07P5mUZ8TJMJpkd0bgQtBO2kWFMsQo0iUvW/wRHIkF
         RHejDrQcqJyYkjDawdGqw6/W5f1paOJ7r/zvgPglqY0oEasTSRdAO3UrdisF9wgz/3/s
         43Sg==
X-Received: by 10.236.101.227 with SMTP id b63mr34665008yhg.37.1394351393484;
 Sat, 08 Mar 2014 23:49:53 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Sat, 8 Mar 2014 23:49:53 -0800 (PST)
In-Reply-To: <CAOLa=ZSjEv+p17--8UPN7=p+DfLWyEftjAXZDnxuaDKo96Lj7w@mail.gmail.com>
X-Google-Sender-Auth: 9HeQPASzX8gTpqp6l6EP0GNdm6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243690>

On Fri, Mar 7, 2014 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
> Hello Eric,
> Thanks for your reply, and for that information.  should i patch again or
> this should do?
> And what next? Talk to the mentor?

The ultimate authority deciding if a patch is ready is Junio, as it
would have to be accepted into his tree. Since he already accepted a
similar patch from a different potential GSoC applicant, it may not
make sense to refine this one further. What is important is that you
are now familiar with the review process on this project, and the
mentors (hopefully) have gained insight into your abilities and how
you interact with reviewers (which was the goal of these
microprojects).

Probably best at this point is to consider a proposed project [1] or
choose your own, and start the task of applying for a GSoC position
(by whatever means that is done).

[1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Ideas.md

> On Fri, Mar 7, 2014 at 3:04 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>>
>> On Thu, Mar 6, 2014 at 12:05 PM, Karthik Nayak <karthik.188@gmail.com>
>> wrote:
>> > Replace all instances of starts_with() by skip_prefix(),
>> > which can not only be used to check presence of a prefix,
>> > but also used further on as it returns the string after the prefix,
>> > if the prefix is present. And also manages to do, what the current
>> > code does in two steps.
>>
>> Better. Thanks.
>>
>> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> > ---
>> > Hello Eric,
>> > In this patch, I have:
>> > 1. Fixed the improper placement of buf_date , initialised to a NULL
>> > string.
>> > 2. Fixed whitespace.
>> > 3. Better naming as per your suggestion.
>> > 4. Fixed the initilisation before the if statement.
>> > Thanks for your suggestion.
>> > ---
>> >  commit.c | 22 +++++++++++-----------
>> >  1 file changed, 11 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/commit.c b/commit.c
>> > index 6bf4fe0..4144e00 100644
>> > --- a/commit.c
>> > +++ b/commit.c
>> > @@ -553,6 +553,7 @@ static void record_author_date(struct
>> > author_date_slab *author_date,
>> >         struct ident_split ident;
>> >         char *date_end;
>> >         unsigned long date;
>> > +       const char *buf_date;
>> >
>> >         if (!commit->buffer) {
>> >                 unsigned long size;
>> > @@ -565,15 +566,15 @@ static void record_author_date(struct
>> > author_date_slab *author_date,
>> >         for (buf = commit->buffer ? commit->buffer : buffer;
>> >              buf;
>> >              buf = line_end + 1) {
>> > +               buf_date = skip_prefix(buf, "author ");
>>
>> The data after "author " is identification information (name, email),
>> not date. In fact, this information gets passed to the function
>> split_ident_line(), so a better name for this variable is 'ident_line'
>> (but not the misspelling 'indent_line' from one of your earlier
>> attempts).
>>
>> >                 line_end = strchrnul(buf, '\n');
>> > -               if (!starts_with(buf, "author ")) {
>> > +               if (!buf_date) {
>> >                         if (!line_end[0] || line_end[1] == '\n')
>> >                                 return; /* end of header */
>> >                         continue;
>> >                 }
>> > -               if (split_ident_line(&ident,
>> > -                                    buf + strlen("author "),
>> > -                                    line_end - (buf + strlen("author
>> > "))) ||
>> > +               if (split_ident_line(&ident, buf_date,
>> > +                                    line_end - buf_date) ||
>> >                     !ident.date_begin || !ident.date_end)
>> >                         goto fail_exit; /* malformed "author" line */
>> >                 break;
>> > @@ -1098,6 +1099,7 @@ int parse_signed_commit(const unsigned char *sha1,
>> >         char *buffer = read_sha1_file(sha1, &type, &size);
>> >         int in_signature, saw_signature = -1;
>> >         char *line, *tail;
>> > +       const char *gpg_sig;
>> >
>> >         if (!buffer || type != OBJ_COMMIT)
>> >                 goto cleanup;
>> > @@ -1113,9 +1115,9 @@ int parse_signed_commit(const unsigned char *sha1,
>> >                 next = next ? next + 1 : tail;
>> >                 if (in_signature && line[0] == ' ')
>> >                         sig = line + 1;
>> > -               else if (starts_with(line, gpg_sig_header) &&
>> > -                        line[gpg_sig_header_len] == ' ')
>> > -                       sig = line + gpg_sig_header_len + 1;
>> > +               else if ((gpg_sig = skip_prefix(line, gpg_sig_header))
>> > +                         && gpg_sig[0] == ' ')
>> > +                       sig = gpg_sig + 1;
>>
>> Other than the poor variable name 'buf_date' and the review comments
>> by Junio and Tanay that this particular change is of questionable
>> value and perhaps should be dropped, this version of the patch looks
>> reasonable.
>>
>> Thanks.
>>
>> >                 if (sig) {
>> >                         strbuf_add(signature, sig, next - sig);
>> >                         saw_signature = 1;
>> > @@ -1193,10 +1195,8 @@ static void parse_gpg_output(struct
>> > signature_check *sigc)
>> >         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> >                 const char *found, *next;
>> >
>> > -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1))
>> > {
>> > -                       /* At the very beginning of the buffer */
>> > -                       found = buf +
>> > strlen(sigcheck_gpg_status[i].check + 1);
>> > -               } else {
>> > +               found = skip_prefix(buf, sigcheck_gpg_status[i].check +
>> > 1);
>> > +               if (!found) {
>> >                         found = strstr(buf,
>> > sigcheck_gpg_status[i].check);
>> >                         if (!found)
>> >                                 continue;
>> > --
>> > 1.9.0.138.g2de3478
>> >
>
>
