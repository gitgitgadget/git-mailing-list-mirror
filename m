From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Wed, 16 Apr 2008 21:56:26 +0200
Message-ID: <200804162156.27435.jnareb@gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com> <m3abjushvs.fsf@localhost.localdomain> <7vfxtmtlm0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:19:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDuX-0001UG-5z
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYDPUGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYDPUGb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:06:31 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:36424 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYDPUGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:06:30 -0400
Received: by ik-out-1112.google.com with SMTP id c28so618230ika.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=wcwPGxT1Ph354JIGs9Tij2P69Az7bCg8K4xZQs/kTvU=;
        b=EcitmmbuhH3CKcUklyWeDZnreeap8Hh17Cao+Uf6l/jCY3uZ1eKg/f+4tW53Ixw1s8YeOEYEfHCJ/e/ryJgmDVH9WkFC8ro/VYZbNhT4BQrXYZXf7HYhDvjg3uw+XHU7HnLCTc7cvYEaRz5plp45RjQ71uH0s/9HT7SrKpI5PvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QvzRWLq1Vx04yKjQk07u8f8G6AA0ym7CpanN7J5hxmz4WAuNYhhxJUF7W5qlouXwAGziefO7l71kW52UGzk4aOefzWJvYW97VRT4SU0ViyfIqxMMD/i1sbdhlymHHXAll/kMYaK/EK/LDDH+uCJ0a+PV6UTedXbDXrbMcoQ9d6Y=
Received: by 10.78.161.4 with SMTP id j4mr750032hue.35.1208375785388;
        Wed, 16 Apr 2008 12:56:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.183])
        by mx.google.com with ESMTPS id d26sm16635098nfh.22.2008.04.16.12.56.20
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 12:56:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxtmtlm0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79739>

On Wed, 16 April 2008, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Please, let's don't repeat Mercurial mistake of placing unversioned
> > information (such as branch names in case of Mercurial, or branches
> > descriptions in this case) in-tree, i.e. version it.

I'm sorry, I meant here "tags" not "branch names"... I think...

> Is it really a "mistake" in Mercurial's context?

If we are talking about tags support in Mercurial, I think it is
mistake or at least bad design decision.  Tags are, and should be,
unversioned (or at least versioned separately) but propagated (or
rather propagatable).  Mercurial offers either in-tree .hgtags,
which are always automatically propagated (not merely propagatable);
but this mechanism is by default versioned, and Mercurial does
complicated dance to get reasonable tags semantic.  And there is
[theoretical] problem of merging .hgtags file; perhaps solved by
specialized merge strategy for this file.

Alternatively Mercurial offers so called local tags, which are not
versioned, but not propagated (and AFAIK non propagatable).

So yes, it is a bad design in my opinion.

> I thought that their named branches do have defined "starting point", and
> it is not a mistake at all for them to version "from this point on, this
> lineage of history is associated with this symbolic name (which is a
> branch)".

What happens if there is branching point _after_ such "branch naming tag"?
Unless branch names are purely local and non-propagatable, and Mercurial
can use local revision numbers or something  like this...

I find this CVS legacy to branching (doesn't Subversion use also
something like that) to be stupid.

> It probably does not make sense in the context of git where a branch is
> defined to be "illusion" (at least currently).

BTW. another tool that has yet another idea of what "branch" is
is Monotone, which AFAIK understands branch in reflog sense, via
Monotone's signature signatures ;-)

P.S. Cc-ed mercurial mailing list, to give them chance to respond
to those "accusations"... if it is not subscribe only...
-- 
Jakub Narebski
Poland
