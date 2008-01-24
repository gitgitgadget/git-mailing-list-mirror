From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 18:13:02 +0200
Message-ID: <e51f66da0801240813v61d3bc74x2863eb37678439db@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4i1-0003tN-17
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYAXQNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYAXQNJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:13:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:23328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYAXQNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:13:08 -0500
Received: by nf-out-0910.google.com with SMTP id g13so29044nfb.21
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=x3QA9wYe04vxlgXKbiio+vwpXQBRPF3Ur7wUYvzWUQM=;
        b=cVzFVkZ+7F26jC3V7Z9S3roBxnE4re1J4FuqPywynx2/0PzVMqFKgQINr2K+RvNEQSTutJd68BgunTEm1YJ+qfVkRzc7/BY1dwViN6svwdhfCgE7YHAqx4VE2jAOha+zst8DOLF1maIooYl4SlYGZ/ZnNSoYnEtZVbhMMLvz++A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qWfnrBbujROiv2TOeHTzoqUObr+g+Cv4Nexj0FkTlPjUSfNuYyad58RajlPl1B+m9J5xBmYtsKTczT42yeWlvlGsWtce19nWJ5A6+1YL3XNy0K+sFvG3akMZiIBeGBLwbiYTlGWzRz4lnyIVLPF+UD6h2Cro+bDHtmJWfElV1T8=
Received: by 10.78.138.14 with SMTP id l14mr1116601hud.23.1201191182585;
        Thu, 24 Jan 2008 08:13:02 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Thu, 24 Jan 2008 08:13:02 -0800 (PST)
In-Reply-To: <4798B633.8040606@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71628>

On 1/24/08, Andreas Ericsson <ae@op5.se> wrote:
> Marko Kreen wrote:
> > On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
> >> Marko Kreen wrote:
> >>> (not lookup3) because lookup3 beat easily all the "simple" hashes
> >> By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
> >> and 0.1 microsecons / lookup. We're talking about a case here where
> >> there will never be more lookups than insertions (unless I'm much
> >> mistaken).
> >
> > FNV is around 40% slower than lookup3 on my Intel Core CPU, on 4byte aligned
> > input. See below for more detailed info.
> >
>
> But the tests surely need to check for unaligned cases, as that's what
> we're likely to hash, no?



> >> It would have to be a significant improvement in wall-clock time
> >> on a test-case of hashing 30k strings to warrant going from 6 to 80
> >> lines of code, imo. I still believe the original dumb hash Linus
> >> wrote is "good enough".
> >
> > Well, ad-hoc dumb hashes may have horrible worst-cases that you cant
> > see with light testing.  Therefore I'd still suggest some better
> > researched dumb hash (eg. FNV or OAT).
> >
>
> True. FNV is used in both MySQL and PostgreSQL. I'd say it's safe to
> assume it's fairly well tested.

PostgreSQL uses lookup2...

> > Here is my raw-speed test of different hashes.  Input is 4-byte
> > aligned which should be common case for malloc()-ed strings.
>
> Unless arena allocated, like we do in git.
>
> I'm not surprised that this test favours Jenkin's and Hsie's.
> That's to be expected as those benefit far more than simpler
> hashing algorithms for long strings. The overhead when trying
> shorter strings (say, between 3 and 15 chars, and not necessarily
> 4-byte aligned) sometimes make them quite a lot slower though.

Ok, here is 0..15 chars, random alignment:

Testing: seed=34 align=0 minlen=0 maxlen=15 trycnt=2 duration=10

lookup3 : try=0: ...  69.8092 MB/s
lookup3 : try=1: ...  69.8146 MB/s
own_memcpy: try=0: ...  66.7808 MB/s
own_memcpy: try=1: ...  66.7814 MB/s
memcpy_hack: try=0: ...  74.0635 MB/s
memcpy_hack: try=1: ...  74.0518 MB/s
lookup2 : try=0: ...  68.6582 MB/s
lookup2 : try=1: ...  68.6634 MB/s
fnv     : try=0: ...  74.5098 MB/s
fnv     : try=1: ...  74.5283 MB/s
hsieh   : try=0: ...  71.6708 MB/s
hsieh   : try=1: ...  71.6814 MB/s
oat     : try=0: ...  74.7828 MB/s
oat     : try=1: ...  74.7716 MB/s
elf     : try=0: ...  65.2077 MB/s
elf     : try=1: ...  65.2128 MB/s

Results compared to reference:

lookup3         : 100.000 %
own_memcpy      :  95.659 %
memcpy_hack     : 106.082 %
lookup2         :  98.351 %
fnv             : 106.743 %
hsieh           : 102.670 %
oat             : 107.112 %
elf             :  93.409 %

> > This also is best case for original lookup3(), on unaligned
> > input the memcpy variants beat it easily.  Input string
> > length varies randomly in range 0..64.
> >
>
> Well, memcpy() isn't very interesting to compare against
> hashes, as they test vastly different parts of the hardware's
> parts' performance. memcpy() should also perform exactly the
> same no matter what the test-data, which isn't always true for
> hashes.

Sorry, I meant my "simple-memcpy-based-lookup3".

> What *would* be interesting would be something along the lines
> of "duff_cpy()": ie, an unrolled loop that aligns itself and
> copies each byte to the same address each time.

How the hash fetched data from mempry is _very_ relevant.

> Interesting output, but not very surprising. Do you have the code
> available somewhere?

I can put it out.

-- 
marko
