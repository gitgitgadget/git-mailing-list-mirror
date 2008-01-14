From: Steffen Prohaska <prohaska@zib.de>
Subject: safecrlf not in 1.5.4 (was Re: [PATCH] Teach remote machinery about remotes.default config variable)
Date: Mon, 14 Jan 2008 07:49:14 +0100
Message-ID: <31687420-EB17-4651-AD6C-07213311ABDA@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEJ9J-0003wg-Lk
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 07:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbYANGtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbYANGtx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 01:49:53 -0500
Received: from mailer.zib.de ([130.73.108.11]:34144 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbYANGtw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 01:49:52 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0E6mBCR002861;
	Mon, 14 Jan 2008 07:49:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9373f.pool.einsundeins.de [77.185.55.63])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0E6mAaq005709
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 14 Jan 2008 07:48:10 +0100 (MET)
In-Reply-To: <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70443>


On Jan 14, 2008, at 2:50 AM, Junio C Hamano wrote:

> Recently I looked at the following patches and topics but I do
> not think any of them belongs to 1.5.4.  None of them is obvious
> and trivially correct fix to regressions or serious existing
> bugs:
>
[...]


>  * crlf (Steffen Prohaska and Dmitry Potapov)

[...]


> I am hoping that authors will resend the ones they really care
> about after 1.5.4, as I do not want to take patches early.

Thanks for your update on this.  I agree with your opinion,
although I'd prefer to have the safecrlf option soon.

Without safecrlf I'll not enable core.autocrlf=true in msysgit.
Now that I see a reasonable way of having at least a warning
about potential data corruption when core.autocrlf=true, I'm
even stronger against enabling it without a safety valve.

As I pointed out in the recent CRLF discussion, I believe the
problem is not specific to Windows but is about a reasonable
default configuration for cross-platform projects.  CRLF
conversion must be enabled on all platforms to have good defaults
for a mixed Unix/Windows environment, and hence the safecrlf if
also needed on all platforms.

So I don't see much value in having the safecrlf only in msysgit
and not in official git.

Junio,
Do you see a chance to have safecrlf in 1.5.4.1?

I am currently considering wether it is worth following the maint
series of official git with msysgit.  That is we'd have a maint
branch in msysgit, which would merge from Junio's maint.
Although we're still in preview mode with msysgit I tend to
believe that this would be a good idea.

The preview tag is mostly due to the unspecified set of features
of msysgit, not that I think part of msysgit is not already very
stable and usable.  But msysgit only supports a subset of the
commands of official git and we don't really say or even know
which commands currently work reliably.  It could be worth to
compile such a list and only install the commands that we are
convinced of being ready for production.

	Steffen
