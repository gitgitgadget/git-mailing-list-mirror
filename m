From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: git branch -a now reports 'remotes/foo' rather than 'foo'?
Date: Mon, 11 May 2009 17:01:33 +1000
Organization: I know I put it down here, somewhere.
Message-ID: <87my9knmwi.fsf@rimspace.net>
References: <87skjcpeno.fsf@rimspace.net>
	<76718490905102226w4cda3a75l5062e1956129dc87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 09:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3PmG-0007JM-K2
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbZEKHSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2009 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZEKHSK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:18:10 -0400
Received: from main.gmane.org ([80.91.229.2]:48557 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbZEKHSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:18:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3Pm4-0006Xu-Ig
	for git@vger.kernel.org; Mon, 11 May 2009 07:18:08 +0000
Received: from sdcarl02.strategicdata.com.au ([203.214.67.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 07:18:08 +0000
Received: from daniel by sdcarl02.strategicdata.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 May 2009 07:18:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sdcarl02.strategicdata.com.au
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:J3Aq36zYegwMwNHfTryMxGj4R/A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118776>

Jay Soffian <jaysoffian@gmail.com> writes:
> On Sun, May 10, 2009 at 10:16 PM, Daniel Pittman <daniel@rimspace.net=
> wrote:
>> The front-end I am using looks for a 'trunk' branch by name in the
>> output of 'git branch -a', which historically worked. =C2=A0Now, tho=
ugh, it
>> shows that fully qualified.

[...]

>> I wanted to confirm that this was a deliberate change before I went =
to
>> the trouble or rewriting the front-end code however.
>
> Yes, the change was deliberate. Commit 209d336 (builtin-branch:
> improve output when displaying remote branches, 2009-02-13) has more
> details:
>
>     When displaying local and remote branches, prefix the remote
>     branch names with "remotes/" to make the remote branches clear
>     from the local branches.

Isn't the use of colour sufficient to do this?  Ah, well.  That horse,
I think, has bolted, and my own end-users thoughts about the incoherenc=
e
are, I suspect, of little relevance now.

>     If displaying only the remote branches, the prefix is not shown
>     since it would be redundant.
>
> When you fix your front-end, I suggest you stop parsing git branch's
> output. It is a so-called porcelain command, as opposed to a plumbing
> command, and so its output is subject to change. You probably want to
> use the for-each-ref command instead.

It isn't my front-end, but I shall take a look and see if I can send
upstream a suitable patch.  Thanks for the advice.

Regards,
        Daniel
