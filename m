From: Bernt Hansen <bernt@alumni.uwaterloo.ca>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Wed, 26 Dec 2007 12:47:36 -0500
Message-ID: <87myrxqrev.fsf@gollum.intra.norang.ca>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca>
	<8763yof9lg.fsf@gollum.intra.norang.ca>
	<Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<20071225044202.GO14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 18:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7aMb-0007w0-Ru
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 18:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbXLZRrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 12:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXLZRrx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 12:47:53 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53854 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbXLZRrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 12:47:52 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1J7aM9-0000aE-Um; Wed, 26 Dec 2007 17:47:50 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19pERVOAkEgdGgbeS/Jvul8
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lBQHlgEA008201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Dec 2007 12:47:47 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lBQHlf2L006624;
	Wed, 26 Dec 2007 12:47:41 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lBQHlawK006622;
	Wed, 26 Dec 2007 12:47:36 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69243>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> This is a patch for git-gui, so why not make that clear in the subject?  
>> (And I have a hunch that Shawn would have liked the patch relative to 
>> git-gui.git, not git.git...)
>
> Indeed.
>
> its clear in both the email and in the commit log that the change is
> a git-gui change.  Remember, git-gui's logs show up in the core Git
> logs (as its merged with -s subtree) so having that git-gui: prefix
> does help people to localize the change within the overall suite.
>

Thanks for the feedback on the patch.

This is my first attempt at creating a patch for git (even if it is
mostly trivial in this case) and I wasn't aware of the git-gui.gitk repo
and conventions regarding the commit message.  I just tried to follow
what was in Documentation/SubmittingPatches.  I'll try to do better next
time :)

>> Further, there are other tools than rebase -i that like commit messages 
>> better when terminated by a newline, and _that_ is what I would like to 
>> read in the commit message for this patch.
>
> Hmmph.  For that reason alone I'm tempted to *not* apply Bernt's
> patch.
>
> There is nothing that requires that a commit object end with an LF.
> So tools that make this assumption (that there is a trailing LF)
> while processing the body of a commit message are quite simply
> broken.

Forcing a LF on the end of the commit message feels wrong to me too.

This band-aid solution fixes the issue I'm dealing with for
git-rebase -i when squashing 3 or more commits created by git-gui.

I agree with Sean and think the more correct fix would be to make
git rebase -i and any other tools we encounter with similar problems
handle the case where there is no newline at the end of the commit
message.

The patch as it stands should probably not be applied.

-Bernt
