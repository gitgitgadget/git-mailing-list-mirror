From: Pascal Obry <pascal@obry.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 13:56:20 +0100
Message-ID: <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 13:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSswW-0000Mq-8R
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 13:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZA3M4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 07:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZA3M4X
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 07:56:23 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:65349 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZA3M4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 07:56:22 -0500
Received: by mail-fx0-f20.google.com with SMTP id 13so157158fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 04:56:21 -0800 (PST)
Received: by 10.223.103.147 with SMTP id k19mr44336fao.0.1233320181030; Fri, 
	30 Jan 2009 04:56:21 -0800 (PST)
In-Reply-To: <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107806>

Santi,

Thanks for you reply.

> I think your definition is not well defined. A, B and C are just
> branches of you project, technically they are equivalent. Maybe you

Right. Yet I want to know from which branch a branch as been started.

You need this to get the proper merge-base for example:

   $ git merge-base C A
      1

   $ git merge-base B C
      2

   $ git merge-base B A
      1

I always know on which topic branch I'm but, as shown above, depending on the
parent branch passed to merge-base you do not get the same branch-point. This
is fine.

So, when I'm in a topic branch I want to find the name of the parent
branch. The one given
when creating the branch:

   $ git branch B C

A "stupid" solution whould be to iterate over all branches. Looking
for the merge-base and
at the end output the branch having the youngest merge-base. I'm
looking for something
more efficient...

> are thinking that the common commits of, say A and B, really belongs
> to A, but this is not the case they belong to both branches. In git a
> branch is really just a pointer to a commit and by extension the
> history, it is not a series of commits.
>
> Just a counterexample, just rearranging you graph:
>
>                        o---B
>                        /
>                   o---2---o---o---o---C
>                  /
>          ---o---1---o---o---o---A
>
> From you description: For B I would get C and for C I would get A.

Don't see this as a counter-example as it is exactly my example.

Did I missed something?

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
