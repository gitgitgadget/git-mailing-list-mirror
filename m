From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] send-pack: don't send a thin pack when the server
 doesn't support it
Date: Sat, 19 Oct 2013 17:19:47 +0200
Message-ID: <1382195987.17156.7.camel@centaur.cmartin.tk>
References: <1381221884-27048-1-git-send-email-cmn@elego.de>
	 <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
	 <CACsJy8AHAbDuz3yhsjJfRQUGg1zzx6qqoAf=1oNhbX1xPVithg@mail.gmail.com>
	 <20131008222215.GI9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 17:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXYS5-0007xF-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 17:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab3JSP2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 11:28:25 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:36962 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab3JSP2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 11:28:24 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2013 11:28:24 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 95AD2DE729;
	Sat, 19 Oct 2013 17:19:57 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OEO6xajyZTlF; Sat, 19 Oct 2013 17:19:57 +0200 (CEST)
Received: from [192.168.1.4] (p4FC5DB15.dip0.t-ipconnect.de [79.197.219.21])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 5D743DE728;
	Sat, 19 Oct 2013 17:19:57 +0200 (CEST)
In-Reply-To: <20131008222215.GI9464@google.com>
X-Mailer: Evolution 3.4.4-4+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236402>

On Tue, 2013-10-08 at 15:22 -0700, Jonathan Nieder wrote:
> Duy Nguyen wrote:
> 
> > Or maybe it's not that late. How about you go with your patch and add
> > thin-pack capability to receive-pack too?
> >
> > When new "git push" is used against old server, thin pack is disabled.
> > But that's not a big deal (I hope).
> 
> Could we have separate patches to introduce the server-side capability
> and then to request it in the client?  That way, people with old
> servers can apply the patch introducing the capability if they want.

That could work.

> 
> The new meaning of the "thin-pack" capability should also be
> documented in Documentation/technical/protocol-capabilities.txt.

Oh, right; the capability as described is only about the server being
able to generate a thin pack. Wouldn't his mean that git shouldn't
assume that *any* remote can fix thin packs, though? (other than most
servers you do talk to happen to).

Anyway, facts on the ground and all that. I'll prepare some 

> 
> Done that way and with enough time between the server advertising the
> capability and the client looking for it, it seems like a good idea.


If such patches would be accepted, that would be great. By the time this
all gets merged, we might have thin pack fixing merged into libgit2, but
there will still be uses where fixing them isn't an issue due to other
constraints.


Cheers,
   cmn
