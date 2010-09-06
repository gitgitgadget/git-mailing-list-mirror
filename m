From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/15] gettextize: git-revert messages using the "me" variable
Date: Mon, 6 Sep 2010 20:12:19 +0000
Message-ID: <AANLkTi=8VXBFW7jzUe4EuCd+i221zRUt6LHGBYG8FQya@mail.gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
	<1283775704-29440-14-git-send-email-avarab@gmail.com>
	<20100906185023.GE25426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osi3H-0000L4-S1
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0IFUMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:12:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42684 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0IFUMW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:12:22 -0400
Received: by iwn5 with SMTP id 5so4546812iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bIpqeoQDTua2IvmiNzjtSKvpiIvPpNykPcPATbSrnQg=;
        b=XGhG0XOWFarFPBmz6QezAFKV5YWYftBzEGsFUvjWu0yZkgBfvZM0OQftSlc7g0MojY
         dgrhzlRup9btT0HaQauZbCjNpmHmOgmioo1RrTtPWDIIyh175SMa7Yb+lc1wPlyyvKRD
         S8qyPc8cDYpnWl61NjysxxIMVev4tXhuucdcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sHRS++sIn+j3hfnzwsADXX1QRV10luZyObPKuKeu/L/laPryQB0dxFCbUGnHFWzek1
         +hGsKCH9OgR38hiIqmPVHVXV+ZKf039eUFDgDkmM/Vul49FfnlpajgJC0nC+CNpFwohy
         4VmHJMBXDnMC9ZynyS2pjvZqfZK/Xe5vN3Wwg=
Received: by 10.231.170.79 with SMTP id c15mr6731308ibz.82.1283803939231; Mon,
 06 Sep 2010 13:12:19 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 13:12:19 -0700 (PDT)
In-Reply-To: <20100906185023.GE25426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155609>

On Mon, Sep 6, 2010 at 18:50, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> (+cc: Christian, de facto cherry-pick maintainer)

Thanks. In most cases I haven't been CC-ing people,

a) because I'd probably end up CC-ing everyone who ever touched git

b) the nature of the changes probalby doesn't especially benefit from
   me bothering all these people. But maybe that's the wrong assumption=
=2E

But by all means add more people to the CC :)

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Mark messages that used the "me" variable for translation. The
>> potential values of the variable had already been marked using N_(),
>> so we can use _(me) here.
>
> Ah, now I understand better. =C2=A0Would it be possible to squash thi=
s
> patch with the previous one (for clarity)?

And now I see the reply I just sent off was useless, oh well, that's
what I get for reading things sequentially :)

Sure, it can be squashed. I'm just trying to keep things as granular
as possible, but maybe I'm overshooting it in some cases.

>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -286,10 +286,10 @@ static NORETURN void die_dirty_index(const cha=
r *me)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_resolve_conflic=
t(me);
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (advice_commit_b=
efore_merge)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("Your local changes would be overwritten by %s.\n"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Please, commit your changes or stash them to proceed=
=2E", me);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Your local changes would be overwritten by %s.\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "Please, commit your changes or stash them to proceed=
=2E"), _(me));
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("Your local changes would be overwritten by %s.\n", me);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Your local changes would be overwritten by %s.\n"), _(me));
>
> Good.
>
>> @@ -339,7 +339,7 @@ static int do_recursive_merge(struct commit *bas=
e, struct commit *next,
>> =C2=A0 =C2=A0 =C2=A0 if (active_cache_changed &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (write_cache(index_fd, active_cac=
he, active_nr) ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_locked_index(&index_=
lock)))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("%s: Unable to write=
 new index file", me);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("%s: Unable to wri=
te new index file"), _(me));
>
> Not good, in my opinion. =C2=A0The dialogue ought to look like this, =
I think:
>
> =C2=A0$ git cherry-pick astermay
> =C2=A0...
> =C2=A0fatal: cherry-pick: Unableway otay itewray ewnay indexway ilefa=
y
>
>> @@ -446,8 +446,8 @@ static int do_pick_commit(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fast_forward=
_to(commit->object.sha1, head);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (parent && parse_commit(parent) < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("%s: cannot parse pa=
rent commit %s",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 me, sha1_t=
o_hex(parent->object.sha1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("%s: cannot parse =
parent commit %s"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(me), sha=
1_to_hex(parent->object.sha1));
>
> Likewise.
>
>> @@ -570,7 +570,7 @@ static int revert_or_cherry_pick(int argc, const=
 char **argv)
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 if (read_cache() < 0)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("git %s: failed to r=
ead the index", me);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("git %s: failed to=
 read the index"), _(me));
>
> Likewise.

I don't know if all of the above hold true, e.g. because some
languages will always transliterate things, even proper nouns.

But as mentioned before the string is probably being used in too many
different contexts for it to be useful to them.

> With the exceptions mentioned above,

So I should probably just skip translating the "me" variable for now. I=
=2Ee.
this and the last patch can probably be dropped.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
