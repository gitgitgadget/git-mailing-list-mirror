From: "James Youngman" <jay@gnu.org>
Subject: Re: Problem with case-insensitive file cleanup
Date: Thu, 3 May 2007 22:40:15 +0100
Message-ID: <c5df85930705031440n3b3025dalf566944da6069262@mail.gmail.com>
References: <4639DA65.3030401@byu.net> <87odl2dnbk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bug-findutils mailing list <bug-findutils@gnu.org>,
	bug-gnulib <bug-gnulib@gnu.org>, Eric Blake <ebb9@byu.net>,
	git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: bug-findutils-bounces+gnu-bug-findutils=m.gmane.org@gnu.org Thu May 03 23:40:26 2007
Return-path: <bug-findutils-bounces+gnu-bug-findutils=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-findutils@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjj2F-0001VB-GM
	for gnu-bug-findutils@m.gmane.org; Thu, 03 May 2007 23:40:23 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Hjj8o-0002MB-2w
	for gnu-bug-findutils@m.gmane.org; Thu, 03 May 2007 17:47:10 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Hjj8j-0002La-Kt
	for bug-findutils@gnu.org; Thu, 03 May 2007 17:47:05 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Hjj8i-0002LO-Lt
	for bug-findutils@gnu.org; Thu, 03 May 2007 17:47:05 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Hjj8i-0002LE-Fb
	for bug-findutils@gnu.org; Thu, 03 May 2007 17:47:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.231])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <jay@gmail.com>) id 1Hjj28-0004yq-TV
	for bug-findutils@gnu.org; Thu, 03 May 2007 17:40:17 -0400
Received: by wr-out-0506.google.com with SMTP id i23so692421wra
	for <bug-findutils@gnu.org>; Thu, 03 May 2007 14:40:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
	b=DgUSAwQr7Drb2eTjcFEKjmPPPFPeA+WSeQmzF7W5LzDXpI1MX0zjT1i7uTvMbj8J0ycIpmwWVQ8i6B3tDZQd2vJNs/YSo0Seww5zTxNAzUZWkgDwCa3aZmpZzr1ypObC1mUeF5SsnD06VChtsNO7yRmTOUdpeER2I+GkU22UMzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=beta;
	h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
	b=B4F5cmYZwsVLFaDRdczv6zKkKrIdrIu5kr2G6cri36jg2Ujt3La31roT6TFcS6yRWkFsH7dYOUCJfOtjaS+5CD9VHfeKhUwbP3ILc/bfqmdvEUmpNerIipOSspJfHVWg8Zm4NRHDI/eG1PVL1ko3bYWExpuYi5duBvjr1tICBRY=
Received: by 10.115.22.1 with SMTP id z1mr845696wai.1178228415976;
	Thu, 03 May 2007 14:40:15 -0700 (PDT)
Received: by 10.114.94.9 with HTTP; Thu, 3 May 2007 14:40:15 -0700 (PDT)
In-Reply-To: <87odl2dnbk.fsf@rho.meyering.net>
Content-Disposition: inline
X-Google-Sender-Auth: fef49b3436cf3fae
X-detected-kernel: Linux 2.4-2.6 (Google crawlbot)
X-BeenThere: bug-findutils@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Bug reports for the GNU find utilities <bug-findutils.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-findutils>,
	<mailto:bug-findutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-findutils>
List-Post: <mailto:bug-findutils@gnu.org>
List-Help: <mailto:bug-findutils-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-findutils>,
	<mailto:bug-findutils-request@gnu.org?subject=subscribe>
Sender: bug-findutils-bounces+gnu-bug-findutils=m.gmane.org@gnu.org
Errors-To: bug-findutils-bounces+gnu-bug-findutils=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46110>

On 5/3/07, Jim Meyering <jim@meyering.net> wrote:

> > Earlier this week, I reported a problem when two case-insensitive files
> > were created, which is a no-no for checkouts on Mac HFS+ or Windows-based
> > platforms [1].  The problem was quickly corrected in CVS (note that
> > _Exit.texi now lives in the attic [2]).  But somehow the git repository
> > still thinks that _Exit.texi belongs to the current tree [3], which leads
> > to this confusing state on a case-insensitive clone:
>
> I've just removed that file manually and pushed the result.
> I suppose that happened because something went wrong with the
> automated git-cvsimport run.
>
> The current procedure is to rsync the CVS repository,
> use that via git-cvsimport into an existing .git repository,
> and then to push the result to savannah.
>
> Obviously, before we do the final CVS-to-GIT switch, I'll rerun
> git-cvsimport from scratch, rather relying on the incrementally-built-up one.

I have had related problems using git-cvsimport with the GNU findutils
source base and was eventually reduced to deleting the git repository
into which I was pushing the git-cvsimport result.    I had added a
directory to the CVS repository (findutils/build-aux) and it was not
showing up in the target git repository (i.e. the local directory I
was specifying as the argument of -C).

Fortunately since git is content-oriented (has foo-nature, whatever,
insert hand-wave here), once I have repeated the entire cvsimport
operation, pushing the regenerated result to the public git repository
only required an incremental amount of work (bandwdth).

But suffice to say, I do not believe that git-cvsimport is very
reliable.   People more familiar with git than I point the finger at
cvsps, but to be honest I don't know enough about either program to
arbitrate.

People also pointed me at alternatives to git-cvsimport but they all
had one or more of these drawbacks:
1. No support for incremental import
2. No support for tags
3. No support for branches

James.
