From: Greg Louis <glouis@dynamicro.on.ca>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Tue, 13 Sep 2005 07:07:20 -0400
Organization: Dynamicro Consulting Limited
Message-ID: <20050913110720.GA4826@athame.dynamicro.on.ca>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk> <7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net> <20050911220421.GA14593@athame.dynamicro.on.ca> <20050911230136.GA15224@athame.dynamicro.on.ca> <7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net> <20050912105637.GA5290@athame.dynamicro.on.ca> <7vbr2yfp0r.fsf@assigned-by-dhcp.cox.net> <20050912163637.GA22018@athame.dynamicro.on.ca> <7v3boaawra.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Tue Sep 13 13:09:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EF8dr-0002Bj-Er
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 13:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVIMLHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 07:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVIMLHh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 07:07:37 -0400
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:58270 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S932599AbVIMLHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 07:07:36 -0400
Received: from [70.29.36.34] (helo=athame.dynamicro.internal ident=glouis)
	by csl2.consultronics.on.ca with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.52)
	id 1EF8dJ-0004EI-JD
	for git@vger.kernel.org; Tue, 13 Sep 2005 07:07:25 -0400
Received: from root by athame.dynamicro.internal with local (Exim 4.52)
	id 1EF8dE-0001KP-V3
	for git@vger.kernel.org; Tue, 13 Sep 2005 07:07:21 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3boaawra.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8464>

On 20050912 (Mon) at 1253:13 -0700, Junio C Hamano wrote:
> Greg Louis <glouis@dynamicro.on.ca> writes:
> 
> > Or (2+1==3) detect CDPATH in the same places as (1), complain with a
> > brief explanation ("don't export CDPATH; it's really only useful in
> > interactive shells") and unset it.
> 
> I like your wording above, so probably that is what is going to
> happen.  Thanks for the suggestion.

You're very welcome.

> CDPATH has two problems.  1. It takes scripts to unexpected
> places (somebody had CDPATH=..:../..:$HOME and the "cd" in
> git-clone.sh:get_repo_base took him to $HOME/.git when he said
> "clone foo bar" to clone a repository in "foo" which had
> "foo/.git").  CDPATH mechanism does not implicitly give "." at
> the beginning of CDPATH, which is the most irritating part.
> 2. the extra echo when it does its thing.
> 
> I was under the impression that the patch fixed 2. without doing
> anything about 1., but I may be mistaken.

Oh, I agree entirely that unsetting CDPATH altogether is cleaner and
more complete (and much less ugly) than putting &>/dev/null all over
the place.  I should have said something like, "My patch is
_philosophically_ about equivalent to (1)" to make it clear I was
referring to the context, ie the alternative approaches you had
proposed.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
