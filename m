From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Tue, 31 May 2016 09:59:04 +0200
Message-ID: <574D4448.5020004@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <CAPig+cSjzZGUjdgkz1y7brGNb1M2gHfW0UG-wgBc00beNDQmnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 31 09:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ea2-00045Z-Am
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 09:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbcEaH7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 03:59:10 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:51166 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbcEaH7J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 03:59:09 -0400
X-AuditID: 12074413-487ff700000008c7-96-574d444b377c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4B.76.02247.B444D475; Tue, 31 May 2016 03:59:08 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V7x4Hp002209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 31 May 2016 03:59:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CAPig+cSjzZGUjdgkz1y7brGNb1M2gHfW0UG-wgBc00beNDQmnA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqOvj4htuMP88q8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxZk3jYwObB47Z91l93jWu4fR4+IlZY/FD7w8Fjy/z+7xeZNcAFsU
	t01SYklZcGZ6nr5dAnfGl6YJLAX/dSuefJjG3sD4QbmLkZNDQsBEYturm8xdjFwcQgJbGSUW
	rT7NAuFcYJJYsP87E0iVsICDxN3PTSwgtoiAtsSHDZsYQWwhgfOMEmffioI0MAu8ZpR4c7WZ
	HSTBJqArsainGayZF6hh4bTHQA0cHCwCqhInvvuChEUFQiTOr9vKClEiKHFy5hMWkBJOgUCJ
	R/vtQcLMAuoSf+ZdYoaw5SWat85mnsDIPwtJxywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxb
	nJyYl5dapGuul5tZopeaUrqJERLcwjsYd52UO8QowMGoxMPL0OkTLsSaWFZcmXuIUZKDSUmU
	1+o3UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIL4eDb7gQb0piZVVqUT5MSpqDRUmcV22Jup+Q
	QHpiSWp2ampBahFMVoaDQ0mCN8QZqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMe
	FJHxxcCYBEnxAO2VB2nnLS5IzAWKQrSeYjTm2LLgxlomjiP7761lEmLJy89LlRLnZXcCKhUA
	Kc0ozYNbBEtrrxjFgf4W5p0IMpAHmBLh5r0CWsUEtCo+wwdkVUkiQkqqgXHBpVNXj0yQi3m2
	Z85D19C++sD7kq8Fd3VfWvTjv6pS+QPxt5/Wat6eytYlrmN7gV0s4twnv8t7lFou 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295963>

On 05/31/2016 07:29 AM, Eric Sunshine wrote:
> On Mon, May 30, 2016 at 3:55 AM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>> [...]
> [...]
> Either:
>=20
>     s/false/something other than ITER_OK/
>=20
> or:
>=20
>     s/false/ITER_DONE or ITER_ERROR/

Thanks.

>> +int ref_iterator_advance(struct ref_iterator *ref_iterator);
>> +
>> +/*
>> + * An iterator over nothing (its first ref_iterator_advance() call
>> + * returns 0).
>> + */
>=20
> s/0/ITER_DONE/

Thanks. I guess you can guess what an earlier draft of this interface
looked like :-)

>> +struct ref_iterator *empty_ref_iterator_begin(void);
>> +
>> +/*
>> + * Return true iff ref_iterator is an empty_ref_iterator.
>> + */
>> +int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
>=20
> I can see that you used this function as an optimization or
> convenience in overlay_ref_iterator_begin(), but do you expect it to
> be generally useful otherwise? Is it worth publishing? Do you have
> other use-cases in mind?

It is only "published" within the refs module, in refs/refs-internal.h.
This header file is not meant to be used by code outside of the refs mo=
dule.

My thinking was that it might be useful to other reference backends. Th=
e
function is pretty safe for anybody to call, though I admit that it is
not very general.

I don't have a strong feeling either way. If nobody else chimes in, I'l=
l
remove it from the header file as you suggested. We can always add it
back if somebody needs it.

