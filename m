From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: "git fmt-merge-msg" usage (was [PATCH v2 00/46] "struct pathspec"
 conversion and :(glob) and :(icase))
Date: Fri, 16 Aug 2013 16:07:43 +0200
Message-ID: <520E322F.4040509@alum.mit.edu>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com> <7va9lna48n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 16:07:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAKgz-0007mJ-09
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 16:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3HPOHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 10:07:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52497 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866Ab3HPOHr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 10:07:47 -0400
X-AuditID: 12074414-b7f626d0000001f1-2b-520e3232633c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 91.1F.00497.2323E025; Fri, 16 Aug 2013 10:07:46 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7GE7i5Z018109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Aug 2013 10:07:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7va9lna48n.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SXUhTURzn3LuPu+mV43XO4zKjiQnZTC1qSF8PEj5VzOhBCju6m1tud3bv
	JhpI2/qANh22InKIRBKKIdIgtCAfhiGWhNnwIdOyRpJiD5VmCNE9Dj/efuf8vjjn/2do7oHS
	wNgFNy8K2GFUaRWcuny3qbQ0zVL8L15mDsSDlNnbFqfNwXtL4ARd8Twyo654N5lX8Suae4au
	SjlSg92NlfY6Yf+xiyk2X7Bf2eBnmz6EJxVecFMbAAyD4EHU9akyADQy1KOJ2QFVAGgZDr4H
	aHziM508TFHoT2JFSVQsLEQj0/NqghUwH91e/UYTrIIm9Kj1OkVCM+E5FF/LT8rT0VhHQkGw
	Du5Bd27F1jENbWh0sXMdZ8Ar6NXizHokB+vRm1lSxTAaeAj19F8gkIYFaKCLSzp3ocGlTrod
	wMi2gsiWKrJN9RDQfSAXOzxOkxPbHRJfa5JqsSDwoslc5LS7i3irJwqSP6sbAiNjuTEAGWBM
	ZXtDrIVT4kap2RkD2QxlzGRxSZqFS6txWZttWLJVix4HL8UAYmijjn1WLHOsFTdf5UXXBrWD
	URiz2JXuglMcrMNuvp7nG3hxg81hGCNie0lousjX8U2X7A73Fk0xGhKuNegkXrDyIva4bdVk
	oNWSPFFCpcq9QWJnpQbslG+T1tfAxPzwd/0EnEJwCbwhi20hIkhENo+wWbGxUAsgS35xBhsm
	qlR53TaTFuQSSi4Jj7OkxI23KIMXZOMe3/mpaypPxovRt0d9huNPqD5ntqYj2vjXPhdCH/O/
	Dqsf5z2trVJN+lOo2bbDi91iYY2vN9hS5TgdWY39LlvGocHRUlO5N8eyfNcyfJ87 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232430>

On 07/15/2013 11:43 PM, Junio C Hamano wrote:
> [...]
> This was a good exercise for git-imerge.[...]
> 
> A few things I noticed:
>  [...]
> 
>  - The final step "imerge finish" gave me this ugliness:
> 
>      Merge commit 93d9353... into commit cb5d2fc7
> 
>    Perhaps you can at least use the initial branch name
>    "nd/magic-pathspec" I gave you, and use "git fmt-merge-msg"?

I tried to implement this but it is not obvious from the documentation
(to say the least) how to use "git fmt-merge-msg".  It appears that this
program takes, on standard input, something like

    <sha1> TAB TAB <text1> LF
    <sha1> TAB TAB <text2> LF
    <sha1> TAB TAB <text3> LF
    ...

(the two TABs are required!).  Then the <text> is somehow stuck in the
first line of the merge log message, like

    Merge <text1>; <text3>

except apparently the second line is omitted.  If somebody would explain
to me the point of this and how it is intended to be used, then I
volunteer to improve the documentation.

But a bit of the magic of these merge messages is how the <text> are
generated in the first place; e.g.,

    refs/heads/foo -> "branch 'foo'"
    refs/remotes/bar/baz -> "remote-tracking branch 'bar/baz'"

Is this magic available via any Git commands, or do I have to replicate it?

I'm sorely tempted to have git-imerge do a throw-away "git merge" of the
two branch tips just to have Git generate a full merge commit message
for me (it might even be nice to include the list of the files that
would have conflicted).

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
