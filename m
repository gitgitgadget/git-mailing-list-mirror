From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function 
	strbuf_vaddf()
Date: Thu, 26 Nov 2009 10:46:10 -0800
Message-ID: <7vbpip86q5.fsf@alter.siamese.dyndns.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <7vskc2ksnn.fsf@alter.siamese.dyndns.org>
 <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org,  dotzenlabs@gmail.com,
 Alex Riesen <raa.lkml@gmail.com>
To: kusmabite@gmail.com
X-From: 3A80OSwcJByoMOZYZKXVUHUd.IUSSYeYMOZMUUMRKMXUaVY.IUS@listserv.bounces.google.com Thu Nov 26 19:46:46 2009
Return-path: <3A80OSwcJByoMOZYZKXVUHUd.IUSSYeYMOZMUUMRKMXUaVY.IUS@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f141.google.com ([209.85.221.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDjMb-0005dK-N6
	for gcvm-msysgit@m.gmane.org; Thu, 26 Nov 2009 19:46:45 +0100
Received: by qyk5 with SMTP id 5sf297952qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 26 Nov 2009 10:46:44 -0800 (PST)
Received: by 10.229.102.129 with SMTP id g1mr352qco.37.1259261187961;
        Thu, 26 Nov 2009 10:46:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.44.36 with SMTP id y36ls95594qce.3.p; Thu, 26 Nov 2009 
	10:46:26 -0800 (PST)
Received: by 10.229.100.216 with SMTP id z24mr6610qcn.4.1259261185804;
        Thu, 26 Nov 2009 10:46:25 -0800 (PST)
Received: by 10.229.100.216 with SMTP id z24mr6609qcn.4.1259261185787;
        Thu, 26 Nov 2009 10:46:25 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62])
        by gmr-mx.google.com with ESMTP id 18si99225qyk.13.2009.11.26.10.46.24;
        Thu, 26 Nov 2009 10:46:24 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) client-ip=64.74.157.62;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68ED0A1794;
	Thu, 26 Nov 2009 13:46:24 -0500 (EST)
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C77EA1793;
	Thu, 26 Nov 2009 13:46:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 32802A1792; Thu, 26 Nov 2009
 13:46:11 -0500 (EST)
In-Reply-To: <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
 (Erik Faye-Lund's message of "Thu\, 26 Nov 2009 11\:38\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC16123C-DABB-11DE-A5CD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) 
	smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/8eca3bba11d40757
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133819>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> On Thu, Nov 26, 2009 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>>
>>> +void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 int len;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 if (!strbuf_avail(sb))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(sb, 64);
>>> =C2=A0 =C2=A0 =C2=A0 len =3D vsnprintf(sb->buf + sb->len, sb->alloc -=
 sb->len, fmt, ap);
>>> =C2=A0 =C2=A0 =C2=A0 if (len < 0)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("your vsnprintf =
is broken");
>>> =C2=A0 =C2=A0 =C2=A0 if (len > strbuf_avail(sb)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(sb, len)=
;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D vsnprintf(sb=
->buf + sb->len, sb->alloc - sb->len, fmt, ap);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len > strbuf_ava=
il(sb)) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("this should not happen, your snprintf is broken");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> Hmm, I would have expected to see va_copy() somewhere in the patch tex=
t.
>> Is it safe to reuse ap like this in two separate invocations of
>> vsnprintf()?
>
> I think your expectation is well justified, this seems to be a
> portability-bug waiting to happen. Sorry for missing this prior to
> sending out - on Windows this is known to work, and this function is
> currently only used from the Windows implementation of syslog.
>
> How kosher is it to use va_copy in the git-core, considering that it's
> C99? A quick grep reveals only one occurrence of va_copy in the
> source, and that's in compat/winansi.c. Searching the history of next
> reveals that Alex Riesen (CC'd) already removed one occurrence
> (4bf5383), so I'm starting to get slightly scared it might not be OK.

We tend to avoid C99 features and it saved us in a few occasions.  Recent
MSVC port revealed that we still had a handful of decl-after-statments bu=
t
luckily the necessary fix-ups were minimal because I have been reasonably
careful to reject patches that add it long before MSVC port happened.

> In practice it seems that something like the following works
> portably-enough for many applications, dunno if it's something we'll
> be happy with:
> #ifndef va_copy
> #define va_copy(a,b) ((a) =3D (b))
> #endif

Since an obvious implementation of va_list would be to make it a pointer
into the stack frame, doing the above would work on many systems.  On
esoteric systems that needs something different (e.g. where va_list is
implemented as a size-1 array of pointers, va_copy(a,b) needs to be an
assignment (*(a) =3D *(b))), people can add compatibility macro later.

Historically some systems that do have a suitable implementation had it
under the name __va_copy() instead, so it would have been better to defin=
e
it as something like:

    #ifndef va_copy
    # ifdef __va_copy
    # define va_copy(a,b) __va_copy(a,b)
    # else
    # /* fallback for the most obvious implementation of va_list */
    # define va_copy(a,b) ((a) =3D (b))
    # endif
    #endif

But I do not know it still matters in practice anymore.
