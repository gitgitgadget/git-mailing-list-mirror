From: Junio C Hamano <gitster@pobox.com>
Subject: Re: #178 parsing of pretty=format:"%an %ad" causes fatal: bad revision '%ad'
Date: Fri, 02 May 2014 10:18:26 -0700
Message-ID: <xmqqsiosayl9.fsf@gitster.dls.corp.google.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
	<CABPQNSa6PaTZ3coX2eU-r7BFH3JR2V6XHv4HbXxsYyxv0qA71Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Dave Bradley <dbradley2@bell.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri May 02 19:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgH6Z-00058n-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 19:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaEBRSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 13:18:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61534 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbaEBRSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 13:18:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAE0210237;
	Fri,  2 May 2014 13:18:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vY2QMW758aRtbmkbUjdvSpe39SY=; b=ZIQ9ip
	bQHsbNjcWOuKQoutMudpOcDn9q/ldxRF5ujbVDcgjhO0th6d/5ybcetab5XD3BKI
	XbHFOtkCXlJ1orxWvui0U+IXiU2gPAcMbeNHvL/OMzJSUUK/4w1FL2SyjlyRpBWi
	fvUtxGxkFs3bnHwcJ8lanNyhXNQMzLZvGUOaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMMmHHp+yxr0larXuV3CM9B0+YmKUtEg
	oQxFf2dDE+vfBGRmU7gdTVhHF+uUG6UBKsL5TuyioFFPdGDnYGQuuVbnzvjz0srH
	ej4eqag7xGBMjDOIhIQsXWHtnYrsspuhpjp8mxUOoiin+IyOXrCWrzmBM1ZOGmpu
	OI2Zl51ELUY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE63C10236;
	Fri,  2 May 2014 13:18:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 079661022E;
	Fri,  2 May 2014 13:18:27 -0400 (EDT)
In-Reply-To: <CABPQNSa6PaTZ3coX2eU-r7BFH3JR2V6XHv4HbXxsYyxv0qA71Q@mail.gmail.com>
	(Erik Faye-Lund's message of "Fri, 2 May 2014 14:12:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6AE02B8-D21D-11E3-999C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247945>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, May 2, 2014 at 1:50 PM, Dave Bradley <dbradley2@bell.net> wrote:
>> Hi,
>>
>> I’m very new to ‘git’ github. I reported the #178 issue in github and the
>> issue has been closed, I believe this means no further discussion.
>
> When you say "the #178 issue in github", you really mean "issue #178
> for Git for Windows on GitHub", available at
> https://github.com/msysgit/git/issues/178 for those interested.
>
> That issue tracker is for the Windows port of Git for Windows. It's
> intended to track breakages in Git for Windows compared to Git on, say
> Linux. It's not a general issue tracker for problems with Git. Still,
> it seems a lot of people think "I downloaded Git for Windows, and
> here's something that didn't work the way I expected it to, I'll file
> a bug". Those kinds of bug-reports usually gets closed quickly, as
> it's outside the scope of Git for Windows to decide how Git should
> behave - we try to make it behave consistently between Windows and
> Unixy-platforms.
>
> This is indeed the right forum to address your issue. So thank you for
> moving the discussion here.

Hmmmmmm, everything you said in the earlier paragraphs is correct,
but I am having a feeling that this is either an issue specific to
the Windows port, or more likely a user error, depending on who is
giving the extra dq quoting.  From the command line:

    $ git show --pretty='format:"%an %ad"'
    "Junio C Hamano Wed Apr 30 11:01:42 2014 -0700"

Because the 'format:' specifier requests to put dq around these two,
we respond by putting dq around these two, just as we were asked to
do.  The way to ask %an followed by SP followed by %ad and nothing
else is

    $ git show --pretty='format:%an %ad'
    Junio C Hamano Wed Apr 30 11:01:42 2014 -0700

Especially this part from the original tells me that this is a user
error and there is nothing wrong in either the generic Git or in the
Windows port.

    G:\w....x>git log --all "--pretty=format:"%an %ad"" -- pom.xml
    fatal: bad revision '%ad'

Separating the tokens on that command line, we would get:

    git
    log
    --all
    --pretty=format:%an
    %ad
    --
    pom.xml

So it told git to run the log subcommand with arguments that tells
it to "include all tips of refs to the starting set", "show them
using a custom format %an", "include %ad to the starting set",
"everything that follows are not revs but pathspecs", and then
finally "pom.xml is the pathspec to limit to paths the user is
interested in".  "%ad is not a rev" is perfectly valid.


You cannot take --pretty=format:"%ad %an" that you see in tutorials
and random web pages too literally.  The double quotes you see in
that example is our way to tell that "--pretty=format:%ad %an" (what
is inside these dq) is expected to be fed to Git as a single
argument.

The examples you see typically follow the convention to show what
you _would_ give to shell to achieve that, and shell's command line
parser needs these dq to make sure that the SP between %an and %ad
is not taken as an argument separator.

Your custom front-end may take a different approach to let you
specify what individual arguments are on your command line, and you
would have to follow its convention.  The user needs to be careful
about how shell quoting works on his/her command line, and that is
all, I would think.

Visiting an earlier part of the original issue report:

    Getting a fatal failure when using the following
    --pretty=format:"%an %ad" via a programmed execution from within
    a programming language. (Java using the execution capabilities
    puts the ' --pretty=format:"%an %ad" ' as an argument).

I take that "Java using ..." to mean that the user wants to see his
machinery eventually do an equivalent to:

	execl('git', 'git', 'log', '--pretty=format:%an %ad', ...);

but it somehow is getting

	execl('git', 'git', 'log', '--pretty=format:%an', '%ad', ...);

due to reason unknown to us that is not in the report.

Without knowing what the end-user input to the front-end that calls
into that "Java" machinery is and what the argument separating
convention that is employed by the front-end is, I cannot tell where
the single argument is split into two.  The problem may either be in
that front-end program and not in the end-user input.  Or the
problem may be in Windows port letting the Windows library split
command line at a funny point.  In any case, it does not sound like
it is a problem in Git.  If the command fed to the equivalent to
execl() above were not 'git' but any program, it will suffer from
the same issue.
