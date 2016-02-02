From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 10/12] ref-filter: introduce remote_ref_atom_parser()
Date: Tue, 2 Feb 2016 08:29:07 +0530
Message-ID: <CAOLa=ZT_4XyTjFNWyRTOJwPO5KtrCDsr8aSo0hmE6GY53sP_cQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-11-git-send-email-Karthik.188@gmail.com> <20160202005902.GA1132@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 03:59:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQRBv-00039A-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 03:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbcBBC7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 21:59:39 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35932 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbcBBC7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 21:59:38 -0500
Received: by mail-vk0-f54.google.com with SMTP id n1so88901205vkb.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 18:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AFxKs8DBNJysXvIf0Gccb5peomw3sWELpx2KbUkXyts=;
        b=oSRa+NCguuFVF7xOy4mGu0Hyxjs99HThQoqWJydi3Jzc6AH/olhTqvkzru9XtwK7CV
         8ZxT/jYnKBkWVuZ0WM6ukZfuXmLm5bFpA5sL8onZvI0AbFcmXGDCRmhNektXir7lj9cy
         XepTi48dHbkGb/xQp5u1dJk+y3vj3mFVDFWeO+LZddrOIzwLcemRMflFgTAY/tsvbRgQ
         AjifCHsNKbaQVL3UiiOGNni7JnCYAgkCS1T5hpiNWtMMfnvyzXHGt+4GvIClcNnubqLz
         CdSw3Vmx7kkh5zh62t7DPtSOomwg/S/lDsV+2cVnkP926nNarksEEF9Kze0hfIuwkk8U
         hXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=AFxKs8DBNJysXvIf0Gccb5peomw3sWELpx2KbUkXyts=;
        b=FcNb7BmNn6pL2KqDqIoegx02SpcUZMYOs9JiyAkC3vDHsqdhk7uyraHTTM8Oe/oGcj
         C3L4crn7hp7wZhHQfLvRAq6zhbdUciNF/avSOUgEtv0TdVk4QaJecrqfi7zq7uKQWe/5
         AceUsJWQp73PbUtwGxmAzr4yFq06qpSYlpmczSySPmMbuZ2oA46WmUO6fcAm2HyqOAVH
         z6TshnHZ3QqkG+nAJOP5lPIPI8E75PNQAEpHe8KZ7ovLu0WElKbxNaGQDpCz3JOIXjOO
         gyV2+FKtBOhxfmATOn9W2oLuig30VyRaBttsQ/vOw0C+k0SMU7QnAc1PAIbOLxK49us7
         F0rg==
X-Gm-Message-State: AG10YOSoruPVI+pMM2r1v0Zo+NEitrvn7ZmyFz1J3MrDMf2v+I8gMCMJdk2gltL0A3ytuewAUIYgVL6sosSfuQ==
X-Received: by 10.31.16.37 with SMTP id g37mr17976404vki.97.1454381977234;
 Mon, 01 Feb 2016 18:59:37 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 1 Feb 2016 18:59:07 -0800 (PST)
In-Reply-To: <20160202005902.GA1132@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285233>

On Tue, Feb 2, 2016 at 6:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This is a re-send of patch 10/12 on Karthik's behalf to give other
> reviewers a chance at it. The original did not make it to the mailing
> list since it contained a rather large binary resource Karthik
> accidentally included in the commit (which has been stripped from
> this re-send).
>

Thanks a lot, wondering how that happened.

