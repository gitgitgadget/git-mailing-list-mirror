From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: PUSH_HEAD, was Re: disallowing push to currently checked-out 
	branch
Date: Tue, 17 Feb 2009 17:42:35 -0500
Message-ID: <76718490902171442q38dd8977ob5754fc071812f98@mail.gmail.com>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
	 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
	 <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
	 <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
	 <20090216225226.GB23764@sigill.intra.peff.net>
	 <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
	 <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302>
	 <76718490902170929v3ed9e3c2tb2f7fb1bfc01b3ab@mail.gmail.com>
	 <7vy6w43duw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:44:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYfd-0006Qd-Ig
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbZBQWmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZBQWmh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:42:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:48982 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbZBQWmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:42:36 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2218910rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 14:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LWSpXX1vd5QnjYaIvx1G9a5zud7/fLq1W4nSlFn2FpI=;
        b=GE7j3aOP3G3X/dhQgDdpNq/lMp5vcth1q0UvirFOV4sTnChZ3Q47PhlZx31rDvX5GT
         M+J9rGrzPuHcHW7tv6sAPwz0qFW2qb3Fr11+S6ON4S72YuqeTaJMxyN/JUbX957jku0J
         6PEWdw4yYjba8bFBY8iB6/EAfj8BAxv6qqs6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=huNVBqY10eSYbZkWaL4oHvlI7eS6Uv93MC8UtvOyVxsH21sl4MqRPudqh8MyTR38ne
         snwLsL9fKzmyt63ibZME6e5nXWjruhl6lNN0JxHtng0tSd3stHhAULp9ipckIv3CEsEM
         PCjsCNe2XXfhzS0+ZBFvjcifX5P48Gx0Pt62c=
Received: by 10.140.157.1 with SMTP id f1mr2779249rve.196.1234910555567; Tue, 
	17 Feb 2009 14:42:35 -0800 (PST)
In-Reply-To: <7vy6w43duw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110459>

On Tue, Feb 17, 2009 at 5:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> So both you and Junio have changed your mind since that thread then.
>
> At least I didn't.

Ah, I didn't mean to mischaracterize your intent from that thread then.

> I personally was not too worried about protecting either local branches
> nor the current branch (and I do not lose sleep over them now either).
> Either is about forbidding an end user who knows from doing an operation
> we have allowed so far, only because an abuse of the feature by other end
> users who either don't know what they are doing or are careless can result
> in confusing the latter.  I do not particularly like that kind of safety
> valve.
>
> The current round of protecting only local branches is there because it is
> of much lessor impact, with simpler code (and easier revertibility if
> needed), than the full blown "protect these branches" one in which issues
> in its design still has to be ironed out if we go that route (see my other
> message from yesterday to Jeff --- we discuss exactly that in the context
> of detached HEAD and other operations).  The need for "current branch
> protection" this round implements also comes from an observed confusions
> in real world users Dscho and others saw on #git and other places.  The
> more general "protect these branches" is conceptually nicer but the need
> for such safeguard is still under discussion as far as I understood what
> was said in the recent discussions.

Okay, that makes sense.

j.
