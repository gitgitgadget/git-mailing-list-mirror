From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 21:52:59 +0100
Message-ID: <54A310AB.7050701@alum.mit.edu>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63my-0008Lp-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbaL3UxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:53:07 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50520 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751424AbaL3UxG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Dec 2014 15:53:06 -0500
X-AuditID: 12074412-f79e46d0000036b4-95-54a310ad8404
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FA.74.14004.DA013A45; Tue, 30 Dec 2014 15:53:02 -0500 (EST)
Received: from [192.168.69.130] (p4FC97E58.dip0.t-ipconnect.de [79.201.126.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBUKr0n6004367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Dec 2014 15:53:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqLtOYHGIwZoJrBZdV7qZLGaeecrk
	wOSxc9Zddo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDOat65mLtghULF62xGmBsbvPF2MnBwSAiYS
	G1euYIGwxSQu3FvP1sXIxSEkcJlR4tPWvcwQznkmiaVz7rF2MXJw8ApoS1xZzAFisgioSmxr
	MADpZRPQlVjU08wEYosKBElcadnMDGLzCghKnJz5BGy+iIC7xJLfD8FsYQFLiQdv57OB2EIC
	ARJLdn1hARnJKRAo8XyXDkiYWUBd4s+8S8wQtrxE89bZzBMY+WchmToLSdksJGULGJlXMcol
	5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQEo9AOxvUn5Q4xCnAwKvHwbni/MESI
	NbGsuDL3EKMkB5OSKK8U8+IQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8SjxAOd6UxMqq1KJ8
	mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCd4yfqBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFA0xhcD4xEkxQO09yNIO29xQWIuUBSi9RSjopQ47y6QhABIIqM0D24s
	LMW8YhQH+lKYNwOkigeYnuC6XwENZgIaPOvgfJDBJYkIKakGRrFDdiol2za0Bjq+Ue9O0L1i
	kTU1hn3e7m1THvHk3YucnOO3VJg39a5RU8PjfsHDdQ+bPpZnvWhSTTNM7n2re1B5n9OS95mv
	F/V97UhNalqyjctMdUrCB16zhc5lUhrXDtQnfJv7nUt81jqhU+V8C7336K3t5gwP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261944>

On 12/30/2014 09:12 PM, Robert Dailey wrote:
> I was surprised to find today that the following didn't work as expected:
> 
> $ git show master@{"1 year ago"}:Path/To/File.h
> 
> It gave me the following warning which did not make the problem obvious at all:
> warning: Log for 'master' only goes back to Mon, 8 Sep 2014 12:08:44 -0500.
> 
> What it is trying to tell me (and I only found this out after a lot of
> poking and prodding around Google) is that I can't refer to a commit
> by date if it extends beyond the range of the reflog.
> 
> I don't understand why this requirement is in place. Each commit has a
> time stamp, so in theory it should be possible to calculate an
> absolute date from the duration specified in the refspec and grab the
> commit from `git log` from that.
> 
> I can only assume I'm oversimplifying things and that there is a good
> reason for this. If I can't get this to work, how can I view the
> contents of a file at a specified relative time frame as I have done
> above?

The syntax you are using,

    master@{"1 year ago"}

tells you "what commit was the master branch in this clone pointing at
one year ago?" What you presumably expected is "What is the last [1]
commit that is *currently* on the master branch that was committed at
least one year ago?"

The command to ask your question is something like

    git log --date-order --before='1 year ago' -1 master

There is yet a third similar question: "What is the last commit that is
currently on the master branch that was *authored* at least one year
ago? Please note that this question is even subtler, because author
timestamps are often out-of-order even on a single branch (whereas
commit timestamps are usually in order). I don't know of a simple git
command to answer this question.

Michael

[1] Note that "last" is a bit subtle, because the history of "master"
probably contains multiple branches with interleaved dates. So depending
on your needs, you might want to add an option like "--first-parent"

-- 
Michael Haggerty
mhagger@alum.mit.edu
