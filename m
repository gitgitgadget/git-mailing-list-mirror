From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Sun, 9 Mar 2014 16:40:42 +0530
Message-ID: <CAOLa=ZQWREUTSnbm5-XM2yZLR3HXBEkENrHaOPzDFwDx2S3L=g@mail.gmail.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
 <CAPig+cR0tw4em_mPNLdp1-gNER2G1FyAVCyZAb9_TbtSyuGyaA@mail.gmail.com>
 <CAOLa=ZSjEv+p17--8UPN7=p+DfLWyEftjAXZDnxuaDKo96Lj7w@mail.gmail.com> <CAPig+cS9Eh7bde90SsVWqeWP+fZqDTV3fk6FryoP5SFg-FyfTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 12:11:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMbdp-0006k7-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 12:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbaCILLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2014 07:11:05 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59230 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaCILLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 07:11:03 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so6101683pbb.11
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pjwuDKJyZE7VPeI/POlMUoq1vDREHdImmUB8NqU9Hrc=;
        b=FjewDTmfx6dwoZ09FwLihYisWPdpos81HbFL17z9ukllPixPBSYnIwuivd2UBpq45G
         3DMvdpQo61bo8G3k9gZ7MCweSlAwzUPl6hO22d6/QcKCPWK9+6SOXlCSxOHjV6AISIGM
         +8K1oPMwTdOUr/zL16LUdoLIzXzhO74Ra2jpSXm3IOXCK1GS2/kvJ1Kcs8ZgL2mjdnN/
         S1w2uaIP45FIl6iOvra46NyeWCIP22yMDHIbb7gEeVNGC2F8aLtUjzr3IxbRy0Sq49ca
         5KzpeeqTzRzsRjJjjICKGfWRs5B0mWfTe6TibTPc84HdasJIci0SHLq7uZrLA1kbStbw
         c08g==
X-Received: by 10.68.163.197 with SMTP id yk5mr33609486pbb.57.1394363462331;
 Sun, 09 Mar 2014 04:11:02 -0700 (PDT)
Received: by 10.68.138.138 with HTTP; Sun, 9 Mar 2014 04:10:42 -0700 (PDT)
In-Reply-To: <CAPig+cS9Eh7bde90SsVWqeWP+fZqDTV3fk6FryoP5SFg-FyfTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243695>

Hey Eric,

Its been nice learning from you about how to submit patches to git.
was a nice learning curve, now I'm looking into the ideas and will contact the
appropriate mentor soon with a plan.

Thanks
- Karthik

