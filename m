From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: refs/remotes/origin/HEAD points nowhere!
Date: Wed, 05 Mar 2008 13:24:15 -0800
Message-ID: <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
References: <200803051338.44938.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Bowes <jbowes@dangerouslyinc.com>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX16m-00024i-8i
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616AbYCEVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757200AbYCEVY0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:24:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616AbYCEVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:24:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 812A71BA1;
	Wed,  5 Mar 2008 16:24:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BD37A1A9C; Wed,  5 Mar 2008 16:24:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76269>

Teemu Likonen <tlikonen@iki.fi> writes:

> After a while I start tracking some other remote repository. I do this:
>
>   git remote add ng git://project-ng/project.git
>
> Then I do "git fetch ng" and probably also "git checkout --track -b 
> master-ng ng/master". Then I find the old "origin" useless to me so I 
> remove it with "git remote rm origin".
>
> It seems that refs/remotes/origin/HEAD is still left in my repository 
> and hence I keep getting these annoying error messages all the time. 

> Well, I know how to delete this file, but I believe that git should have
> deleted it when I called "git remote rm origin". Am I right?

Good analysis.  I would say "git remote rm" should have removed
it and it would be a bug if it didn't.

> What is the purpose of this refs/remotes/origin/HEAD in the first place?

To let you say things like "git diff remotes/origin" as a short-hand for
"git diff remotes/origin/master" (or whichever branch 'origin' repository
considered the primary one, which is determined when you cloned from it).

