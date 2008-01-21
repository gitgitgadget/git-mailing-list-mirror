From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Sun, 20 Jan 2008 22:26:33 -0800
Message-ID: <402c10cd0801202226y5bf3e00duf8ae190c6a751ee3@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	 <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	 <7vodbibzch.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
	 <7vzlv2858y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 07:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGq7e-0002Ty-KA
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 07:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbYAUG0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 01:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbYAUG0g
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 01:26:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:55912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbYAUG0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 01:26:35 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1704940fga.17
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 22:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tCvgTyIy8k/4q2+SbbAgQ734alf9sYGC54tnOe+mHE4=;
        b=EpVD8H49I9Htg/0IsYzansLDbyu+dTPQDNDovTthWrKkW5qAdYUlYtZ3zsZwfLE7hhR3+KHrRtaxK704jYswrwFnXCxPegxw/1g9doR2FRthqfAI4d98eEnvhiRmq/71u8mhmUhM8mEKONblOaBk2hXj31DQnyO9wfrnAW+voLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EqyDUCZwZPjJeUfq2E3ZpHpcn3cFXz6js+d14pIsiYvQiwbJWoslILCAfFbq4uCwIGGoCpLXFUu38zLQea+7ghG1/KCvdEbQhzGK2ulY/P8s+2SNIal9lbBthe5tHekojuaAyrc7EY7PPJyOJKpq3Yh22qABGqvM8f3/9DmIicU=
Received: by 10.82.181.7 with SMTP id d7mr11677826buf.8.1200896793203;
        Sun, 20 Jan 2008 22:26:33 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Sun, 20 Jan 2008 22:26:33 -0800 (PST)
In-Reply-To: <7vzlv2858y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71226>

On Jan 19, 2008 2:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> At one end of the spectrum, we have these crazy people who want
> git to record something that is not a merge at all as a merge
> with --no-ff.  At the other end of the spectrum, we have these
> other crazy people who want git to outsmart them by allowing
> them to throw random set of commits as potential parents,
> remove duplicates and figure out how many real parents the
> resulting merge should have (including the case that it may not
> even have any).

I am currently working on a patch for this.  I have some new tests for
this but more is needed and there is no documentation.

The only case that currently is not working is the case where I need
to fast forward head and then do a merge.  Do I need to update the
files in the working directory twice (once after the fast forward and
then once by the merge) or can I somehow get lets say
git-merge-recursive to do this part for me?

The patch I have that handles the above failing case by not fast
forwarding HEAD, but instead use it together with the other real_heads
work (all tests succeed).

-- 
Sverre Hvammen Johansen
