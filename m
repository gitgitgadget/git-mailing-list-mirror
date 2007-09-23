From: David Kastrup <dak@gnu.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 21:11:30 +0200
Message-ID: <857imhmc2l.fsf@lola.goethe.zz>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	<20070923020951.GF24423@planck.djpig.de>
	<20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
	<e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
	<20070923104525.GC7118@artemis.corp>
	<e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com>
	<alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
	<e5bfff550709231105h94d08e2n9b1234e7c1a7e6a8@mail.gmail.com>
	<85hcllmdzb.fsf@lola.goethe.zz>
	<e5bfff550709231143m7eb351bx4cf1c60d1247cc3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 21:11:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZWrm-0000cr-GS
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbXIWTLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXIWTLe
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:11:34 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:34719 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756235AbXIWTLd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 15:11:33 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id AD5BC15C2CB;
	Sun, 23 Sep 2007 21:11:31 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 66D112130A7;
	Sun, 23 Sep 2007 21:11:31 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 323D113F7A;
	Sun, 23 Sep 2007 21:11:31 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C11031C1F3DC; Sun, 23 Sep 2007 21:11:30 +0200 (CEST)
In-Reply-To: <e5bfff550709231143m7eb351bx4cf1c60d1247cc3d@mail.gmail.com> (Marco Costalba's message of "Sun\, 23 Sep 2007 20\:43\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4369/Sun Sep 23 16:16:26 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58977>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 9/23/07, David Kastrup <dak@gnu.org> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > And BTW
>> >
>> > template <typename T>
>> >
>> > is the thing in C++ that more remembers me of opaque pointers and
>> > their use in C, the difference is that the first is fully type
>> > checked.
>>
>> Not really.  The difference is that the first generates new (and
>> optimized) code for every type which is something you can only do
>> using macros in C.  Class programming is similar to opaque pointers
>> (in particular concerning the generated code) but templates are really
>> more like macros, as their instantiation generates specialized code,
>> not at all like the handling of opaque pointers.
>
> Probably if I had written like this was more clear:
>
> template <typename T>  int some_function(T* p);

Huh?  How is this supposed to support your point?  There is nothing
like an opaque pointer involved here.  The point of opaque pointers is
that they can stand for a variety of types, whereas each template
instantiation can only substitute a single type.

> And regarding 'new' code for each type I would like to remember that
> template instantations of different types can be removed by
> compiler/linker when the instantations are the same (i.e. produce
> the same binary instuctions), this could happen for function
> templates that handle pointers, as example.

Hardly.  The type constraints/virtual function tables of any called
function depending on T will be different.  And if indeed nothing
depends on T at all inside of the template, it is pointless not to
declare it as void *p in the first place: the type of *p will never be
used then.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
