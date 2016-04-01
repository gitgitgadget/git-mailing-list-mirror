From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 13/16] ref-filter: allow porcelain to translate
 messages in the output
Date: Sat, 2 Apr 2016 00:30:27 +0530
Message-ID: <CAOLa=ZQjxmVHuXc0fZioe9OLi9vjNwgHQq-8vf1opWxbuedM9Q@mail.gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459330800-12525-14-git-send-email-Karthik.188@gmail.com> <xmqqa8lfsk5e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4Jb-0002JH-8u
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbcDATA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:00:58 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35643 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbcDATA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:00:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id o6so42110725qkc.2
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c5R6XUYnmchcbnNhH8Oat9fzS9dIzpZ2VEuRXDkFZCg=;
        b=R7P56UcKpgsZ1ojJPh1p4fSp8wpPZ2iHu9+jjZZAIKcrNc1nw3+qf7dYzZ5MliI9ro
         fOe9UKZvlEGykDPm4xK4TJjBovv5wO3Pz3Y3MLBzqOLK7gSFGZ67/A2dZQ/rJ0AOBjxg
         N5y60jgh1gD9+Bth+Khy2GUxUMsLUINcIn/HOqyfVtWCu86uK80DiCVjZQmKBcACOt3g
         Egl95Ox8cn8NR3nsvAQeyaqKrND00uLJcCUHMAQcuJHKGDykTf+xZvl6turnRi5lCIw/
         AsYDYfTMI3oRRRj6Z8zDjozNLPWbVjDGPVN/RZTNNebMUwNdq40GWUHqKLK+hvj4PfK+
         1oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c5R6XUYnmchcbnNhH8Oat9fzS9dIzpZ2VEuRXDkFZCg=;
        b=KRjRXr4vwilUSeQZ+VQJz78VOzmkkZQ/oPmMDdqIEGDiMKBtr/3b3H1sMDETGhDciD
         wM8ijInlUGfmYtwX4GxIXNLljr0QGY1GP6VlJCij3gN119PRBoaLdH9jYqEo7lK8dZ4H
         2KpZ1kZvTDlpoMv+2lLJv6dftUEsNozDufcfZEIs3LwkHcE6aR37yuxf/gak2RDNMFRm
         9mAhKuuWpWSiBnxyK/LIO4wcZAxpA7+7Fd4SWfr//xtOFbhD1XrRC3HUBzOJE6gYAp0c
         3lGYNCrAmmFY11OTX87zhqTfmVBHh6sWicVCL+YAA5GH6XoUS+/uoOs3YxadcRReTjgt
         uJsA==
X-Gm-Message-State: AD7BkJKKujBgbzJN+2HxYPDjg0eSL1KN4ZSq3gyw/b6raFnTA7OWtg8epbMj33wM9lR31R6WyA1anLPnmATuag==
X-Received: by 10.55.72.85 with SMTP id v82mr20262929qka.105.1459537256923;
 Fri, 01 Apr 2016 12:00:56 -0700 (PDT)
Received: by 10.140.18.85 with HTTP; Fri, 1 Apr 2016 12:00:27 -0700 (PDT)
In-Reply-To: <xmqqa8lfsk5e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290573>

cc'ing Matthieu since this patch was initially written by him.

On Thu, Mar 31, 2016 at 3:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static struct ref_msg {
>> +     const char *gone;
>> +     const char *ahead;
>> +     const char *behind;
>> +     const char *ahead_behind;
>> +} msgs = {
>> +     "gone",
>> +     "ahead %d",
>> +     "behind %d",
>> +     "ahead %d, behind %d"
>> +};
>> +
>> +void setup_ref_filter_porcelain_msg(void)
>> +{
>> +     msgs.gone = _("gone");
>> +     msgs.ahead = _("ahead %d");
>> +     msgs.behind = _("behind %d");
>> +     msgs.ahead_behind = _("ahead %d, behind %d");
>> +}
>
> I do not think this patch is wrong, but I wonder if it would be
> sufficient to have a single bit in file-scope static variable and
> flip it in setup_ref_filter_porcelain_msg().  I.e.
>
>         static int use_porcelain_msg; /* false by default */
>
>         void setup_ref_filter_porcelain_msg(void)
>         {
>                 use_porcelain_msg = 1;
>         }
>
>         static const char *P_(const char *msg)
>         {
>                 return use_porcelain_msg ? _(msg) : msg;
>         }
>
> and then mark the message up perhaps like so:
>
>         -       *s = xstrdup("gone");
>         +       *s = xstrdup(P_("gone"));
>
> which may make things much simpler.
>
> We'd need to update Makefile to recognize X_() as another keyword;
> I'd think something like this should do:
>
>          XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>         -        --keyword=_ --keyword=N_ --keyword="Q_:1,2"
>         +        --keyword=_ --keyword=N_ --keyword=P_ --keyword="Q_:1,2"
>
>
>>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>
>>  struct align {
>> @@ -1097,15 +1117,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>>       else if (atom->u.remote_ref.option == RR_TRACK) {
>>               if (stat_tracking_info(branch, &num_ours,
>>                                      &num_theirs, NULL)) {
>> -                     *s = xstrdup("gone");
>> +                     *s = xstrdup(msgs.gone);
>>               } else if (!num_ours && !num_theirs)
>>                       *s = "";
>>               else if (!num_ours)
>> -                     *s = xstrfmt("behind %d", num_theirs);
>> +                     *s = xstrfmt(msgs.behind, num_theirs);
>>               else if (!num_theirs)
>> -                     *s = xstrfmt("ahead %d", num_ours);
>> +                     *s = xstrfmt(msgs.ahead, num_ours);
>>               else
>> -                     *s = xstrfmt("ahead %d, behind %d",
>> +                     *s = xstrfmt(msgs.ahead_behind,
>>                                    num_ours, num_theirs);
>>               if (!atom->u.remote_ref.nobracket && *s[0]) {
>>                       const char *to_free = *s;
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 0014b92..da17145 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -111,5 +111,7 @@ struct ref_sorting *ref_default_sorting(void);
>>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>>  /*  Get the current HEAD's description */
>>  char *get_head_description(void);
>> +/*  Set up translated strings in the output. */
>> +void setup_ref_filter_porcelain_msg(void);
>>
>>  #endif /*  REF_FILTER_H  */

I'm not totally knowledgeable  about how porcelain works, although
Matthieu did give me a
brief explanation. I guess it'd better to hear his thoughts on this.
For me both the current patch
and your suggestion, seem good to go.

-- 
Regards,
Karthik Nayak
