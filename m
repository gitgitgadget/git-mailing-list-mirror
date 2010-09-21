From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Tue, 21 Sep 2010 22:39:59 +0400
Message-ID: <20100921183959.GB4390@landau.phys.spbu.ru>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru> <cover.1285013802.git.kirr@landau.phys.spbu.ru> <3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru> <vpqvd6086fq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl?ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 20:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy7lD-0001wE-Hc
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 20:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab0IUSkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 14:40:01 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:52779 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0IUSkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 14:40:00 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id A0059FF723; Tue, 21 Sep 2010 22:39:59 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <vpqvd6086fq.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156740>

On Mon, Sep 20, 2010 at 11:13:13PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > (Description partly by Matthieu Moy)
> 
> Better put such statements at the end, to avoid distracting the reader.

Ok

> > ~~~~
> >
> > NOTE: git diff doesn't try to textconv the pathnames, it runs the
> > textual diff without textconv, which is the expected behavior.
> 
> It's not clear whether this is intended to stay in the commit message.
> If not, it should go below the ---. If yes, then I'd incorporate this
> into the message itself. The ~~~~ and NOTE look odd.

I know about --- and that content after it and up to patch itself goes
to /dev/null. The text here was intended to stay in the commit message,
and ~~~~ served as a separator in that message (git commit hook merges
several blank lines into one, so one can't separate text parts with
several empty lines, that's why I used this separator).

If it's ugly, let's omit it - I don't insist, but i don't understand why
'NOTE:' looks odd?


And also, do you remember your first question to this series? It was
about does git diff --textconv misbehaves too or not. So I consider this
note is important to put into description, and isn't the right place for
such a note this patch, where show tests that demonstrate fauilures?

This note clearly says "git diff is not affected, that's why we don't
write new tests for it".

Something like that...

> 
> For example (in next patch):
> 
> | Instead get the mode from either worktree, index, .git, or origin
> | entries when blaming and pass it to textconv_object() as context.
> | 
> | The reason to do it is not to run textconv filters on symlinks
> + (just like "git diff" already does).

See above about my rationale on the note place.

> Anyway, I'm bikeshedding. With or without these remarks,
> 
> Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

Thanks :)

Is it for this one patch, or does it apply to the whole series?


Thanks,
Kirill