> Also, can you explain why the merge iterator doesn't also perform the
> optimization/convenience of checking if one iterator is an empty
> iterator?

That's because the merge iterator doesn't know what its select function
will do. For example, you could imagine an "intersect" select function
that only lets through references that were in *both* sub-iterators. In
that case, your suggested "optimization" would be incorrect.

Incidentally, that's also why I decided to leave the select function in
charge even after one or both of the sub-iterators is exhausted=E2=80=94=
because
it lets merge_ref_iterator implement more diverse behavior.

>> +/*
>> + * Iterate over the intries from iter0 and iter1, with the values
>=20
> s/intries/entries/

Thanks.

>> + * interleaved as directed by the select function. The iterator tak=
es
>> + * ownership of iter0 and iter1 and frees them when the iteration i=
s
>> + * over.
>> + */
>> +struct ref_iterator *merge_ref_iterator_begin(
>> +               struct ref_iterator *iter0, struct ref_iterator *ite=
r1,
>> +               ref_iterator_select_fn *select, void *cb_data);
>> +
>> +/*
>> + * An iterator consisting of the union of the entries from iter0 an=
d
>> + * iter1. If there are entries common to the two sub-iterators, use
>> + * the one from iter1. Each iterator must iterate over its entries =
in
>> + * strcmp() order by refname for this to work.
>> + *
>> + * The new iterator takes ownership of its arguments and frees them
>> + * when the iteration is over. As a convenience to callers, if iter=
0
>> + * or iter1 is_empty_ref_iterator(), then abort that one immediatel=
y
>> + * and return the other iterator directly, without wrapping it.
>> + */
>> +struct ref_iterator *overlay_ref_iterator_begin(struct ref_iterator=
 *iter0,
>> +                                               struct ref_iterator =
*iter1);
>=20
> When reading about the overlay iterator (both code and documentation)=
,
> my expectation was that iter0 would shadow iter1, not the other way
> around as implemented here. Of course, that's entirely subjective, bu=
t
> the generic names don't provide any useful clues as to which shadows
> which. Perhaps giving them more meaningful names would help.

That's a good idea. I also found myself having to refer back to the
documentation to remind myself which was which.

How about I rename them "back" and "front"? I will also reverse the
order of the arguments.

(But I will leave the names "iter0" and "iter1" in merge_ref_iterator,
and also the constants like ITER_SELECT_0, because these don't
necessarily have the interpretation of "back" and "front".)

>> +/*
>> + * Wrap iter0, only letting through the references whose names star=
t
>> + * with prefix. If trim is set, set iter->refname to the name of th=
e
>> + * reference with that many characters trimmed off the front;
>> + * otherwise set it to the full refname. The new iterator takes ove=
r
>> + * ownership of iter0 and frees it when iteration is over. It makes
>> + * its own copy of prefix.
>> + *
>> + * As an convenience to callers, if prefix is the empty string and
>> + * trim is zero, this function returns iter0 directly, without
>> + * wrapping it.
>> + */
>> +struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator =
*iter0,
>> +                                              const char *prefix,
>> +                                              int trim);
>=20
> Minor: Similarly, when reading the code and documentation, I wondered
> why this was named 'iter0' when no 'iter1' was in sight. Perhaps name
> it simply 'iter'.

I found that it got a little bit confusing, because the constructor and
method implementations all use `iter` as a local variable. In particula=
r
in the constructor there would want to be an argument "iter" and also
the local variable "iter" for the iterator being constructed, so a new
name would otherwise have to be invented for one or the other. Between
all the "iter" and "iter" and "iter->iter", I found that naming the
sub-iterator "iter0" made things a little bit less bewildering.

If you don't like that, we could name the embedded iterators something
like "subiter", "subiter0", and "subiter1". But the current convention
is a bit more succinct so I slightly prefer it.

Thanks for all your comments!

Michael
