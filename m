From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/13] delete_ref(): move declaration to refs.h
Date: Tue, 9 Jun 2015 09:42:15 -0700
Message-ID: <CAGZ79kagxZLxFdf4QmiQr7qP6bPm_vZC8FbhmndC6O=AARrrNw@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu>
	<CAGZ79kYy3zUezRzAG3Uo7bDbLgJ7srj3F1k-ama1C44ZdbHr=Q@mail.gmail.com>
	<5576BBB1.5020903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 09 18:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MbV-0004nw-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbFIQmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 12:42:16 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36391 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbFIQmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:42:15 -0400
Received: by yked142 with SMTP id d142so10945487yke.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3URlHMZ5XsWlKJF4TAp+IbzIPAIxkfmIaNfUJ7P34qY=;
        b=AoNK/Few7E4+z5f/9iRu04Uior5A53HabCPv1HhuP2rY8C+o7mVpnLXPeiOpt1VsZp
         8f3Dle55QY6bjmmnkjK+Y28zeWu2DDxK+keTMEYSbHKCgjXl+NlNWlh2vHhmCfRIGiLQ
         /4thXTlmItPy1N1aBfZCEKfjOlHzxaQpNVnA/gf8Iuvd80o+TbqdJCHpr6WI9dXLjXkt
         eUWgcuF0rsL1p0XLPHu/ZgCbb95ViDdGHIaZ/1Y0V2Cr99DWD+1OSnmg3g5BNB6ZSTWw
         NnZBLDqHuBxqYyRwMn8oQddagBlhtgL/U7dLhI52XA76orOpe+fWO4pwGSoyV7SUWtRj
         CGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3URlHMZ5XsWlKJF4TAp+IbzIPAIxkfmIaNfUJ7P34qY=;
        b=bSIlc7FKJ4t9z3Lhi21cMUac2DBUjXi2Ri3k2QeV0F1Og+S3fnJc9w4tlyFdxtXAtP
         Io/uFbNvsWq59t9q6Ry3z3+43ygTMhJUj2Yubhj+oKZXK6vCe5KkEmDEnK/t2wY3XqR9
         EfErFMZM+iyRt9+ehksCb7gpJo5iKG6KrtR5d+g02A/9jCl3jLpkCYl6ACBlNxyytF/b
         oRTxp22/BuH75pOgGGh2QPIf9lbe28slstjB/ehZbNO4PpVr+iePlEIet4IA3oiBF1cq
         gmFh4G2IB+1B0rNw+Ba+9zu6iLdetnTnexdbyhzpdBF3y+wmTeA+yAete7HWx8wm9QAj
         2SZQ==
X-Gm-Message-State: ALoCoQmQnOramXWyAzD1DFSjEvnVuuw+wIMT7LW8o60zTh1KXRA8ViM47bu1OH7KsU77jKTl73aF
X-Received: by 10.170.117.142 with SMTP id j136mr26649120ykb.56.1433868135134;
 Tue, 09 Jun 2015 09:42:15 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Tue, 9 Jun 2015 09:42:15 -0700 (PDT)
In-Reply-To: <5576BBB1.5020903@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271201>

On Tue, Jun 9, 2015 at 3:10 AM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
> On 06/08/2015 06:43 PM, Stefan Beller wrote:
>> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>>> [...]
>>> +/*
>>> + * Delete the specified reference. If old_sha1 is non-NULL and not
>>> + * NULL_SHA1, then verify that the current value of the reference =
is
>>> + * old_sha1 before deleting it.
>>
>> And here I wondered what the distinction between NULL and non-NULL,
>> but NULL_SHA1
>> is and digging into the code, there is none. (As you can also see in
>> this patch above with
>>     (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
>> but when digging deeper, the !is_null_sha1(old_sha1) is an arbitrary
>> limitation (i.e.
>> ref_transaction_delete and ref_transaction_update don't differ betwe=
en
>> those two cases.)
>>
>> The distinction comes in at lock_ref_sha1_basic, where I think we ma=
y
>> want to get rid of
>> the is_null_sha1 check and depend on NULL/non-NULL as the difference
>> for valid and invalid
>> sha1's?
>
> I'm having a little trouble understanding your comment.
>
> The convention for ref_transaction_update() and friends is that
>
> * old_sha1 =3D=3D NULL
>
>   We don't care whether the reference existed prior to the
>   update, nor what its value was.
>
> * *old_sha1 is NULL_SHA1
>
>   (by which I mean that old_sha1 points at 20 zero bytes; I hope
>   that's clear even though NULL_SHA1 is not actually defined
>   anywhere): The reference must *not* have existed prior to the
>   update.

Ok that's what I was missing.

>
> * old_sha1 has some other value
>
>   The reference must have had that value prior to the update.
>
> lock_ref_sha1_basic() distinguishes between { NULL vs. NULL_SHA1 vs.
> other values } in the same way that ref_transaction_update() does.
>
> The delete_ref() function doesn't follow the same convention. It trea=
ts
> NULL and NULL_SHA1 identically, as "don't care".
>
> It probably makes sense to change delete_ref() use the same conventio=
n
> as ref_transaction_update(), but there are quite a few callers and I
> didn't have the energy to review them all as part of this patch serie=
s.
> So I left it unchanged and just documented the status quo better.
>
>> That said, do we want to add another sentence to the doc here saying
>> non-NULL and not
>> NULL_SHA1 are treated the same or is it clear enough?
>> With or without this question addressed:
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>
> In set notation,
>
>     "non-NULL" =3D
>         "non-NULL and not NULL_SHA1" =E2=88=AA
>         "non-NULL and equal to NULL_SHA1"
>
> The latter two are *not* treated the same, so I don't see how we can
> claim that "non-NULL" and "not NULL_SHA1" are treated the same. I mus=
t
> be misunderstanding you.
>
> Would it help if I changed the comment to
>
>     Delete the specified reference. If old_sha1 is non-NULL and not
>     NULL_SHA1, then verify that the current value of the reference is
>     old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
>     delete the reference it it exists, regardless of its old value.
>
> ?

This is very clear to me.

>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
