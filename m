From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change
 check_pbase_path() to use ALLOC_GROW()
Date: Sat, 1 Mar 2014 02:07:58 -0500
Message-ID: <20140301070758.GE20397@sigill.intra.peff.net>
References: <530FA3E7.8020200@yandex.ru>
 <531056E7.3010305@yandex.ru>
 <53105995.3010001@yandex.ru>
 <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
 <CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
 <53109B19.8070103@alum.mit.edu>
 <xmqqfvn3ukjs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJe1m-0001IE-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 08:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbaCAHIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 02:08:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:59222 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750769AbaCAHIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 02:08:00 -0500
Received: (qmail 24030 invoked by uid 102); 1 Mar 2014 07:08:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Mar 2014 01:08:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 02:07:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvn3ukjs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243049>

On Fri, Feb 28, 2014 at 11:03:19AM -0800, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > So my vote is that the patches are OK the way Dmitry wrote them (mind, I
> > have only read through 05/11 so far).
> 
> Seconded ;-)
> 
> By the way, I do not like these long subjects.  "change" is a
> redundant word when one sends a patch---as all patches are about
> changing something.
> 
> 	Subject: builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
> 
> would be a lot more appropriate for "git shortlog" consumption.

I would actually go one step further and drop or shorten the filename in
the subject. It is very long, it is already easy to see which file was
changed from the diffstat, and it doesn't give any useful context for
other parts of the subject.

I really like the "foo:" convention for starting a subject line, because
it immediately makes clear what area you are working in without having
to waste space on English conjunctions or prepositions. But it does not
have to be a filename. It can be a subsystem, a command, a function, an
area of the project, or anything that gives context to the rest of the
line.

So I would suggest one of:

  Subject: use ALLOC_GROW() in check_pbase_path()

    Talking about the filename is redundant; there's only one
    check_pbase_path.

  Subject: check_pbase_path: use ALLOW_GROW

    Even shorter.

  Subject: builtin/pack-objects.c: use ALLOC_GROW

    This one implies to me that the point of the commit is to convert
    the whole file to use ALLOC_GROW where appropriate, not just that
    function (even if that function may be the only spot changed).

I'd probably not use:

  Subject: pack-objects: use ALLOC_GROW

as the scope is not about the command, but about the C file.

I realize that I just bikeshedded on subject lines for half a page, and
part of me wants to go kill myself in shame. But I feel like I see the
technique misapplied often enough that maybe some guidance is merited.
Feel free to ignore. :)

-Peff
