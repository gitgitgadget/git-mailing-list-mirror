From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/16] ref-filter: modify "%(objectname:short)" to take length
Date: Sat, 19 Mar 2016 00:08:09 +0530
Message-ID: <CAOLa=ZQCWk46cMy0A-wpquVtCUXL4Eyo_uVLqxQfnpqo9r1OhA@mail.gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
 <1458060436-1215-5-git-send-email-Karthik.188@gmail.com> <CA+P7+xofBUBOWLMdYi7V7Np00V0e7kcBgDDgjT-g4dnk2ag22g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 19:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agzIL-0002O5-1A
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 19:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbcCRSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 14:38:41 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35550 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbcCRSij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 14:38:39 -0400
Received: by mail-vk0-f48.google.com with SMTP id e6so152239064vkh.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EpyzKL9Hqu1Pl5LqjW7NyL4O2RLnjSYRxvP8jGK4n8o=;
        b=kwGuxW5ieIiP23LK+DXPDcRX7EfPtVmsx8yw/Wq5jJL7RtHSCpQw+E3/r3vINzXC9d
         af/n0IbiSdTRI2huH4RRDQd+e9iZXccBg7pDcpXo0+xSZDAfqpCdzFKNHk2WOADtl8BS
         SdEDxjLFJcHDJ7NdwUik7eJVrbJXfZBu64LK2sqtzxjwymPD4KhgbkU/bi4trARXFlOQ
         T6uhGRNEnr/6SiTmaCEIDYaC7cs6PGzvXILFzVJoNbxGLVwOKfgRkfdEHIHtyyvvgp2Y
         SkUcUWEhUasdMVSgBmBypKs+kToDILyVoK52RTtuyvinR5ch0QxUVTvz0de/e4MICZTT
         /isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EpyzKL9Hqu1Pl5LqjW7NyL4O2RLnjSYRxvP8jGK4n8o=;
        b=koa03rwnmWSh2E3Nll0rw/L84AziovrwC6w+Q/tXQ822VWUBmt8hrsudtGqUI8HVUm
         4CKMitJYDHcnvEjh/EjCCQbpd8N9/WGlAm1hzpxslBJuUhpmz4GyWCPW7a8geMnHELss
         gn/e/8jBwGuMud5yPUyAz1GBO8G3pJH7+bEjuM+dMHlGlAAQX6ucNnoR7UOgniJhQEhA
         C2Z7HUgtoacaY3AefDXypaKrzS5Gldp/H4FNOxZyYHr1JY9q4Vk1sc2Ixjrg4z5mM9MH
         8D/GrAbN5JdtYQLvw7sBYtTE0O9XBqRevuF5FcS1/GUrgdApyPQrqDW9WUO/SUSpZFAc
         MbTQ==
X-Gm-Message-State: AD7BkJIa51JiR1+I5oqPSC5YUh+NscVofnEGA+IxhvD/hNNdWNroPIruEtgGUeTmH84BwzdsKKeTF0EOQzPBcg==
X-Received: by 10.31.54.75 with SMTP id d72mr18331880vka.30.1458326318470;
 Fri, 18 Mar 2016 11:38:38 -0700 (PDT)
Received: by 10.103.112.68 with HTTP; Fri, 18 Mar 2016 11:38:09 -0700 (PDT)
In-Reply-To: <CA+P7+xofBUBOWLMdYi7V7Np00V0e7kcBgDDgjT-g4dnk2ag22g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289241>

Hello

On Wed, Mar 16, 2016 at 3:41 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Mar 15, 2016 at 9:47 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add support for %(objectname:short=<length>) which would print the
>> abbreviated unique objectname of given length. When no length is
>> specified 7 is used. The minimum length is 'MINIMUM_ABBREV'.
>>
>
> Isn't the default abbreviation value used here, not hard coded to 7?
> Thus user can configure this?
>

DEFAULT_ABBREV is set to 7. But I think it makes for sense to state
DEFAULT_ABBREV
rather than mention 7 without any base information.

> Description should also mention that length may be exceeded if it is
> not long enough to be a unique identifier.
>

Will add that in.

