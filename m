From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 02 Nov 2007 03:33:07 -0700
Message-ID: <7vbqad3pjw.fsf@gitster.siamese.dyndns.org>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	<7v4pg55893.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20711020319l26b4a8c1r99576dc29ea504d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Blake Ramsdell" <blaker@gmail.com>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntqN-00079N-Aq
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbXKBKdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbXKBKdT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:33:19 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:51111 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbXKBKdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:33:18 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 102FF2F0;
	Fri,  2 Nov 2007 06:33:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 79EF5904AC;
	Fri,  2 Nov 2007 06:33:32 -0400 (EDT)
In-Reply-To: <ee77f5c20711020319l26b4a8c1r99576dc29ea504d8@mail.gmail.com>
	(David Symonds's message of "Fri, 2 Nov 2007 21:19:31 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63098>

"David Symonds" <dsymonds@gmail.com> writes:

> On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Blake Ramsdell <blaker@gmail.com> writes:
>>
>> > Signed-off-by: Blake Ramsdell <blaker@gmail.com>
>> > ---
>> >  Makefile |    4 +++-
>> >  1 files changed, 3 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 71479a2..5d83756 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -401,7 +401,9 @@ endif
>> >  ifeq ($(uname_S),Darwin)
>> >       NEEDS_SSL_WITH_CRYPTO = YesPlease
>> >       NEEDS_LIBICONV = YesPlease
>> > -     OLD_ICONV = UnfortunatelyYes
>> > +     ifneq ($(uname_R),9.0.0)
>> > +             OLD_ICONV = UnfortunatelyYes
>> > +     endif
>> >       NO_STRLCPY = YesPlease
>> >       NO_MEMMEM = YesPlease
>> >  endif
>>
>> I do not have an access to a Darwin box, but do you mean 10.5
>> gives 9.0.0 as uname_R?
>
> Further, that comparison is going to fail as soon as the next revision
> of Darwin (9.0.1, etc.) is released.

Can we do something intelligent with $(shell iconv --version)
there instead, I wonder, then?
