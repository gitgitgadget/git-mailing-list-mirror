From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/14] numparse: new module for parsing integral numbers
Date: Wed, 18 Mar 2015 23:47:39 +0100
Message-ID: <550A008B.3050900@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>	<1426608016-2978-2-git-send-email-mhagger@alum.mit.edu> <CAPig+cTyCS2-gys0MQSsA4K_k2gnGRvitXzDybyhO5q41OMD_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYMkj-0004mm-Df
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 23:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbCRWrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 18:47:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53458 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992AbbCRWrr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 18:47:47 -0400
X-AuditID: 12074413-f79f26d0000030e7-f8-550a008e30ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.D1.12519.E800A055; Wed, 18 Mar 2015 18:47:42 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96AE4.dip0.t-ipconnect.de [79.201.106.228])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2IMldpT014150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Mar 2015 18:47:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <CAPig+cTyCS2-gys0MQSsA4K_k2gnGRvitXzDybyhO5q41OMD_w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqNvHwBVq8H4Pq0XXlW4mi4beK8wW
	j29NYLI486aR0YHFY+59S4+Ll5Q9Fj/w8vi8SS6AJYrbJimxpCw4Mz1P3y6BO+PWzFb2gtUu
	Fb3zVrE3MJ4w7mLk5JAQMJH4+H0+I4QtJnHh3nq2LkYuDiGBy4wSm+fcZYFwLjBJNG3dwgZS
	xSugLfH/7FYwm0VAVeL5+h4wm01AV2JRTzMTiC0qECTx8tZfRoh6QYmTM5+wgNgiQL0fNmwC
	izMLZEkc/3AZzBYW8JH4ee8w1LIDjBJXjy0BG8opEChx5dMWZogGdYk/8y5B2fISzVtnM09g
	FJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESzsI7
	GHedlDvEKMDBqMTDK3GVI1SINbGsuDL3EKMkB5OSKG/DD85QIb6k/JTKjMTijPii0pzU4kOM
	EhzMSiK8ZSeAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd6S/0CN
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBojS8GxitIigdorxlIO29xQWIuUBSi
	9RSjopQ4rwtIQgAkkVGaBzcWlqReMYoDfSnMGw1SxQNMcHDdr4AGMwENbmlnAxlckoiQkmpg
	LGRNrIp2vL1jDmv7LuczZv87Zm9UTzowd16vIZcRj0GImoh74jXNuQWTD3hL3X4ovfP6tqPn
	OdhnbBdVjW66OG1PhHvfjNebZWK63NKCP/yzdAluUQr7vy56q1zGiU0/q6T3b7n4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265770>