>> Add tests and documentation for the same.
>>
>
> Also I didn't see any update to the documentation here..

I totally missed that out, will add it in

>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c            | 25 +++++++++++++++++++------
>>  t/t6300-for-each-ref.sh | 10 ++++++++++
>>  2 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 857a8b5..17f781d 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -55,7 +55,10 @@ static struct used_atom {
>>                         const char *if_equals,
>>                                 *not_equals;
>>                 } if_then_else;
>> -               enum { O_FULL, O_SHORT } objectname;
>> +               struct {
>> +                       enum { O_FULL, O_LENGTH, O_SHORT } option;
>> +                       unsigned int length;
>> +               } objectname;
>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -118,10 +121,17 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
>>  static void objectname_atom_parser(struct used_atom *atom, const char *arg)
>>  {
>>         if (!arg)
>> -               atom->u.objectname = O_FULL;
>> +               atom->u.objectname.option = O_FULL;
>>         else if (!strcmp(arg, "short"))
>> -               atom->u.objectname = O_SHORT;
>> -       else
>> +               atom->u.objectname.option = O_SHORT;
>> +       else if (skip_prefix(arg, "short=", &arg)) {
>> +               atom->u.contents.option = O_LENGTH;
>> +               if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
>> +                   atom->u.objectname.length == 0)
>> +                       die(_("positive value expected objectname:short=%s"), arg);
>> +               if (atom->u.objectname.length < MINIMUM_ABBREV)
>> +                       atom->u.objectname.length = MINIMUM_ABBREV;
>
> Should this error instead of accepting and upgrading it to the minimum?
>

I prefer that it doesn't error out so that someone who's not aware of
the absolute
value of MINIMUM_ABBREV would still be able to give a value  which is
< MINIMUM_ABRREV
and still expect results.

>> +       } else
>>                 die(_("unrecognized %%(objectname) argument: %s"), arg);
>>  }
>>
>> @@ -591,12 +601,15 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
>>                            struct atom_value *v, struct used_atom *atom)
>>  {
>>         if (starts_with(name, "objectname")) {
>> -               if (atom->u.objectname == O_SHORT) {
>> +               if (atom->u.objectname.option == O_SHORT) {
>>                         v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>
> Yes, here we are using DEFAULT_ABBREV, so you should mention that
> instead of using 7 in the commit message.
>

Will do.

>>                         return 1;
>> -               } else if (atom->u.objectname == O_FULL) {
>> +               } else if (atom->u.objectname.option == O_FULL) {
>>                         v->s = xstrdup(sha1_to_hex(sha1));
>>                         return 1;
>> +               } else if (atom->u.objectname.option == O_LENGTH) {
>> +                       v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
>> +                       return 1;
>>                 } else
>>                         die("BUG: unknown %%(objectname) option");
>>         }
>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 19a2823..2be0a3f 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -60,6 +60,8 @@ test_atom head objecttype commit
>>  test_atom head objectsize 171
>>  test_atom head objectname $(git rev-parse refs/heads/master)
>>  test_atom head objectname:short $(git rev-parse --short refs/heads/master)
>> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
>> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>>  test_atom head tree $(git rev-parse refs/heads/master^{tree})
>>  test_atom head parent ''
>>  test_atom head numparent 0
>> @@ -99,6 +101,8 @@ test_atom tag objecttype tag
>>  test_atom tag objectsize 154
>>  test_atom tag objectname $(git rev-parse refs/tags/testtag)
>>  test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
>> +test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
>> +test_atom head objectname:short=10 $(git rev-parse --short=10 refs/heads/master)
>>  test_atom tag tree ''
>>  test_atom tag parent ''
>>  test_atom tag numparent ''
>> @@ -164,6 +168,12 @@ test_expect_success 'Check invalid format specifiers are errors' '
>>         test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
>>  '
>>
>> +test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
>> +       test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
>> +       test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
>> +       test_must_fail git for-each-ref --format="%(objectname:short=foo)"
>> +'
>> +
>>  test_date () {
>>         f=$1 &&
>>         committer_date=$2 &&
>> --
>> 2.7.3
>>

Thanks for your suggestions.

-- 
Regards,
Karthik Nayak
