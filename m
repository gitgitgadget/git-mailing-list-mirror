From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs.
 submodules
Date: Mon, 8 Dec 2014 23:49:56 +0200
Message-ID: <20141208214956.GD9128@wheezy.local>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <547E24E4.7050100@web.de>
 <20141202221611.GB9128@wheezy.local>
 <5480BEB9.8070109@web.de>
 <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
 <5482FF40.3040204@web.de>
 <20141207064230.GA9782@wheezy.local>
 <54860CDB.9090904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 22:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy6C0-0006W2-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 22:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbaLHVuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 16:50:03 -0500
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:58837
	"EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbaLHVuC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 16:50:02 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-10.prod.phx3.secureserver.net with 
	id R9ps1p0025B68XE019pvh2; Mon, 08 Dec 2014 14:49:58 -0700
Content-Disposition: inline
In-Reply-To: <54860CDB.9090904@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261084>

On Mon, Dec 08, 2014 at 09:40:59PM +0100, Jens Lehmann wrote:
> Huh? I think we already have that: If you ignore the url
> config it's as if the submodule was never initialized, so
> you can just *not* run the "git submodule update" command
> at all to get that effect. No new option needed ;-)

You are right. I was thinking about minimal change to
submodules which would allow user selectively checkout them
but the most minimal one is just selectively run `submodule
update`. I think in scope of this feature no changes to
git-submodule is required.

>> btw, have you tried alternates? It does reduce the number of
>> objects you need to keep very strongly. You can put in the
>> alternate store only released branches which are guaranteed
>> to be not force-updated, to avoid issues with missing
>> objects, and it still helps.

> Which is exactly what we do *not* want to do on a CI server,
> its purpose is to endlessly build development branches that
> are force-updated on a regular basis.

Yes, but they still are only somewhat ahead of some stable
branch. And not very much, if you count space: _All_ git
development, with whatever unstable branches, takes 5-10
times less space than its carved in stone history under
`master`.

-- 
Max
