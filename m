From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Additional fast forward strategies.
Date: Tue, 11 Mar 2008 02:09:12 -0700 (PDT)
Message-ID: <m37ig9zky7.fsf@localhost.localdomain>
References: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0V2-00065s-NE
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYCKJJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYCKJJR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:09:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:13077 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYCKJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:09:15 -0400
Received: by ug-out-1314.google.com with SMTP id z38so5051971ugc.16
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=xDsQZGZYAbUpD6L0clUaaUHTn61NR60t3Z2VSwZwqm8=;
        b=OSD0HDbKyGSevwm7ejdvZksfoI0m5c07R4rz47eVzh8nvAVk4uXeAB2Fd7hAlsxIx/zcXj96ZUBEIaWoD0rCPBr9kpTrgcMP0OSZhpZsIh+Afpid6CATm98QbTNU+aVAcKieBWhRtZ9WClVRgJaq9unBHriedEd0C0qIlWL2X80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=J2QSAMDyD2CTUx19nfsqjDPQNOSGx2n+7W33hwUMhbzlAEPqQJu/oZawfVCK49Qy4mIqvwT1SP0kKrDSp4oj6rmhECLOxWcwQbyMrgs7QtBAMW5B480M/uAxbbaZPxNnyTTo5pN4ytwcRX1ieZaUutM7S1bEcATqO5MRNLv6jTQ=
Received: by 10.66.248.5 with SMTP id v5mr4585402ugh.17.1205226554278;
        Tue, 11 Mar 2008 02:09:14 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.230.40])
        by mx.google.com with ESMTPS id n34sm9964706ugc.64.2008.03.11.02.09.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 02:09:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2B996FI002705;
	Tue, 11 Mar 2008 10:09:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2B995ni002702;
	Tue, 11 Mar 2008 10:09:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76814>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> From: Sverre Hvammen Johansen <hvammen@gmail.com>
> Subject: [PATCH] Additional fast forward strategies.
> 
> New fast forward strategies, common, fork, path, and same
> is introduced.  These new fast forward strategies allows
> additional work flows.

It would be better (read: greater chance to be accepted) if you had
provided examples of those "additional workflows", best in EXAMPLES
section (or something like that) of fast-forward documentation, and
"see documentation" (or something like that) in commit message.
 
> FF strategy "common" does a fast-forward to the common ancestor
> of the specified heads.  The merge will fail unless HEAD is the
> common ancestor or HEAD can be fast-forwarded to the common ancestor.

Don't you mean "common descendant" here?

> FF strategy "fork" does a fast-forward to the common ancestor
> of the real heads.  The merge will fail unless HEAD is the
> common ancestor of these heads or HEAD can be fast-forwarded
> to the common ancestor of the real heads.

What is the difference between 'real heads' and 'soecified heads'?
Example, please.

> FF strategy "path" does a fast-forward to the first possible
> branch that no other branches are ahead of.  HEAD will be
> fast-forwarded to such a branch if it exist.  If no such branch
> exist, HEAD is considered to be up to date.
> 
> FF strategy "same" does a fast forward where all branches are
> required to point to the same commit.  HEAD will be
> fast-forwarded to this branch unless it is up to date.
> 
> Signed-off-by: Sverre Hvammen Johansen <sj@black.local>

It will be easier to understand those descriptions if you have
provided with ASCII-art diagrams (in the documentation, not
necessarily in fast-forward strategies^W options description, but
perhaps somewhere below, above FAST-FORWARD OPTIONS EXAMPLES section).

For example, by default you can fast-forward only when doing single
branch merge.

%%

  A---B---C---D   <--- master <--- HEAD
       \
        \-1---2   <--- a

If you have situation as above, you are on branch 'master',
and you do "git merge a" it would result in merge commit.

  A---B---C---D---M   <--- master <--- HEAD
       \         /
        \-1---2-/     <--- a

%%

  A---B           <--- master <--- HEAD
       \
        \-1---2   <--- a

If you have situation as above, you are on branch 'master',
and you do "git merge a" it would result in fast-forward.

  A---B---1---2   <--- master <--- HEAD
                    
              ^------- a

or

  A---B---1---2   <--- master <--- HEAD
              ^      
               \------ a


%%

  A---B           <--- master <--- HEAD
       \
        \-1---2   <--- a
              
              ^------- b

This I think is 'FF strategy "same"' situation.

%%

  A---B              <--- master <--- HEAD
       \
        \-1---2      <--- a
               \
                \-3  <--- b

This I guess is either 'common' or 'fork' situation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
