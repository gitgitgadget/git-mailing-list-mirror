From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Fri, 21 Mar 2008 00:42:55 -0500
Message-ID: <5d46db230803202242j60b0e9f6q798afd6c5f468207@mail.gmail.com>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
	 <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
	 <20080321045137.GA5563@coredump.intra.peff.net>
	 <7vtzj0slx4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jca2T-0001jW-MI
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYCUFm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbYCUFm4
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:42:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:24432 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYCUFm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:42:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1479968wxd.4
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 22:42:55 -0700 (PDT)
Received: by 10.150.203.8 with SMTP id a8mr1347765ybg.56.1206078175194;
        Thu, 20 Mar 2008 22:42:55 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Thu, 20 Mar 2008 22:42:55 -0700 (PDT)
In-Reply-To: <7vtzj0slx4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77717>

On Fri, Mar 21, 2008 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
>  > On Thu, Mar 20, 2008 at 09:48:16PM -0700, Junio C Hamano wrote:
>  >
>  >> > +  case 'z':               /* null */
>  >> > +          strbuf_addch(sb, '\0');
>  >> > +          return 1;
>  >> >    }
>  >> >
>  >> >    /* these depend on the commit */
>  >>
>  >> I do not like this at all.  Why aren't we doing %XX (2 hexadecimal digits
>  >> for an octet)?
>  >
>  > Because %ad is already taken? :)
>  >
>  > %x* is still available, though, so maybe %x00?
>
>  Perhaps, but before I forget.
>
>  My much bigger niggle about the "--pretty=format:<>" code I have is that
>  the "log" machinery does not change the usual record "delimiter" to record
>  "terminator" when --pretty=format:<> is in effect.
>
>  The "log" family generally treats LF/NUL as record delimiter, not
>  terminator, and it is by a very good conscious design.  When you are
>  looking at the output from "git log -2", you would want to have a
>  delimiting LF between the first commit and the second commit, but you do
>  not want an extra LF after the second commit.
>
>  However, when "--pretty=format:<>" is in effect, it is inconvenient that
>  the machinery inserts a LF between each record but not at the end.
>
>     $ git log -2 --pretty=format:%s
>
>  may look sane when the pager immediately returns the control to you, but
>  it is not really.  To view it:
>
>     $ git log -2 --pretty=format:%s | cat
>
>  This would show that there is no LF after the final output, which is quite
>  bad.
>

Sorry, I'm a bit confused.  Should I alter the patch to use a different code
for null, that would be fine by me?  The above seems to be an unrelated issue.


Thanks,
Govind.
