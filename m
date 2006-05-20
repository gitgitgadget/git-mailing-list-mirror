From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Fri, 19 May 2006 20:42:38 -0600
Message-ID: <m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 04:43:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhHRD-0003rm-OZ
	for gcvg-git@gmane.org; Sat, 20 May 2006 04:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWETCnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 22:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWETCnV
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 22:43:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53682 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932478AbWETCnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 22:43:21 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4K2gc11015186;
	Fri, 19 May 2006 20:42:38 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4K2gcub015185;
	Fri, 19 May 2006 20:42:38 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060519235825.GA3289@kroah.com> (Greg KH's message of "Fri,
 19 May 2006 16:58:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20372>

Greg KH <greg@kroah.com> writes:

> On Thu, May 18, 2006 at 04:48:26AM -0600, Eric W. Biederman wrote:
>> 
>> Yes, a smaller patch series, that is what I meant.
>> Most quilt trees that I know about are  small.
>
> $ quilt series | wc -l
> 207
>
> And that is about "normal" for me.  Sometimes it grows to about 500+
> patches, but that only happens when there's a longer kernel release
> cycle.
>
> Another tree that I work on all the time is about 700+ patches, and yet
> another 2000+.  So you might re-evaluate your statement about "small"
> quilt series :)

Sure.  On fixing the upstream attribution issue you and Andi Kleen 
look like people that are worth talking to, as there were several
patches in Andrews tree from both of you that were lacking attribution.

> In looking at your script, it doesn't seem to be able to handle patches
> in quilt that are in mbox format.  Any thoughts to allow this to handle
> the attribution properly?

Mbox format but one patch per file, or multiple patches in one mbox file?

If it is one patch per file but with mbox headers, it is relatively
simple to teach git-mailinfo to parse things in a slightly more intelligent
way.  I played with that but I didn't have any patches that helped with.

> Right now my development flow has me converting my quilt tree to one big
> mbox file and then using 'git applymbox' to import it before asking
> Linus to pull from it.
>
> With your script I could skip at least one step, which would save me
> some time...

Sure. That is the point of making it generic.

Eric
