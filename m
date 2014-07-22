From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 02/12] wrapper.c: add a new function unlink_or_msg
Date: Tue, 22 Jul 2014 10:42:12 -0700
Message-ID: <CAL=YDWmHcy+Kf+gJLHyFK7bVjnD+bk7rX22jqHVFmTXoHDCEhQ@mail.gmail.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-3-git-send-email-sahlberg@google.com>
	<xmqqha2el2x5.fsf@gitster.dls.corp.google.com>
	<CAPc5daW_6bVg4B4GHA-HCRL7bzmLAdVOF2xOYa9aOOjze-zTdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9e4w-0001g4-7O
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 19:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbaGVRmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 13:42:14 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:33910 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432AbaGVRmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 13:42:13 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so14055637vcb.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GJtmKIuPHbrRDgLUufbFaciaAbd9TE/k+2lbCgzpEBg=;
        b=BI+QOoRNy/lFdscwOAPbqN5vpssHKVm31CTZ6E1mqFwUL3H6ztylC2DoW75FUb9t6Z
         cTFreZivIiVVN3HttKF7wcgMadec7747LMIHM4HjHuNLG30p4Bu2xJzA6dNGW3hO2AgR
         gu5ODH+hD/4HdWN/U+YvbxOzJjGU3c1LH4IuXNSsNFNE83A4qjc474BMJBbFvd7MrRsk
         B01CghBRWBXltrP1U996Vkm8v0RNPkGQUWeARkKykVvvoIDTQBXmwlUhK6Oyma34hiAS
         2N7pquCba4xqL1Mm0mdIaVsH2J0/OSfyoJei2EjUVWnlG3a7ATrVpifuxIWrKLLz2IYs
         JdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GJtmKIuPHbrRDgLUufbFaciaAbd9TE/k+2lbCgzpEBg=;
        b=m9e2blKxDoISqhRg46D0ka+orpdqhLL/XfUW+W09Thj2tG6VDVI8xA1j6UPWNxaOs7
         OeZshHctrgWYoEQsKvPnVD/TTCcsFqcBh9VsYDxTgifa7/g9WiMhGwiEeW+slIR9Nns3
         MZkdof21OCunXfE73lGXO7n9E0MKxZPyUE5lg8IBHJD5C4sMkMjN2SWQNPuhORKBmaPo
         c4E1NFatAg4T8c1Yt8ZuFkMsQ07AkMeY9tofBpR/W6F6NIuhFETlujj5PW5lCWta7IlX
         4XqWd+kTXs1H7RAbvL2bNAjkda3LpG3PoGKqoPwoWNV3ABmJVxGwUuZOWN3wt/ig29Lx
         2vNw==
X-Gm-Message-State: ALoCoQmKddAvoV8wDOd9wtVT4VJekxz5D0k8ZP9AIRk0iTN6kYKamyU5/SsqGkezLYaqY84QGPst
X-Received: by 10.52.228.40 with SMTP id sf8mr14586132vdc.78.1406050932307;
 Tue, 22 Jul 2014 10:42:12 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 22 Jul 2014 10:42:12 -0700 (PDT)
In-Reply-To: <CAPc5daW_6bVg4B4GHA-HCRL7bzmLAdVOF2xOYa9aOOjze-zTdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254025>

On Fri, Jul 18, 2014 at 3:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, the primary reason for this seems to be because you are going to handle
> multiple refs at a time, some of them might fail to lock due to this
> lowest-level
> helper to unlink failing, some others may fail to lock due to some other reason,
> and the user may want to be able to differentiate various modes of failure.
>
> But even if that were the case, would it be necessary to buffer the messages
> like this and give them all at the end? In the transaction code path,
> it is likely
> that you would be aborting the whole thing at the first failure, no?

Not necessarily.
I can think of reasons both for and against "abort on first failure".

One reason for the former could be if there are problems with multiple
refs in a single transaction.
It would be very annoying to have to do
$ git <some command>
   error: ref foo has a problem

$ <run command to fix the problem>
$ git <some sommand>     (try again)
   error: ref bar has a problem
...

And it might be more userfriendly if that instead would be
$ git <some command>
   error: ref foo has a problem
   error: ref bar has a problem
   ...

And get all the failures in one go instead of having to iterate.

The reason for the latter I think is it would be cleaner/simpler/...
to just have an "abort on first failure".


On the past discussions on the list I think I have heard voices for
both approaches.
I don't think we have all that many
multiple-refs-in-a-single-transaction yet in what is checked in so far
so I think we are practically still "abort on first error".

I personally do not know yet which approach is the best but would like
to keep the door open for the "try all and fail at the end".
That said, I do not feel all that strongly about this.
If you have strong feelings about this I can remove the unlink_or_msg
patch and rework the rest of the series to cope with it.


regards
ronnie sahlberg



>
> I dunno...
>
>
> On Fri, Jul 18, 2014 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>> ---
>>>  git-compat-util.h |  6 ++++++
>>>  wrapper.c         | 18 ++++++++++++++++++
>>>  2 files changed, 24 insertions(+)
>>>
>>> diff --git a/git-compat-util.h b/git-compat-util.h
>>> index b6f03b3..426bc98 100644
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -704,12 +704,18 @@ void git_qsort(void *base, size_t nmemb, size_t size,
>>>  #endif
>>>  #endif
>>>
>>> +#include "strbuf.h"
>>> +
>>>  /*
>>>   * Preserves errno, prints a message, but gives no warning for ENOENT.
>>>   * Always returns the return value of unlink(2).
>>>   */
>>>  int unlink_or_warn(const char *path);
>>>  /*
>>> + * Like unlink_or_warn but populates a strbuf
>>> + */
>>> +int unlink_or_msg(const char *file, struct strbuf *err);
>>> +/*
>>>   * Likewise for rmdir(2).
>>>   */
>>>  int rmdir_or_warn(const char *path);
>>> diff --git a/wrapper.c b/wrapper.c
>>> index 740e193..74a0cc0 100644
>>> --- a/wrapper.c
>>> +++ b/wrapper.c
>>> @@ -438,6 +438,24 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
>>>       return rc;
>>>  }
>>>
>>> +int unlink_or_msg(const char *file, struct strbuf *err)
>>> +{
>>> +     if (err) {
>>> +             int rc = unlink(file);
>>> +             int save_errno = errno;
>>> +
>>> +             if (rc < 0 && errno != ENOENT) {
>>> +                     strbuf_addf(err, "unable to unlink %s: %s",
>>> +                                 file, strerror(errno));
>>> +                     errno = save_errno;
>>> +                     return -1;
>>> +             }
>>> +             return 0;
>>> +     }
>>> +
>>> +     return unlink_or_warn(file);
>>> +}
>>
>> In general, I do not generally like to see messages propagated
>> upwards from deeper levels of the callchain to the callers to be
>> used later, primarily because that will easily make it harder to
>> localize the message-lego.
>>
>> For this partcular one, shouldn't the caller be doing
>>
>>         if (unlink(file) && errno != ENOENT) {
>>                 ... do its own error message ...
>>         }
>>
>> instead of calling any of the unlink_or_whatever() helper?
>>
>>
>>>  int unlink_or_warn(const char *file)
>>>  {
>>>       return warn_if_unremovable("unlink", file, unlink(file));
