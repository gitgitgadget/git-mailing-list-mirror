From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 04/18] notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
Date: Wed, 6 Oct 2010 21:40:56 +0200
Message-ID: <201010062140.56999.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-5-git-send-email-johan@herland.net> <20101005153838.GG12797@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 21:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ZrD-00062x-Me
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 21:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759169Ab0JFTkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 15:40:49 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:56744 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab0JFTks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 15:40:48 -0400
Received: from dslb-088-073-123-190.pools.arcor-ip.net ([88.73.123.190] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P3Zr3-000NHy-QC; Wed, 06 Oct 2010 21:40:45 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20101005153838.GG12797@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158301>

On Tuesday 5. October 2010 17.38.38 Jonathan Nieder wrote:
> Johan Herland wrote:
> > The combine_notes_fn functions uses a non-zero return value to indicate
> > failure. However, this return value was converted to a call to die()
> > in note_tree_insert().
> 
> For what it's worth, I still like it.
> 
> > Instead, propagate this return value out to add_note(), and return it
> > from there
> 
> It's always odd deciding what to do in the code paths that "can't
> happen".  Ideally one would want static analyzers to check that, while
> at the same time subjecting the user to some nice graceful fallback
> behavior when it happens anyway.
> 
> 	fatal: confused: combine_notes_overwrite failed
> 
> In this case I'm not sure what the message in die() should be, but
> it seems sane to die with some message.  Maybe this should be
> mentioned in the commit message, though?

Ok, I've added a paragraph to the commit message mentioning that most of 
add_note()'s callers now implement the die() previously located in 
notes_tree_insert(). Will be in the next iteration.


Thanks,

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
