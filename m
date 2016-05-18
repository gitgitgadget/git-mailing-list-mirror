From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Wed, 18 May 2016 16:15:55 +0530
Message-ID: <CAOLa=ZSeQ5ZEiBBRvw2vM7ngXGoeVRP8hv8-Hf3SJ65RfFWvLQ@mail.gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
 <xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
 <xmqqtwhwwp0c.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQ-XwEhTRwoNhrBH=NCQhpsHR=PfgtDrfJs23j6hkBWRA@mail.gmail.com>
 <xmqqinycv343.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 12:46:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2yzo-0004MM-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 12:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbcERKq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 06:46:27 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33676 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbcERKq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 06:46:26 -0400
Received: by mail-qg0-f67.google.com with SMTP id 90so3787736qgz.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4RzXrkq+h0Pvxhgd7OxSnNzl3GBmVUGnLtJopni1P/4=;
        b=hCLSD1whiwVc3uiCuTBw/m5gwtXpl36rrXMV8ivTBIGEoyWSIl9Gbdb0QsVCxYqlKG
         ORGsa4dWqaWHxDf4yQ7kI/UfB9DUm0nN3PytGR9gsltuj29Os+m/c05xbDwdLpjq/rro
         ILSsUQEZRx2KzlW1FoVUqSXTvIfQhergOi7w7gkBvfPOD+1u2xJVsFe6lb9oRW2BqRWw
         kufALVspPzcxcHGmJ9yXehAZJQeBsI7pWxBX3gDEWgN5ELsyNHk8hzHoLifsgFaFoPnZ
         YDIy4HDqSObPYcHMf9voYXEAzH388rIbfolmBUfj2/scqPCuEsLsRohYcoqsTOEpzJ9D
         bKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4RzXrkq+h0Pvxhgd7OxSnNzl3GBmVUGnLtJopni1P/4=;
        b=mvpwK7B9Qb19OI12kc8Y+UjGmi0X659YAQboAJQP5QfjpkPpO8rKKp/XW/2sZrMDei
         7z9OVu0BLJu9XSKJ5nydHEQVdthHSxnbohLRfGiEYyp1MGKfXPr2rIua7r/avAhks4sV
         +L/LrcNZiJSsKxoZStN1SAEdpgdv8aNDo8N9zy5kGnmfibRuWEH9yaNNw01ZWCUiq3fW
         +CoG1SZeUSMBwjLkPh/di0Hhavl1M1DxajyxiKWzO7mWDvTLACql/kdBIzBnBvHa80g2
         WFoby91XqDN2Tl1W8XxJxQa7PAOgoC9a3k0BKOSukIz2YXX2e3LookO43c+M1SZbe5Bv
         hBOg==
X-Gm-Message-State: AOPr4FWg/KbOwuaLRi49/fqutW4u4AaB93gzbOUuvOQPJJtcglTv8Y7x8q6lxHNO/oMvfeMKzOFpFOnMQEMdQA==
X-Received: by 10.140.204.212 with SMTP id z203mr2154561qha.41.1463568385322;
 Wed, 18 May 2016 03:46:25 -0700 (PDT)
Received: by 10.140.92.178 with HTTP; Wed, 18 May 2016 03:45:55 -0700 (PDT)
In-Reply-To: <xmqqinycv343.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294939>

On Wed, May 18, 2016 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Sorry for that.
>> The only reason I haven't based it on 'master' is because it doesn't=
 contain
