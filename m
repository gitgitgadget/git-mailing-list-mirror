From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Fri, 28 Mar 2008 15:52:21 +0000
Message-ID: <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>
References: <1206707716.9819.15.camel@malory>
	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 16:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfGt8-0005rT-Qe
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 16:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYC1PwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 11:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbYC1PwW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 11:52:22 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:42170 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYC1PwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 11:52:22 -0400
Received: by rv-out-0910.google.com with SMTP id k20so159438rvb.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 08:52:21 -0700 (PDT)
Received: by 10.141.211.13 with SMTP id n13mr1530248rvq.12.1206719541430;
        Fri, 28 Mar 2008 08:52:21 -0700 (PDT)
Received: by 10.140.161.13 with HTTP; Fri, 28 Mar 2008 08:52:21 -0700 (PDT)
In-Reply-To: <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 67c2b6c010ad1cc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78422>

On Fri, Mar 28, 2008 at 12:50 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 3/28/08, Alex Bennee <kernel-hacker@bennee.com> wrote:
>  >  2. Create a new repo, starting at the common ancestor point
>  >
>  >   2(a). I'd need to remove the orphaned old CVS modules which are still
>  >  around but not referenced any more.
>  >
>  >  3. Create the product branches and import ANCESTOR..BRANCH_HEAD into
>  >  them
>
>  You probably want to look at git-filter-branch, particularly the
>  --parent-filter option.
>
>  Note that 2(a) would be easiest if you just did it before importing
>  from CVS at all, since it's easy to remove old modules from CVS just
>  by moving the files out of the way.

Ahh, having investigated further it seems the repo contains two CVS
modules which account for about 1/3 of the checkout and
are not needed (as they are standalone and separate). When I do the
final import from CVS I can skip them. Having said that I'll
need to run that over the weekend as cvsps takes up so much memory and
swaps a lot.

I tried what I think is the correct usage of git-filter-branch but I get:

ajb@pitcairn:/export/git/fresh.git$ git-filter-branch --tree-filter
'rm -rf big_dira big_dirb' dev-branch
warning: refname 'dev-branch' is ambiguous.
Which ref do you want to rewrite?


Any ideas?

-- 
Alex, homepage: http://www.bennee.com/~alex/
