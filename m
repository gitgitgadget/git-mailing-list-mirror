From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git merge no longer handles add/add
Date: Tue, 20 Nov 2007 07:33:27 +1300
Message-ID: <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com>
	 <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com>
	 <7vtznipweu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBS4-0004n4-I6
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXKSSda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXKSSd3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:33:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:54905 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXKSSd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:33:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1008349ugc
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hPdbdKnH/ibo+LzqUzcju7EU1DZVvqgMJAeKXPASQ9E=;
        b=IaGRSuPK62Q7CwgggUR5PE7kom4fqGiCkNZBU1HerA8B58nLMkOO4QiWAg1JzxdbwiWrEACzbikJ7vtwsUmf9hgbfSOz/+yvspYlrXKfrssHwUpe+bvZtCGkF21LrI8f+n1vx9ip6fZSdv3uVpQqeSSlD+Mp7YtQGilsc4lZtpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gIVYzLasu2KWasJfkyYn22SBcgBL0I5+NSW/vSds2kxlc+wj6j9KaLdVwpTZ2ZZ1goNCgDddd8MhKi92rMQgvQJWpMb8ZrL57RESDsZ+XwdxYsbqxmVtaFfYYgtZrr2Z200kQ+rtLluKXqMfJDbtGreE5NYhCfX6fo7fsvcRZUo=
Received: by 10.66.237.9 with SMTP id k9mr2520587ugh.1195497207211;
        Mon, 19 Nov 2007 10:33:27 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Mon, 19 Nov 2007 10:33:27 -0800 (PST)
In-Reply-To: <7vtznipweu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65484>

On Nov 19, 2007 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As far as the point of the merge is concerned, that's an add/add
> of _different_ contents, and we have always left the conflict to
> resolve for you since day one.  The only case we handle without
> complaining is the accidental *clean* merge.  Both branches adds
> the path *identically* compared to the common ancestor.

Even if the 2 paths did have matching content at one point? In fact,
the 2 files here get added with identicaly content and one of them is
later modified...

> The very initial implementation of merge may have used the total
> emptyness as the common ancestor for the merge, and later we
> made it a bit more pleasant to resolve by computing the common
> part of the file from the two branches to be used as a fake
> ancestor contents.  But the fact we left the result as conflict
> for you to validate hasn't changed and will not change.

In this case, if you use the common part (100%) as the ancestor, then
you get a _clean_ merge. The file is added on both sides identically,
and then it changes on one side.

I'll see if I can repro with an older git install...


m
