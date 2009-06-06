From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 3/8] diff-delta.c: "delta.h" is not a required include
Date: Fri, 5 Jun 2009 22:56:20 -0500
Message-ID: <ee63ef30906052056le082bffrec078981dddaa013@mail.gmail.com>
References: <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil>
	 <M3MzU6FlQXfVApDnN0vdEf4UcS0v8Dh-XOz1cA15MA7nN8wUHrIif6F7g1-JWcHSJSi5Z6_vOoA@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0906052112590.3906@xanadu.home>
	 <P6YSWMs6FWplIDEFHZcRIeF7G1bOeRomvBYwfaQf2dgnsOWGC2AaBg@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0906052302550.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, peff@peff.net
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 05:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCn1A-00063e-O2
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 05:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZFFD4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 23:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbZFFD4T
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 23:56:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:16494 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZFFD4T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 23:56:19 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1347871qwd.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 20:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cTr8W2IRfDG4RopTahsa7YZoZ9SuO1qC9yegASSZyiY=;
        b=bW7XpotLxiuGA6fQ4cYVwDQlNKc+i1NU9ObVKHRO7KIzpcEKUjok92r7gLDNNn4R9b
         Mo+zproXIAYRb9lX70atIzdjQL7xzetEmlHXmoxqL9vC2HRt2uSMqHRW5QT+3XaFTA/C
         BkpDPay5c9XFyD2+MEfW8dFW22NM2WOnPvuFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N+hJdhbctVrdNNvWFB4+vA0eS7N9OC0thFFCHRQKNGS1yF9d+GsA0FRkWVQG0s6m8g
         5hkJHhuqu+n1wiydrgmS9sSXGEGfx0nDTjXRfti16EmRvwyrUeB1ofSNxMdvWTGIJMS0
         PGqmR7n9cMH/Yu/SeVkKgNCB6YI6k2chQ5qGw=
Received: by 10.220.100.5 with SMTP id w5mr2895907vcn.62.1244260580465; Fri, 
	05 Jun 2009 20:56:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906052302550.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120865>

On Fri, Jun 5, 2009 at 10:10 PM, Nicolas Pitre<nico@cam.org> wrote:
> On Fri, 5 Jun 2009, Brandon Casey wrote:
>
>> Nicolas Pitre wrote:
>> > On Fri, 5 Jun 2009, Brandon Casey wrote:
>> >
>> >> From: Brandon Casey <drafnel@gmail.com>
>> >>
>> >> When compiling diff-delta.c with the SUNWspro C99 compiler, it co=
mplains
>> >>
>> >> =C2=A0 =C2=A0 "diff-delta.c", line 314: identifier redeclared: cr=
eate_delta
>> >>
>> >> There is nothing in "delta.h" that is required by diff-delta.c, s=
o don't
>> >> include it.
>> >>
>> >> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> >
>> > NAK.
>> >
>> > This is common practice to include the header file declaring funct=
ion
>> > prototypes into the file defining the actual function so to make s=
ure
>> > the declaration matches with the definition. =C2=A0Deleting that i=
nclude is
>> > actively ignoring a problem instead of fixing the cause of it.
>>
>>
>> It doesn't seem to like the structure being redeclared with a flex a=
rray
>> member and being passed as a const argument.
>>
>>
>> # cat > test.c <<EOF
>>
>> struct a_struct;
>>
>> extern void *test_func(const struct a_struct *f);
>>
>> struct a_struct {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int a;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int b;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 char* c[];
>> };
>>
>> void *test_func(const struct a_struct *f)
>> {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> }
>> EOF
>>
>> # /opt/SUNWspro/bin/c99 -c test.c
>> "test.c", line 13: identifier redeclared: test_func
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 current : function(pointer to const stru=
ct a_struct {int a, int b, array[-1] of pointer to char c}) returning p=
ointer to void
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 previous: function(pointer to const stru=
ct a_struct {int a, int b, array[-1] of pointer to char c}) returning p=
ointer to void : "test.c", line 4
>> c99: acomp failed for test.c
>>
>>
>> If either the flex array is removed from the structure, or const is =
removed from
>> test_func argument, test.c will compile. =C2=A0Compiling with -O0 do=
esn't help.
>
> What if you define FLEX_ARRAY to 1, or even 0?

I tried that with my test.c example and '1' works, but not '0'.  I'll
try setting FLEX_ARRAY to 1 and running git's test suite on Monday.

> If neither of those work then I'd simply remove the const. =C2=A0Gene=
rated
> code should be exactly the same with gcc. =C2=A0There is no const wit=
h
> sizeof_delta_index() which is already inconsistent.
>
> Kind of weird nevertheless.

Yes.

-brandon