On 03/18/2015 07:27 PM, Eric Sunshine wrote:
> On Tuesday, March 17, 2015, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Implement wrappers for strtol() and strtoul() that are safer and more
>> convenient to use.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> diff --git a/numparse.c b/numparse.c
>> new file mode 100644
>> index 0000000..90b44ce
>> --- /dev/null
>> +++ b/numparse.c
>> @@ -0,0 +1,180 @@
>> +int parse_l(const char *s, unsigned int flags, long *result, char **endptr)
>> +{
>> +       long l;
>> +       const char *end;
>> +       int err = 0;
>> +
>> +       err = parse_precheck(s, &flags);
>> +       if (err)
>> +               return err;
>> +       /*
>> +        * Now let strtol() do the heavy lifting:
>> +        */
> 
> Perhaps use a /* one-line style comment */ to reduce vertical space
> consumption a bit, thus make it (very slightly) easier to run the eye
> over the code.

Yes, will change.

>> +       errno = 0;
>> +       l = strtol(s, (char **)&end, flags & NUM_BASE_MASK);
>> +       if (errno) {
>> +               if (errno == ERANGE) {
>> +                       if (!(flags & NUM_SATURATE))
>> +                               return -NUM_SATURATE;
>> +               } else {
>> +                       return -NUM_OTHER_ERROR;
>> +               }
>> +       }
> 
> Would it reduce cognitive load slightly (and reduce vertical space
> consumption) to rephrase the conditionals as:
> 
>     if (errno == ERANGE && !(flags & NUM_SATURATE))
>         return -NUM_SATURATE;
> 
>     if (errno && errno != ERANGE)
>         return -NUM_OTHER_ERROR;
> 
> or something similar?

The most common case by far should be that errno is zero. The code as
written only needs one test for that case, whereas your code needs two
tests. I think it is worth compromising on code clarity a tiny bit to
avoid the extra test.

> More below.
> 
>> +       if (end == s)
>> +               return -NUM_NO_DIGITS;
>> +
>> +       if (*end && !(flags & NUM_TRAILING))
>> +               return -NUM_TRAILING;
>> +
>> +       /* Everything was OK */
>> +       *result = l;
>> +       if (endptr)
>> +               *endptr = (char *)end;
>> +       return 0;
>> +}
>> diff --git a/numparse.h b/numparse.h
>> new file mode 100644
>> index 0000000..4de5e10
>> --- /dev/null
>> +++ b/numparse.h
>> @@ -0,0 +1,207 @@
>> +#ifndef NUMPARSE_H
>> +#define NUMPARSE_H
>> +
>> +/*
>> + * Functions for parsing integral numbers.
>> + *
>> + * Examples:
>> + *
>> + * - Convert s into a signed int, interpreting prefix "0x" to mean
>> + *   hexadecimal and "0" to mean octal. If the value doesn't fit in an
>> + *   unsigned int, set result to INT_MIN or INT_MAX.
> 
> Did you mean s/unsigned int/signed int/ ?

Thanks for catching this. I will fix it.

>> + *
>> + *     if (convert_i(s, NUM_SLOPPY, &result))
>> + *             die("...");
>> + */
>> +
>> +/*
>> + * The lowest 6 bits of flags hold the numerical base that should be
>> + * used to parse the number, 2 <= base <= 36. If base is set to 0,
>> + * then NUM_BASE_SPECIFIER must be set too; in this case, the base is
>> + * detected automatically from the string's prefix.
> 
> Does this restriction go against the goal of making these functions
> convenient, even while remaining strict? Is there a strong reason for
> not merely inferring NUM_BASE_SPECIFIER when base is 0? Doing so would
> make it consistent with strto*l() without (I think) introducing any
> ambiguity.

I thought about doing this. If it were possible to eliminate
NUM_BASE_SPECIFIER altogether, then there is no doubt that it would be a
good change. But NUM_BASE_SPECIFIER also has an effect when base==16;
namely, that an "0x" prefix, if present, is consumed. So

    parse_i("0xff", 16 | NUM_BASE_SPECIFIER, &result, &endptr)

gives result==255 and endptr==s+4, whereas

    parse_i("0xff", 16, &result, &endptr)

gives result==0 and entptr==s+1 (it treats the "x" as the end of the
string).

We could forgo that feature, effectively allowing a base specifier if
and only if base==0. But I didn't want to rule out allowing an optional
base specifier for base==16, in which case NUM_BASE_SPECIFIER can't be
dispensed with entirely.

If you agree with that, then the remaining question is: which policy is
less error-prone? My thinking was that forcing the caller to specify
NUM_BASE_SPECIFIER explicitly when they select base==0 will serve as a
reminder that the two features are intertwined. Because another
imaginable policy (arguably more consistent with the policy for base!=0)
would be that

    convert_i(s, 0, &result)

, because it *doesn't* specify NUM_BASE_SPECIFIER, doesn't allow a base
prefix, and therefore indirectly only allows base-10 numbers.

But I don't feel strongly about this.

>> + */
>> +/*
>> + * Number parsing functions:
>> + *
>> + * The following functions parse a number (long, unsigned long, int,
>> + * or unsigned int respectively) from the front of s, storing the
>> + * value to *result and storing a pointer to the first character after
>> + * the number to *endptr. flags specifies how the number should be
>> + * parsed, including which base should be used. flags is a combination
>> + * of the numerical base (2-36) and the NUM_* constants above (see).
> 
> "(see)" what?

That was meant to be a pointer to the documentation for the NUM_*
constants. But obviously it was too oblique, so I will make it more
explicit, maybe

    ... and the NUM_* constants documented above.

>> + * Return 0 on success or a negative value if there was an error. On
>> + * failure, *result and *entptr are left unchanged.
>> + *
>> + * Please note that if NUM_TRAILING is not set, then it is
>> + * nevertheless an error if there are any characters between the end
>> + * of the number and the end of the string.
> 
> Again, on the subject of convenience, why this restriction? The stated
> purpose of the parse_*() functions is to parse the number from the
> front of the string and return a pointer to the first non-numeric
> character following. As  a reader of this API, I interpret that as
> meaning that NUM_TRAILING is implied. Is there a strong reason for not
> inferring NUM_TRAILING for the parse_*() functions at the API level?
> (I realize that the convert_*() functions are built atop parse_*(),
> but that's an implementation detail.)

Yes, I'd also thought about that change:

* Make NUM_TRAILING private.
* Make the current parse_*() functions private.
* Add new parse_*(s, flags, result, endptr) functions that imply
NUM_TRAILING (and maybe they should *require* a non-null endptr argument).
* Change the convert_*() to not allow the NUM_TRAILING flag.

This would add a little bit of code, so I didn't do it originally. But
since you seem to like the idea too, I guess I will make the change.

>> + */
>> +
>> +int parse_l(const char *s, unsigned int flags,
>> +           long *result, char **endptr);
> 
> Do we want to perpetuate the ugly (char **) convention for 'endptr'
> from strto*l()? Considering that the incoming string is const, it
> seems undesirable to return a non-const pointer to some place inside
> that string.

Yes, I guess we could do some internal casting and expose endptr as
(const char **). It would make it a bit harder if the user actually
wants to pass a non-const string to the function and then modify the
string via the returned endptr, but I haven't run into that pattern yet
so let's make the change you suggested.

>> +/*
>> + * Number conversion functions:
>> + *
>> + * The following functions parse a string into a number. They are
>> + * identical to the parse_*() functions above, except that the endptr
>> + * is not returned. These are most useful when parsing a whole string
>> + * into a number; i.e., when (flags & NUM_TRAILING) is unset.
> 
> I can formulate arguments for allowing or disallowing NUM_TRAILING
> with convert_*(), however, given their purpose of parsing the entire
> string into a number, as a reader of the API, I would kind of expect
> the convert_*() functions to ensure that NUM_TRAILING is not set
> (either by forcibly clearing it or erroring out as an inconsistent
> request if it is set).

Yes, I think I will change this, as discussed above.

>> + */
>> +static inline int convert_l(const char *s, unsigned int flags,
>> +                           long *result)
>> +{
>> +       return parse_l(s, flags, result, NULL);
>> +}

Thanks for your careful and thoughtful comments!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
