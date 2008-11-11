From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 09:13:42 -0800
Message-ID: <20081111171342.GJ2932@spearce.org>
References: <200811101522.13558.fg@one2team.net> <491933DF.3060307@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Galiegue <fg@one2team.net>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzwpP-0005KW-Ru
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYKKRNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbYKKRNn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:13:43 -0500
Received: from george.spearce.org ([209.20.77.23]:54104 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbYKKRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:13:43 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6CFCD381FF; Tue, 11 Nov 2008 17:13:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <491933DF.3060307@dawes.za.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100654>

Rogan Dawes <lists@dawes.za.net> wrote:
> Francis Galiegue wrote:
>>
>> For this to be doable from within the Eclipse Git plugin, a diff/patch  
>> implementation needs to be found, in a license compatible with the 
>> current JGit license (3-clause BSD, as far as I can tell). Or a new 
>> implementation can be rewritten from scratch, of course.
>
> Shouldn't Eclipse already *have* a diff/patch implementation, for its  
> other "team work" plugins?

Err, uhm, sort of.

Eclipse has patch available as an internal API, but it is exposed
in the UI for any team provider (or no team provider at all) to
use to apply patches to a project in the workspace.

The team provider API assumes the VCS implementation has its own
diff, and therefore the diff implementation inside Eclipse is only
used for the native Compare view

I've dug around that part of the text compare plugin and its mostly
internal APIs, and mostly still low-level LCS generation from
arbitrary object input.  It doesn't seem well suited to producing
fast diffs of text.

Its under the EPL.  We could take the code and simplify it down,
but I think by that point we'd mostly just want to rewrite it, or
use a different library anyway.  At which point we wouldn't want
to bring in the EPL baggage if we can have a BSD implementation.

So yea, there's some implementation in there, but its not easy to
use or get to...

-- 
Shawn.
