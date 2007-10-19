From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:39:56 +1000
Message-ID: <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
References: <20071019062219.GA28499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 08:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IilWk-0008VY-Us
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933518AbXJSGj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761404AbXJSGj5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:39:57 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:61033 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762141AbXJSGj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:39:56 -0400
Received: by rv-out-0910.google.com with SMTP id k20so378420rvb
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=t4TYXVW+0F6VXuPy4m72Jo3ABnuZ6RjHa20QvQZZytY=;
        b=B8je9Kouln8jxKADxibBQ73mpUWjKDGHm5/I2CGKLw/Q+aAwrvU6atOHkRAhZNtl0w7Xf0RAfsHt+yT4XC9SvEvfzn3jdSR7vGywvr3ygAvP6v139+MxfmszbatXogh2UI1T2WFAhBmyVGFEbbDX4fAw8rlU2W+qaVXff0+PfZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NrbK0SDEdYvGNtAXo7pPwxHugDnD2vAkikuPl4e55gZJ9CujyIIdAy5X5zetN5dxS8Y8BPDdzzRLLjxpZ9BegHCRnQlwxyg6gSOcivbV8d9x0sBHBTimC0vx+QS5YgwvqcqRe4F8heudUFaKRjuAqQAP12XQVLJZE4+hPkexfSY=
Received: by 10.141.52.5 with SMTP id e5mr780758rvk.1192775995940;
        Thu, 18 Oct 2007 23:39:55 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Thu, 18 Oct 2007 23:39:56 -0700 (PDT)
In-Reply-To: <20071019062219.GA28499@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61658>

On 19/10/2007, Jeff King <peff@peff.net> wrote:
> This makes the fetch output much more terse. It is likely to
> be very controversial. Here's an example of the new output:
>
> Indexing objects: 100% (1061/1061), done.
> Resolving deltas: 100% (638/638), done.
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> origin/gitk
>  * branch maint -> origin/maint (fast forward)
>  * branch master -> origin/master (fast forward)
>  * branch next -> origin/next (fast forward)
>  - branch pu -> origin/pu (non-fast forward, refused)
>  * branch todo -> origin/todo (fast forward)
> ==> git://repo.or.cz/git/spearce.git
>  * tag v1.5.3.2 -> v1.5.3.2

What about making it even more terse so it's even easier to visually
scan: (mainly thinking that fast-forwarding is so common it could be
considered the "default")

> ==> git://repo.or.cz/git/spearce.git
 * gitk -> origin/gitk (new)
 * maint -> origin/maint
 * master -> origin/master
 * next -> origin/next
 - pu -> origin/pu (refused)
 * todo -> origin/todo
==> git://repo.or.cz/git/spearce.git
 * tag v1.5.3.2

Also, perhaps the trailing notes (fast forward, refused, etc.) should
be significantly indented to the right to stand out even further from
branch names that might be quite long.

Dave.
