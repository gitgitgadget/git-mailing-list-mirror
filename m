From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Fri, 6 Mar 2009 01:52:49 -0500
Message-ID: <76718490903052252y1778aa41g8f3e52329f7bf288@mail.gmail.com>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>
	 <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
	 <alpine.LNX.1.00.0903060038510.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 07:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfTwq-0005ad-Hb
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 07:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZCFGww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 01:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZCFGww
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 01:52:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:31923 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZCFGwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 01:52:51 -0500
Received: by rv-out-0506.google.com with SMTP id g37so356978rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 22:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pjnoXY6+84huIoG+jxPeGHukX5K8Q9eYpzZgDRy/5OI=;
        b=jQFxW3FV6Pagr1eIz4rQPSuflY6pLwlv6bxKvynpxk3Je1kImgzvH7bhwK35yS87lR
         Vt2yxY1hbW9LcPP0OTMO29YA7JKlKD9m1qV0j/L8l5rJI3N1KSV8aHK4+iKtxZURx6Tc
         5Ugcg0Mv44zrCgITtZomu7PnF4S0jpScJbchM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oRrmlrACgXxaMGO+Ho47Def5hJQyyQ9L9S5cZOpoWVq5q6ZoO9O/27rXXCouxRU1ZW
         NAQZvhv9bsi/hxP4mBKZooghWNZGOrd4w0avX3q3E0tz4+9GTWW5igmm44hYndQjE5+4
         RkEprpad8NCxt51zHxuT2shJqGnQqY6qDMbbI=
Received: by 10.141.62.9 with SMTP id p9mr351375rvk.86.1236322369523; Thu, 05 
	Mar 2009 22:52:49 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0903060038510.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112393>

On Fri, Mar 6, 2009 at 1:07 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 6 Mar 2009, Jay Soffian wrote:
>
> Actually, you should be able to just drop your "buf" and use spec->src and
> spec->dst, since it just stores the original strings. So that should be
> easy enough, although it might be good to go through a remote.c function
> just in case it becomes more complicated later. On the other hand,
> get_head_names() should probably get a patch like my 1/5 to have it use
> the remote.c parser, or should use a constant "head mirror" refspec like
> that tag_refspec already in remote.c

Okay.

> Do you have tests for "git remote show -n"?

Yes. Apparently not enough of them though if nothing is failing.

> Merging my series (on top of
> origin/master) and e5dcbfd and adding a final '*' to the string in
> get_head_names() made everything pass for me, without doing anything about
> the extra *s, but the output is clearly not quite right.

Hmm, alright.

> I'm not seeing anything that makes assumptions about the matching
> semantics of pattern refspecs, just stuff about how the stored form
> relates to the config-file form.

Okay, that sounds right.

I assume your series will end up in pu soon enough, and I think my
series is about to hop to next. What's the right way to to have them
be happy together?

j.