>> 'f307218'.
>>
>> =E2=9E=94 git branch --contains=3Df307218
>>   next
>>   ref-filter
>
> It is not clear from the above what your local ref-filter contains
> beyond 'master', so it is not very useful to me when I am trying to
> help you to avoid taking this topic hostage to all the topics in
> 'next' (if I queued this directly on 'next', I have to hold this
> series until all the topics in 'next' graduates to 'master).
>
> The series certainly would not apply to f307218 at all; it depends
> on other stuff you have either in your local 'ref-filter' or 'next'.
> It does not apply to the result of a merge of 'es/test-gpg-tags' topi=
c
> into 'master', either, but the above does not make it clear what
> else you are using from 'next' at all.
>
> In any case, I think I managed to reduce the dependency on only
> 'es/test-gpg-tags' and 'master', and that is what I'll be queuing.
> Please double check the patches in kn/ref-filter-branch-list topic
> and also the merge of it into 'pu' for mismerges.
>
> The difference between the result of merging the previously queued
> one to 'pu', and the result of merging this round to 'pu', looks
> like the attached.
>
> Thanks.
>
>  builtin/branch.c               |  2 +-
>  ref-filter.c                   |  6 ++++--
>  t/t6302-for-each-ref-filter.sh | 30 +++++++++++++++---------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0bbb4de..2412738 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -293,7 +293,7 @@ static int calc_maxwidth(struct ref_array *refs, =
int remote_bonus)
>                 skip_prefix(it->refname, "refs/remotes/", &desc);
>                 if (it->kind =3D=3D FILTER_REFS_DETACHED_HEAD) {
>                         char *head_desc =3D get_head_description();
> -                       w =3D strlen(head_desc);
> +                       w =3D utf8_strwidth(head_desc);
>                         free(head_desc);
>                 } else
>                         w =3D utf8_strwidth(desc);
> diff --git a/ref-filter.c b/ref-filter.c
> index 74c4869..f25671c 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1196,12 +1196,14 @@ char *get_head_description(void)
>                 strbuf_addf(&desc, _("(no branch, bisect started on %=
s)"),
>                             state.branch);
>         else if (state.detached_from) {
> -               /* TRANSLATORS: make sure these match _("HEAD detache=
d at ")
> -                  and _("HEAD detached from ") in wt-status.c */
>                 if (state.detached_at)
> +                       /* TRANSLATORS: make sure this matches
> +                          "HEAD detached at " in wt-status.c */
>                         strbuf_addf(&desc, _("(HEAD detached at %s)")=
,
>                                 state.detached_from);
>                 else
> +                       /* TRANSLATORS: make sure this matches
> +                          "HEAD detached from " in wt-status.c */
>                         strbuf_addf(&desc, _("(HEAD detached from %s)=
"),
>                                 state.detached_from);
>         }
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-fi=
lter.sh
> index 331d978..a09a1a4 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -342,22 +342,22 @@ test_expect_success 'improper usage of %(if), %=
(then), %(else) and %(end) atoms'
>  '
>
>  test_expect_success 'check %(if)...%(then)...%(end) atoms' '
> -       git for-each-ref --format=3D"%(if)%(authorname)%(then)%(autho=
rname): %(refname)%(end)" >actual &&
> +       git for-each-ref --format=3D"%(refname)%(if)%(authorname)%(th=
en) Author: %(authorname)%(end)" >actual &&
>         cat >expect <<-\EOF &&
> -       A U Thor: refs/heads/master
> -       A U Thor: refs/heads/side
> -       A U Thor: refs/odd/spot
> -
> -
> -
> -       A U Thor: refs/tags/foo1.10
> -       A U Thor: refs/tags/foo1.3
> -       A U Thor: refs/tags/foo1.6
> -       A U Thor: refs/tags/four
> -       A U Thor: refs/tags/one
> -
> -       A U Thor: refs/tags/three
> -       A U Thor: refs/tags/two
> +       refs/heads/master Author: A U Thor
> +       refs/heads/side Author: A U Thor
> +       refs/odd/spot Author: A U Thor
> +       refs/tags/annotated-tag
> +       refs/tags/doubly-annotated-tag
> +       refs/tags/doubly-signed-tag
> +       refs/tags/foo1.10 Author: A U Thor
> +       refs/tags/foo1.3 Author: A U Thor
> +       refs/tags/foo1.6 Author: A U Thor
> +       refs/tags/four Author: A U Thor
> +       refs/tags/one Author: A U Thor
> +       refs/tags/signed-tag
> +       refs/tags/three Author: A U Thor
> +       refs/tags/two Author: A U Thor
>         EOF
>         test_cmp expect actual
>  '
>

Seems to be right, Thanks for putting in the extra effort, Will ensure
this doesn't
happen again from my side.

--=20
Regards,
Karthik Nayak