On Sun, Mar 9, 2014 at 1:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 7, 2014 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
>> Hello Eric,
>> Thanks for your reply, and for that information.  should i patch again or
>> this should do?
>> And what next? Talk to the mentor?
>
> The ultimate authority deciding if a patch is ready is Junio, as it
> would have to be accepted into his tree. Since he already accepted a
> similar patch from a different potential GSoC applicant, it may not
> make sense to refine this one further. What is important is that you
> are now familiar with the review process on this project, and the
> mentors (hopefully) have gained insight into your abilities and how
> you interact with reviewers (which was the goal of these
> microprojects).
>
> Probably best at this point is to consider a proposed project [1] or
> choose your own, and start the task of applying for a GSoC position
> (by whatever means that is done).
>
> [1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Ideas.md
>
>> On Fri, Mar 7, 2014 at 3:04 PM, Eric Sunshine <sunshine@sunshineco.com>
>> wrote:
>>>
>>> On Thu, Mar 6, 2014 at 12:05 PM, Karthik Nayak <karthik.188@gmail.com>
>>> wrote:
>>> > Replace all instances of starts_with() by skip_prefix(),
>>> > which can not only be used to check presence of a prefix,
>>> > but also used further on as it returns the string after the prefix,
>>> > if the prefix is present. And also manages to do, what the current
>>> > code does in two steps.
>>>
>>> Better. Thanks.
>>>
>>> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> > ---
>>> > Hello Eric,
>>> > In this patch, I have:
>>> > 1. Fixed the improper placement of buf_date , initialised to a NULL
>>> > string.
>>> > 2. Fixed whitespace.
>>> > 3. Better naming as per your suggestion.
>>> > 4. Fixed the initilisation before the if statement.
>>> > Thanks for your suggestion.
>>> > ---
>>> >  commit.c | 22 +++++++++++-----------
>>> >  1 file changed, 11 insertions(+), 11 deletions(-)
>>> >
>>> > diff --git a/commit.c b/commit.c
>>> > index 6bf4fe0..4144e00 100644
>>> > --- a/commit.c
>>> > +++ b/commit.c
>>> > @@ -553,6 +553,7 @@ static void record_author_date(struct
>>> > author_date_slab *author_date,
>>> >         struct ident_split ident;
>>> >         char *date_end;
>>> >         unsigned long date;
>>> > +       const char *buf_date;
>>> >
>>> >         if (!commit->buffer) {
>>> >                 unsigned long size;
>>> > @@ -565,15 +566,15 @@ static void record_author_date(struct
>>> > author_date_slab *author_date,
>>> >         for (buf = commit->buffer ? commit->buffer : buffer;
>>> >              buf;
>>> >              buf = line_end + 1) {
>>> > +               buf_date = skip_prefix(buf, "author ");
>>>
>>> The data after "author " is identification information (name, email),
>>> not date. In fact, this information gets passed to the function
>>> split_ident_line(), so a better name for this variable is 'ident_line'
>>> (but not the misspelling 'indent_line' from one of your earlier
>>> attempts).
>>>
>>> >                 line_end = strchrnul(buf, '\n');
>>> > -               if (!starts_with(buf, "author ")) {
>>> > +               if (!buf_date) {
>>> >                         if (!line_end[0] || line_end[1] == '\n')
>>> >                                 return; /* end of header */
>>> >                         continue;
>>> >                 }
>>> > -               if (split_ident_line(&ident,
>>> > -                                    buf + strlen("author "),
>>> > -                                    line_end - (buf + strlen("author
>>> > "))) ||
>>> > +               if (split_ident_line(&ident, buf_date,
>>> > +                                    line_end - buf_date) ||
>>> >                     !ident.date_begin || !ident.date_end)
>>> >                         goto fail_exit; /* malformed "author" line */
>>> >                 break;
>>> > @@ -1098,6 +1099,7 @@ int parse_signed_commit(const unsigned char *sha1,
>>> >         char *buffer = read_sha1_file(sha1, &type, &size);
>>> >         int in_signature, saw_signature = -1;
>>> >         char *line, *tail;
>>> > +       const char *gpg_sig;
>>> >
>>> >         if (!buffer || type != OBJ_COMMIT)
>>> >                 goto cleanup;
>>> > @@ -1113,9 +1115,9 @@ int parse_signed_commit(const unsigned char *sha1,
>>> >                 next = next ? next + 1 : tail;
>>> >                 if (in_signature && line[0] == ' ')
>>> >                         sig = line + 1;
>>> > -               else if (starts_with(line, gpg_sig_header) &&
>>> > -                        line[gpg_sig_header_len] == ' ')
>>> > -                       sig = line + gpg_sig_header_len + 1;
>>> > +               else if ((gpg_sig = skip_prefix(line, gpg_sig_header))
>>> > +                         && gpg_sig[0] == ' ')
>>> > +                       sig = gpg_sig + 1;
>>>
>>> Other than the poor variable name 'buf_date' and the review comments
>>> by Junio and Tanay that this particular change is of questionable
>>> value and perhaps should be dropped, this version of the patch looks
>>> reasonable.
>>>
>>> Thanks.
>>>
>>> >                 if (sig) {
>>> >                         strbuf_add(signature, sig, next - sig);
>>> >                         saw_signature = 1;
>>> > @@ -1193,10 +1195,8 @@ static void parse_gpg_output(struct
>>> > signature_check *sigc)
>>> >         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>>> >                 const char *found, *next;
>>> >
>>> > -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1))
>>> > {
>>> > -                       /* At the very beginning of the buffer */
>>> > -                       found = buf +
>>> > strlen(sigcheck_gpg_status[i].check + 1);
>>> > -               } else {
>>> > +               found = skip_prefix(buf, sigcheck_gpg_status[i].check +
>>> > 1);
>>> > +               if (!found) {
>>> >                         found = strstr(buf,
>>> > sigcheck_gpg_status[i].check);
>>> >                         if (!found)
>>> >                                 continue;
>>> > --
>>> > 1.9.0.138.g2de3478
>>> >
>>
>>