> On Sun, Jan 31, 2016 at 11:12:54PM +0530, Karthik Nayak wrote:
>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>> and '%(push)' atoms and store information into the 'used_atom'
>> structure based on the modifiers used along with the corresponding
>> atom.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  ref-filter.c  | 103 ++++++++++++++++++++++++++++++++++------------------------
>>  test-fake-ssh | Bin 0 -> 4668264 bytes
>>  2 files changed, 61 insertions(+), 42 deletions(-)
>>  create mode 100755 test-fake-ssh
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 58d433f..99c152d 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -37,6 +37,8 @@ static struct used_atom {
>>       union {
>>               char color[COLOR_MAXLEN];
>>               struct align align;
>> +             enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>> +                     remote_ref;
>>       } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -50,6 +52,20 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
>>               die(_("invalid color value: %s"), atom->u.color);
>>  }
>>
>> +static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +     if (!arg) {
>> +             atom->u.remote_ref = RR_NORMAL;
>> +     } else if (!strcmp(arg, "short"))
>> +             atom->u.remote_ref = RR_SHORTEN;
>> +     else if (!strcmp(arg, "track"))
>> +             atom->u.remote_ref = RR_TRACK;
>> +     else if (!strcmp(arg, "trackshort"))
>> +             atom->u.remote_ref = RR_TRACKSHORT;
>> +     else
>> +             die(_("unrecognized format: %%(%s)"), atom->name);
>> +}
>> +
>>  static align_type parse_align_position(const char *s)
>>  {
>>       if (!strcmp(s, "right"))
>> @@ -132,8 +148,8 @@ static struct {
>>       { "subject" },
>>       { "body" },
>>       { "contents" },
>> -     { "upstream" },
>> -     { "push" },
>> +     { "upstream", FIELD_STR, remote_ref_atom_parser },
>> +     { "push", FIELD_STR, remote_ref_atom_parser },
>>       { "symref" },
>>       { "flag" },
>>       { "HEAD" },
>> @@ -839,6 +855,43 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
>>       return start;
>>  }
>>
>> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>> +                                 struct branch *branch, const char **s)
>> +{
>> +     int num_ours, num_theirs;
>> +     if (atom->u.remote_ref == RR_SHORTEN)
>> +             *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
>> +     else if (atom->u.remote_ref == RR_TRACK) {
>> +             if (stat_tracking_info(branch, &num_ours,
>> +                                    &num_theirs, NULL))
>> +                     return;
>> +
>> +             if (!num_ours && !num_theirs)
>> +                     *s = "";
>> +             else if (!num_ours)
>> +                     *s = xstrfmt("[behind %d]", num_theirs);
>> +             else if (!num_theirs)
>> +                     *s = xstrfmt("[ahead %d]", num_ours);
>> +             else
>> +                     *s = xstrfmt("[ahead %d, behind %d]",
>> +                                  num_ours, num_theirs);
>> +     } else if (atom->u.remote_ref == RR_TRACKSHORT) {
>> +             if (stat_tracking_info(branch, &num_ours,
>> +                                    &num_theirs, NULL))
>> +                     return;
>> +
>> +             if (!num_ours && !num_theirs)
>> +                     *s = "=";
>> +             else if (!num_ours)
>> +                     *s = "<";
>> +             else if (!num_theirs)
>> +                     *s = ">";
>> +             else
>> +                     *s = "<>";
>> +     } else /* RR_NORMAL */
>> +             *s = refname;
>> +}
>> +
>>  /*
>>   * Parse the object referred by ref, and grab needed value.
>>   */
>> @@ -890,8 +943,9 @@ static void populate_value(struct ref_array_item *ref)
>>                       branch = branch_get(branch_name);
>>
>>                       refname = branch_get_upstream(branch, NULL);
>> -                     if (!refname)
>> -                             continue;
>> +                     if (refname)
>> +                             fill_remote_ref_details(atom, refname, branch, &v->s);
>> +                     continue;
>>               } else if (starts_with(name, "push")) {
>>                       const char *branch_name;
>>                       if (!skip_prefix(ref->refname, "refs/heads/",
>> @@ -902,6 +956,8 @@ static void populate_value(struct ref_array_item *ref)
>>                       refname = branch_get_push(branch, NULL);
>>                       if (!refname)
>>                               continue;
>> +                     fill_remote_ref_details(atom, refname, branch, &v->s);
>> +                     continue;
>>               } else if (starts_with(name, "color:")) {
>>                       v->s = atom->u.color;
>>                       continue;
>> @@ -943,7 +999,6 @@ static void populate_value(struct ref_array_item *ref)
>>
>>               formatp = strchr(name, ':');
>>               if (formatp) {
>> -                     int num_ours, num_theirs;
>>                       const char *arg;
>>
>>                       formatp++;
>> @@ -952,43 +1007,7 @@ static void populate_value(struct ref_array_item *ref)
>>                                                     warn_ambiguous_refs);
>>                       else if (skip_prefix(formatp, "strip=", &arg))
>>                               refname = strip_ref_components(refname, arg);
>> -                     else if (!strcmp(formatp, "track") &&
>> -                              (starts_with(name, "upstream") ||
>> -                               starts_with(name, "push"))) {
>> -
>> -                             if (stat_tracking_info(branch, &num_ours,
>> -                                                    &num_theirs, NULL))
>> -                                     continue;
>> -
>> -                             if (!num_ours && !num_theirs)
>> -                                     v->s = "";
>> -                             else if (!num_ours)
>> -                                     v->s = xstrfmt("[behind %d]", num_theirs);
>> -                             else if (!num_theirs)
>> -                                     v->s = xstrfmt("[ahead %d]", num_ours);
>> -                             else
>> -                                     v->s = xstrfmt("[ahead %d, behind %d]",
>> -                                                    num_ours, num_theirs);
>> -                             continue;
>> -                     } else if (!strcmp(formatp, "trackshort") &&
>> -                                (starts_with(name, "upstream") ||
>> -                                 starts_with(name, "push"))) {
>> -                             assert(branch);
>> -
>> -                             if (stat_tracking_info(branch, &num_ours,
>> -                                                     &num_theirs, NULL))
>> -                                     continue;
>> -
>> -                             if (!num_ours && !num_theirs)
>> -                                     v->s = "=";
>> -                             else if (!num_ours)
>> -                                     v->s = "<";
>> -                             else if (!num_theirs)
>> -                                     v->s = ">";
>> -                             else
>> -                                     v->s = "<>";
>> -                             continue;
>> -                     } else
>> +                     else
>>                               die("unknown %.*s format %s",
>>                                   (int)(formatp - name), name, formatp);
>>               }



-- 
Regards,
Karthik Nayak
