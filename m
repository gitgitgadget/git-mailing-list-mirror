From: John Whitney <jjw@emsoftware.com>
Subject: Re: Bug report
Date: Thu, 04 Oct 2012 11:10:40 -0500
Message-ID: <506DB500.4010803@emsoftware.com>
References: <506D122E.2050404@emsoftware.com> <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtb9-00033L-US
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090Ab2JDQKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:10:48 -0400
Received: from mail.emsoftware.com ([76.75.201.49]:52174 "EHLO emsoftware.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757077Ab2JDQKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:10:47 -0400
Received: from Johns-MacBook-Pro.local (ppp-70-253-75-224.dsl.austtx.swbell.net [70.253.75.224])
	by emsoftware.com (Postfix) with ESMTP id B66321AF5256;
	Thu,  4 Oct 2012 12:14:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206973>

Phil,

Thank you for your response. I do see the dilemma, but having
no possible "unmodified" state is extremely inconvenient and,
as shown, breaks basic git operations.

I guess my thought is that if git doesn't allow CRs to be checked
in, then it should strip the CRs when checking the file out, and
consider that form (or both forms) as "unmodified". It just
doesn't make sense to me that files are considered modified
immediately after checkout.

Any thoughts as to why this would not work?

    ---John

On 10/4/12 9:19 AM, Phil Hord wrote:
> On Thu, Oct 4, 2012 at 12:35 AM, John Whitney <jjw@emsoftware.com> wrote:
>> I just ran into a problem that I'm pretty sure is a bug in git. Just read
>> and run this (fairly trivial) shell script to replicate.
> When you added "* text=auto" in the .gitattributes file, you changed
> what git considers to be the checked-in file content state for
> test.txt.  The file contents in your working directory do not match
> what git expects to check in.  Therefore, the file appears to be
> different.  If you commit the file "changes" the problem goes away.
>
> This is more of a workaround than an a satisfying explanation.  If you
> then checkout the original HEAD commit (but with .gitattributes
> present) you will see the problem appear again.  But in a sense,
> adding .gitattributes this way is an act of foot-shooting.   The best
> way forward may be to normalize your repository by removing all CR's
> from files in history.  If you do not have this freedom, your best bet
> may be to normalize the repo in the current commit and move on.
>
> Others with more intimate insight into the CRLF journey in git's past
> may have better advice.
>
> Phil
>


-- 
Great support for great users! Please visit http://emsoftware.com/support/ for our support policies, instructions and FAQs.
