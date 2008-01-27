From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sun, 27 Jan 2008 11:21:28 +0300
Message-ID: <20080127082128.GH26664@dpotapov.dyndns.org>
References: <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com> <4797518A.3040704@op5.se> <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com> <4798B633.8040606@op5.se> <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com> <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org> <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com> <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org> <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com> <alpine.LFD.1.00.0801262247140.3222@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marko Kreen <markokr@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 09:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ2mS-0001HK-KR
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 09:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYA0IVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 03:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbYA0IVh
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 03:21:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:19508 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYA0IVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 03:21:36 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1264717fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=FPg3HKBHTgPk6XKJ9L9tfdGpZnQpjAL+S92UPeGbU4Q=;
        b=MK6yQTeSznBNJkjadJU+Njva/ZstzRYdqiw0oil37+jf4m4mU9LEGs+YONZEScpyZNJLswBsLCu0Iyx9LBUtL0doLhPr1x1t0Gapr+DCwB2EwCADzWvpEfopKfh7yMfPnNfBOLcFG8GVg3bH8EL2yo9zNjeZTz6mt8b+dQFcyjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=x1W9xWT5gt+dna051wj1lN+pzFaQtjttl/Xarlk6uxMTXSdIQtB1kQT0LOXn7DYnWRJ6JBikPqjoG73cX0kbkjrVCcV0iMAlRew6HjnwJCR8gvAkXeWP5kv3k+hMJSOHd8weBp+BMznQNvfCtlkWjRvNoMO2sNiK1SMAEAxWKF4=
Received: by 10.86.74.15 with SMTP id w15mr108007fga.37.1201422092726;
        Sun, 27 Jan 2008 00:21:32 -0800 (PST)
Received: from localhost ( [85.141.188.123])
        by mx.google.com with ESMTPS id l12sm4399550fgb.8.2008.01.27.00.21.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 00:21:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801262247140.3222@www.l.google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71809>

On Sat, Jan 26, 2008 at 10:51:18PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 26 Jan 2008, Marko Kreen wrote:
> > 
> > Here you misunderstood me, I was proposing following:
> > 
> > int hash_folded(const char *str, int len)
> > {
> >    char buf[512];
> >    do_folding(buf, str, len);
> >    return do_hash(buf, len);
> > }
> > 
> > That is - the folded string should stay internal to hash function.
> 
> If it's internal, it's much better, but you still missed the performance 
> angle.
> 
> The fact is, hashing can take shortcuts that folding cannot do!
> 
> Case folding, by definition, has to be "exact" (since the whole point is 
> what you're going to use the same folding function to do the compare, so 
> if you play games with folding, the compares will be wrong).

Let's rename do_folding as something else, because it is not a real
folding, but a preparation step for hash calculation. Keeping these
steps separately simplifies the code, and allows further optimization,
for instance, you do not need this do_folding step on a case-sensitive
filesystem. Though it is certainly possible to mix both steps together,
it bloats the code and makes it less readable. Of course, the idea to
avoid a temporary buffer and do everything at once is very appealing,
so I gave it a try -- and here is a 32-bit version of name_hash(), but
I am not very happy with the result:


#define rot(x,k) (((x)<<(k)) | ((x)>>(32-(k))))

#define mix(a,b,c) \
{ \
	a -= c;  a ^= rot(c, 4);  c += b; \
	b -= a;  b ^= rot(a, 6);  a += c; \
	c -= b;  c ^= rot(b, 8);  b += a; \
	a -= c;  a ^= rot(c,16);  c += b; \
	b -= a;  b ^= rot(a,19);  a += c; \
	c -= b;  c ^= rot(b, 4);  b += a; \
}
#define final(a,b,c) \
{ \
	c ^= b; c -= rot(b,14); \
	a ^= c; a -= rot(c,11); \
	b ^= a; b -= rot(a,25); \
	c ^= b; c -= rot(b,16); \
	a ^= c; a -= rot(c,4);  \
	b ^= a; b -= rot(a,14); \
	c ^= b; c -= rot(b,24); \
}

#define hash_value(x) \
	hs[hp] += (x); \
	if (++hp == 3) { \
		mix (hs[0], hs[1], hs[2]); \
		hp = 0; \
	}
unsigned int name_hash(const char *name, unsigned size)
{
	unsigned hp = 0;
	unsigned hs[3];
	hs[0] = hs[1] = hs[2] = 0xdeadbeef + size;

	do {
		unsigned char c;
		if (size >= sizeof(unsigned)) {
			unsigned val = get_unaligned_uint(name);
			if (!(val & 0x80808080)) {
				val &= ~0x20202020;
				hash_value(val);
				name += sizeof(val);
				size -= sizeof(val);
				continue;
			}
		}

		while (!((c = *name) & 0x80)) {
			hash_value(c & ~0x20);
			name++;
			if (!--size)
				goto done:
		}

		do {
			// TODO: add denormalization for Mac
			unsigned val = towupper (utf8_to_wchar(&name, &size));
			hash_value(val);
		} while (size && (*name & 0x80));

	} while (size);
done:
	if (hp)
		final(a,b,c);
	return hs[2];
}


Dmitry
