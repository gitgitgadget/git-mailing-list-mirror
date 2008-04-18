From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/8] builtin-clone
Date: Thu, 17 Apr 2008 20:56:51 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804172052300.19665@iabervon.org>
References: <alpine.LNX.1.00.0804171923040.19665@iabervon.org> <200804180250.48544.johan@herland.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1854256940-1208480211=:19665"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 18 02:58:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmevJ-0000LN-02
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 02:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbYDRA4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 20:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbYDRA4z
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 20:56:55 -0400
Received: from iabervon.org ([66.92.72.58]:53211 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756106AbYDRA4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 20:56:54 -0400
Received: (qmail 9327 invoked by uid 1000); 18 Apr 2008 00:56:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2008 00:56:51 -0000
In-Reply-To: <200804180250.48544.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79857>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1854256940-1208480211=:19665
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 18 Apr 2008, Johan Herland wrote:

> On Friday 18 April 2008, Daniel Barkalow wrote:
> > This is my latest version, rebased approximately on current master (or 
> > recent maint, I guess). It's missing all of Johan's stuff, which is tests 
> > for stuff I've fixed
> 
> Does this mean you no longer need the tests, or that you want me to resend?

I have them, but my patch-sending process isn't set up for sending other 
people's patches without forging their email, and I wanted to get this 
series out, and they're not critical, so I skipped them for now.

> > and (after this series) a series to make the clone generate packed refs.
> 
> I'll resend the series once your work has settled down and landed in "next".
> 
> BTW, I noticed in your repo (at iabervon.org) that you put "if (0)" around
> the code generating packed-refs (using the old one instead), and added the
> following note to the commit message:

It was really mostly that the version I have in there doesn't pass the 
tests, due to not having the thing to filter packed refs.

>   I made this compile-time configurable because I'm not sure we want to
>   pack unconditionally.
> 
> We should probably figure out the right thing to do here. AFAICS,
> compile-time configurability is only a temporary measure, and we basically
> have to choose between:
> 
> 1. Add a command-line option (and config variable?) for controlling
>    whether "git clone" generates packed refs.
> 
> 2. Make "git clone" unconditionally generate packed refs.
> 
> Currently, I'm leaning towards (2), since I don't think there's enough
> drawbacks with generating packed-refs to justify adding a command-line
> option. AFAICS, the only drawback is that reflogs aren't
> created/initialized on clone, but I got the feeling that this was not
> particularly important. Quoting Junio from an earlier thread:
> 
>   Not writing reflogs is a _different_ behaviour from the previous, but I
>   suspect it might even be an improvement.  When you have 1000 remote
>   branches, probably most of them are not even active.
> 
> If there are good arguments for going with (1), I'd love to hear them.

I think it's fine, actually (now that you've not test corrections that 
work for it); but I'd like to have builtin-clone land without any changes 
in behaviour, and then get this sort of improvement.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1854256940-1208480211=:19665--
