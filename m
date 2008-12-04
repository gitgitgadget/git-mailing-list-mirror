From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 4 Dec 2008 16:58:28 -0700
Message-ID: <b9fd99020812041558w204e5f48gbed73fdbd289ad@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
	 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
	 <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
	 <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
	 <7vskp3d3q9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, sverre@rabbelier.nl,
	"Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:59:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8O6m-0005q0-0m
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 00:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbYLDX6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 18:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYLDX6b
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 18:58:31 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:27024 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYLDX6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 18:58:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2037705wah.21
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 15:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qmDZtup9K+rJ5WT39yD3o+SKiTkf6x6qsMQoLzXBLEA=;
        b=HszmcFfLIVJO4zGilreV7kNnaI85b9zZ3WDSGTzG5ZrWZXucEmOO1lG4OvV2XzVEEl
         R0AAzHacgN9pG6ukOr4SEjm2/CZ46gsiWclz44Lf3BHLiUDfprWGqy3C838SNolRAouA
         f8qeILnaZRs/7ppxFs73r86QieX/QB9d0KPEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ybsyfwnvji7C0xR4vkkbmRRmZpJfmpIK7dw/9vpU3NUUM4VGXDCXMo8txPfD+DPo+q
         Pi+JWkTBQgTXjgfqgjFtXVxpu0yOfC/As1a05B+oqbej9ac6+/GcNkbsShV7g1uB2h3A
         ElY1ZfzBwmkkOX+K16Ng3jSb0bl0T5jyysysQ=
Received: by 10.114.153.2 with SMTP id a2mr844564wae.170.1228435108967;
        Thu, 04 Dec 2008 15:58:28 -0800 (PST)
Received: by 10.114.57.17 with HTTP; Thu, 4 Dec 2008 15:58:28 -0800 (PST)
In-Reply-To: <7vskp3d3q9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102378>

On Thu, Dec 4, 2008 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jeremy Ramer" <jdramer@gmail.com> writes:
>
>> On Thu, Dec 4, 2008 at 12:04 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>>> On Thu, Dec 4, 2008 at 17:05, Jeremy Ramer <jdramer@gmail.com> wrote:
>>>> That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
>>>> message every time I start git gui.  I actually find this really
>>>> annoying and would like a way to turn this warning message off.
>>>
>>> git config --global user.name "Your Name"
>>> git config --global user.email "you@example.com"
>>>
>>
>> I have done that.  I still get the warning message every time I start git gui.
>
> I do not use Windows, and I do not run git-gui, so I am guessing only from
> the source.  Are you talking about the message composed by this part?
>
>    # -- Warn the user about environmental problems.  Cygwin's Tcl
>    #    does *not* pass its env array onto any processes it spawns.
>    #    This means that git processes get none of our environment.
>    #
>    if {[is_Cygwin]} {
>            set ignored_env 0
>            set suggest_user {}
>            set msg [mc "Possible environment issues exist.
>
>    The following environment variables are probably
>    going to be ignored by any Git subprocess run
>    by %s:
>
>    " [appname]]

Yes, that does appear to be the message I get, with the following
environment variables:
- GIT_AUTHOR_EMAIL
- GIT_COMMITTER_NAME
- GIT_COMMITER_EMAIL
- GIT_AUTHOR_NAME

Now that I look closer I see that I am setting these in my .bashrc
file.  When I first started using git a year ago I was given the
impression that these were needed. But I see that that is no longer
the case since I use the config:

git config --global user.name "Your Name"
git config --global user.email "you@example.com"

Removing them from my .bashrc removes the warning.  In hindsight the
warning should have clued me in, but I've been seeing that message
since I first started using git on Cygwin so I figured it was a cygwin
issue that I couldn't do anything about.

>
> The logic to produce the error message does look somewhat screwy.
>
> It checks a selected set of variables whose name begin with GIT_ in the
> environment, and if it finds any, it gives the above message.  In
> addition, if GIT_{AUTHOR,COMMITTER}_{EMAIL,NAME} are among them, it also
> adds this to the message:
>
>                    if {$suggest_user ne {}} {
>                            append msg [mc "
>    A good replacement for %s
>    is placing values for the user.name and
>    user.email settings into your personal
>    ~/.gitconfig file.
>    " $suggest_user]
>
> There are two and half issues about this code.
>
>  (1) When it prepares additional message about user.{email,name},
>     it does not check if the user already has them defined.  IOW, there
>     is no way other than unsetenv before running git-gui to squelch this
>     part of the message.
>
>  (2) For other environment variables, such as GIT_PAGER, it does not offer
>     alternatives, such as core.pager.  Again, there is no way other than
>     unsetenv to squelch the warning.
>
> An excuse to both of the above could be that the warning is not about the
> user having environment variables that can be discarded, but about
> brokenness of Cygwin Tcl envirnonment that discards them.  But if that is
> the case, there is this other half issue:
>
>  (3) The warning does not trigger if the environment is not set when this
>     check is made.  Now I do not know if git-gui tries to spawn
>     subprocesses with its own (customized) environment settings (e.g. you
>     would need to be able to run git-commit-tree with modified
>     GIT_AUTHOR_NAME if you want to use the lowlevel plumbing to create a
>     new commit and lie about the author identity), but if it does, the
>     warning does not trigger.
>

I agree that the logic could using improvement.
