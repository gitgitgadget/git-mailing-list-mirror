From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 00:15:12 -0400
Message-ID: <76718490903102115x27a869f2la0d5ca9003bcc95a@mail.gmail.com>
References: <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
	 <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
	 <20090311030604.GA3044@coredump.intra.peff.net>
	 <76718490903102044j4ca3462eye5ffcb178608dc29@mail.gmail.com>
	 <20090311035701.GA6089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhFs4-0004Iy-IX
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 05:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbZCKEPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 00:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbZCKEPP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 00:15:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:9790 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZCKEPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 00:15:14 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2549628rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sN3oCsQdrkxmg+68f+czG66bJIQ0UBTBiPx6exbL+bM=;
        b=f8kZWfh6lol4aYqIzSg7DN5RLbDZbWjwUE7abDVhitj5lY0K74vG+NbVSaBCeXFxQb
         OHESGEVei6ql3bhFqy2IIWG3eQi3sOtNAOQZ13hi9cdzSmVdNLyCHxeuCqCt1U88ICC6
         9OHgjXizTWCu6TeFuLWt7foXUG62s2k1kialc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=okHBz+UOPoPPzLek4PWGlAOZfwmqtIZvkw4P1UjO7wydOwTIfwPzOVGn+G16b5mdpj
         xJRiD/QJilj/det8PtiLfBMNgeM1tDtU+aWWXi2pnWXKO09nt0SsrVuG2K7fpvt42lcx
         Xzk4G5sAfcE55o6DG9Ol4vuxtrPDUVQJvPgv8=
Received: by 10.141.2.18 with SMTP id e18mr4147515rvi.29.1236744912522; Tue, 
	10 Mar 2009 21:15:12 -0700 (PDT)
In-Reply-To: <20090311035701.GA6089@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112877>

On Tue, Mar 10, 2009 at 11:57 PM, Jeff King <peff@peff.net> wrote:
>> -u w/o --track/--no-track is a usage error.
>
> Then what is the point of "-u"? You said before that it was a new
> operation with room for future growth of additional options. Either it
> is _just_ for --track, in which case I think you are better to have a
> single option representing the notion of "update the tracking setup", or
> it isn't, in which case it needs to have room for future expansion.

For *now*, it is just for --track/--no-track, since I can't think of
anything sensible that "-u" without --track nor --no-track would do.

So it means, update the branch config, but you have to tell it what
aspect of the branch config to update.

I agree that currently, a single option could do here, but I can't
think of a good one. --add-tracking and --delete-tracking? I was
trying to re-use the fact that we already have --track and --no-track,
but I needed some way to differentiate the mode from "create a new
branch". Hence -u.

j.
