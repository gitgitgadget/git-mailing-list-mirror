From: Fabio Augusto Dal Castel <fdcastel@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 18:48:33 -0200
Message-ID: <38cfbb550902101248v16f0f0f0v6a48cabf498317cf@mail.gmail.com>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	 <gmq1hu$ccn$1@ger.gmane.org>
	 <38cfbb550902101232l4c83b6dfjc70e1e2f79a8c3c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 21:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzYR-0005jf-3B
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZBJUsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbZBJUsf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:48:35 -0500
Received: from qb-out-0506.google.com ([72.14.204.229]:13656 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbZBJUsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:48:35 -0500
Received: by qb-out-0506.google.com with SMTP id q18so15764qba.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=aSgPiJg27upcn/ySWzFPnt3eTA1bJyzjqzz+kdyXn5s=;
        b=PDS5mif/8Cw/fg6PtRcH4mG8287wC2M1YANaE1hpgADIfECQyCEsFJcsQ1CUkubwVX
         ZFAk+YH91PoxIII/gms+PzWOcflGZ5P3rAlNIVdzrIvfuQsntNV3AoY4Fe9Pe3CckXzD
         1KT8KHN0qad7WMTZJ9YZlv5pABv7z1WK8aHXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=x4NlGy7nJsupOnj1KVfTeiCyVBVdq8dSbkHljsyWcsMAWqNuBqPa9XXJYqX9kNRW+h
         EF0gY7z0RFEG3JfpO0KFj7o4CSj7ecvzzzsoWt1vjU+HhX9H5+rweoXwMwM+OoSGcy5Y
         emikShmkm+sqEJ36xS7ivoWpAxheKJjCRjspU=
Received: by 10.231.16.134 with SMTP id o6mr1270569iba.53.1234298913689; Tue, 
	10 Feb 2009 12:48:33 -0800 (PST)
In-Reply-To: <38cfbb550902101232l4c83b6dfjc70e1e2f79a8c3c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109306>

Giuseppe

> I use stash when I want to move away from the current
> hacking because a new, more urgent change must be done
> somewhere else

Yes. That is exactly what stash is for. Temporary fixes. Now...


> Instead, I see a usecase for git snapshot for progressive
> temporary snapshot while working towards a more complex feature
> while needing temporary intermediate checkpoints

That's the idea. You could take a snapshot automatically every x
minutes. For example: I'm testing it taking a snapshot on every
build/compile of my project (and it is going fine, BTW).


> similar to what I currently achieve using git commit (a first
> time) and git commit --amend as my work progresses.

Except that, in this solution, you have only ONE saved state.
Also, it needs to be done manually. I wanted something automatic (like
John Wiegley's sugestion)



> In this respect, I wouldn't agree with the first difference you
> remarked, but that's just the usecase I have in mind.

Making another analogy: I see stash like a stack (you push/stash, and
after you pop/apply). And I don't see stacks as a good long-term
storages <g> (ok, you CAN 'cheat' and see all items other than the
first)

Snapshots would be like a queue: You can keep it entirely, or you can
keep only the last 'n' interesting snapshots, removing the others.




> I'm not sure I like the idea of creating these branches with these
> branchnames. What about using another refs/ subtree?

I'm also not sure <g>. The idea of refs/ is a good one, too (and could
solve the problem of 'where to store the original index?'). But my
first idea of using branches was to avoid a load of another
'maintenance' commands ('snapshot list', 'snapshot delete', etc) and
to use a more known facility (branches).



Best regards,

Fabio.
