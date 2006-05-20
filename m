From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 14:32:57 -0700
Message-ID: <20060520213257.GH24672@kroah.com>
References: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net> <m13bf95ixo.fsf@ebiederm.dsl.xmission.com> <7v1wut2p5z.fsf@assigned-by-dhcp.cox.net> <m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com> <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net> <m1zmhg31cm.fsf@ebiederm.dsl.xmission.com> <7vy7x09qet.fsf@assigned-by-dhcp.cox.net> <m1ejyr38xx.fsf@ebiederm.dsl.xmission.com> <20060519235825.GA3289@kroah.com> <m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 23:40:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhZB3-0004MR-JX
	for gcvg-git@gmane.org; Sat, 20 May 2006 23:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWETVj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 17:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWETVj5
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 17:39:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:1961 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932385AbWETVj4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 17:39:56 -0400
Received: from [192.168.0.11] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k4KLdcK03585;
	Sat, 20 May 2006 14:39:38 -0700
Received: from greg by press.kroah.org with local (masqmail 0.2.19) id
 1FhZ4D-6Ra-00; Sat, 20 May 2006 14:32:57 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20396>

On Fri, May 19, 2006 at 08:42:38PM -0600, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Thu, May 18, 2006 at 04:48:26AM -0600, Eric W. Biederman wrote:
> >> 
> >> Yes, a smaller patch series, that is what I meant.
> >> Most quilt trees that I know about are  small.
> >
> > $ quilt series | wc -l
> > 207
> >
> > And that is about "normal" for me.  Sometimes it grows to about 500+
> > patches, but that only happens when there's a longer kernel release
> > cycle.
> >
> > Another tree that I work on all the time is about 700+ patches, and yet
> > another 2000+.  So you might re-evaluate your statement about "small"
> > quilt series :)
> 
> Sure.  On fixing the upstream attribution issue you and Andi Kleen 
> look like people that are worth talking to, as there were several
> patches in Andrews tree from both of you that were lacking attribution.

Yes, I know I don't put any headers on patches I create until they are
ready to be sent upstream to Linus.  I'll try to be better about that in
the future, sorry.

> > In looking at your script, it doesn't seem to be able to handle patches
> > in quilt that are in mbox format.  Any thoughts to allow this to handle
> > the attribution properly?
> 
> Mbox format but one patch per file, or multiple patches in one mbox file?

The patches are already in mbox format in each file, but I dump them all
together into one big one, to preserve the proper order as defined in
the quilt series file so that git gets it right.

> If it is one patch per file but with mbox headers, it is relatively
> simple to teach git-mailinfo to parse things in a slightly more intelligent
> way.  I played with that but I didn't have any patches that helped with.

Hm, I'll try playing with that.

If you want, just grab my quilt trees from kernel.org and play with
them, they should all be in mbox format for the individual patches (with
some exceptions as noted above, just kick me about them to get me to fix
them...)

thanks,

greg k-h
