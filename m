From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Wed, 7 Nov 2007 16:25:10 -0500
Message-ID: <3abd05a90711071325y397434efq7d4e50cb7a1cf07e@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
	 <18223.46848.109961.552827@lisa.zopyra.com>
	 <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
	 <alpine.LFD.0.999.0711060812170.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpsP1-00039D-Bi
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbXKGVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXKGVZS
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:25:18 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:18715 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXKGVZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:25:16 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1831792nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 13:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jKle7oFpuQIzkUguNjQ4jMePU5ZTsXehsdMzJ82i5gQ=;
        b=KwbtqGr6lMAQF45RVzqRzVL089BYsfG+nC78grliDhgFKsmI+QeWBwxjtN+b1v0+JrAMCpOoeqAWe2aQxOkC/Zxizl1TRFwQkrEVde+9jwW34UiEhnVqj2SWr4/1slelOiOa/O9ebeNh1XLby+YisgicNa9y3MzkPYmy8YxTzWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xou6BBRRk63nD3PYV3poDLQ0E/qcG09703sVnmLag2ZzkvcpIshjURN1R0+6IKXSsPsNyvP5IjQ480+o/X3WS26h95TiKm6B+6ji+uKkIk/sUW1vLq3VJew7649o8hVZPpp8XagKiANaJptpr+sTDOJdX8ogOKsq1+woFQKT0Xw=
Received: by 10.78.203.15 with SMTP id a15mr6560865hug.1194470710323;
        Wed, 07 Nov 2007 13:25:10 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Wed, 7 Nov 2007 13:25:10 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711060812170.15101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63862>

On 11/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Git does merge with a dirty directory too, but refuses to merge if it
> needs to *change* any individual dirty *files*.

Understood.

> [...]
> Now, I do think that we could relax the rule so that "files that are
> modified must be clean in the working tree" could instead become "files
> that actually don't merge _trivially_ must be clean in the working tree".
> But basically, if it's not a trivial merge, then since it's done in the
> working tree, the working tree has to be clean (or the merge would
> overwrite it).
>[...]

I really think this is a good idea. It seems to me that the first "bad"
surprise a svn/cvs/bk user will have is the result of a "git pull" command
on a dirty tree. With the proposed change, and if I understand correctly:
  - users that are used to commit often and fetch into clean trees
will never be bothered by this change.
  - users that are used to "update" often are expecting to resolve
conflicts in their working copy anyway.

In both cases git does not get in your way and everyone is happy.

- Aghiles
