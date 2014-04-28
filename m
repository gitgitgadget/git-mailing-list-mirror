From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 17/19] refs.c: change update_ref to use a transaction
Date: Mon, 28 Apr 2014 11:33:52 -0700
Message-ID: <CAL=YDWkk9aqDmAA4OAYd-eFNkdKoEdp8gS=n4VyMqAFpknU3Bg@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-18-git-send-email-sahlberg@google.com>
	<535AEFAF.9000908@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerJt-0001EJ-3N
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbaD1TeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:34:22 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:41583 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbaD1TeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:34:20 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq16so6350286vcb.11
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2I09lPJhhv8lqRSQ0iOxk3EO05WIdQ78e6gseUfr6gA=;
        b=FkJhZthRkZGJx/UMZmILbt7xmbXFC7kOG5JGJVcAsWuXDbAr8bQPQaqsXLGCVEWnuE
         jl1FHWgO5m7tvzZc0hOQwfu18wa7mr+tOr/4EAgmIeThKT69Fkx7ThnfVLguAZEV4frv
         J2DuDNsV2dArUf+L3zCakDrIKX6b98TQBRTEG+vcIWjWZudqOXbvEGE4bkJg0MeKE9c2
         j1PHbz9kyunuNUvIY5dE15jhXBmvM4zA7NLSZy+i6wtVeGfSFggZZDIFqU0DCBDkMuBw
         D8pkKmOLJr063SxU1NDkv5DeixzI5hy3xegc45w1jF2URbGkPZFNBJzRcS+iS9f+fR9Z
         QqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2I09lPJhhv8lqRSQ0iOxk3EO05WIdQ78e6gseUfr6gA=;
        b=kxoF0dxbXQ9g3K7Eem3/4UZpELa9Ac4gXaTyylZBHOkRTq3w3XKjifpPF0rATTC/IJ
         jwd2RPYYq9t4RUc0NbxX2q9ZKoXxwf6XJO4KHMtVDlNtyLiDZJqOZ/hOrM15N01vlAgc
         oUPcz0SMvFwFgmQrvrczZ8GXLjqP1zY1+rL9OtGJOytW1NNBXeHj2Iw0oVTgkx1rTuTK
         HmQzOmzt620jcJPn1PGWHQQOqr9KU/WjpzE3X5EAgHrenJ6N9PLVgvpMA8ezVRoarI4E
         Wl0SA5BGXyr88Gf4s1ImChCoxBldzhWj+rwgZLTmFCwcSnxXnW++Dk55J6S9FYBd2pVs
         GQXA==
X-Gm-Message-State: ALoCoQnYfOtD5e24SCdfGYewH1fJFOx0RCY6yUzXadsgd3BZM1JCA8u7nlAPu0NkZQ4FE/haNoZrErrrSY6eo9XnYRfW0FKL5dpd/TQ+GdlJC7esUpEUyzjHS8gALyL4WImj8Ws7aW15cV4rjYrRG66Wbou/ztJ/VSx9PDpxseTIJc8O+GLXP5M8pTwqvku1p+1JgofesTrH
X-Received: by 10.52.65.165 with SMTP id y5mr1275634vds.51.1398710033012; Mon,
 28 Apr 2014 11:33:53 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 11:33:52 -0700 (PDT)
In-Reply-To: <535AEFAF.9000908@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247411>

Thanks.

On Fri, Apr 25, 2014 at 4:28 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>> Change the update_ref helper function to use a ref transaction internally.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 1557c3c..95df4a9 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3397,11 +3397,26 @@ int update_ref(const char *action, const char *refname,
>>              const unsigned char *sha1, const unsigned char *oldval,
>>              int flags, enum action_on_err onerr)
>>  {
>> -     struct ref_lock *lock;
>> -     lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
>> -     if (!lock)
>> +     struct ref_transaction *t;
>> +     char *err = NULL;
>> +
>> +     t = ref_transaction_begin();
>> +     if ((!t ||
>> +         ref_transaction_update(t, refname, sha1, oldval, flags,
>> +                                !!oldval)) ||
>> +         (ref_transaction_commit(t, action, &err) && !(t = NULL))) {

This is transient code to just show how ugly this pattern becomes when
ref_transaction_commit()
implicitly also frees the transaction.

Later patches toward the end of the series will replace this with
something nicer.
Currently in this patch series I pass a pointer to pointer for the
transaction to _commit()
but that is perhaps not optimal either.
I will try and see how it would look if _commit would not free the
transaction at all
and the caller would always have to call ref_transaction_free() explicitely.


I am thinking of something like this :

   t = ref_transaction_begin();
   if ((!t ||
       ref_transaction_update(t, ...)) ||
       ref_transaction_commit(t, ...)) {
          ...something...
   }
   ref_transaction_free(t);


>
> You seem to have extra parentheses around the first || subexpression.
>
> You also don't need the parentheses around the && expression because &&
> binds more tightly than ||.
>
> But using "!(t = NULL)" in the middle of a conditional expression is
> pretty obscure.  I think you will change this in a later patch, so I
> will defer my comments.
>
>> +          const char *str = "update_ref failed for ref '%s': %s";
>
> Indentation error.

Fixed.

>
>> +
>> +             ref_transaction_rollback(t);
>> +             switch (onerr) {
>> +             case UPDATE_REFS_MSG_ON_ERR: error(str, refname, err); break;
>> +             case UPDATE_REFS_DIE_ON_ERR: die(str, refname, err); break;
>> +             case UPDATE_REFS_QUIET_ON_ERR: break;
>> +             free(err);
>> +             }
>>               return 1;
>> -     return update_ref_write(action, refname, sha1, lock, NULL, onerr);
>> +     }
>> +     return 0;
>>  }
>>
>>  static int ref_update_compare(const void *r1, const void *r2)
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
