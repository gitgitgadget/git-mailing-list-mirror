From: Claire Fousse <claire.fousse@ensimag.imag.fr>
Subject: Git-Mediawiki : cloning a set of pages
Date: Wed, 8 Jun 2011 13:19:38 +0200
Message-ID: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 13:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGnZ-0002AK-J6
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab1FHLTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:19:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44884 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1FHLTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:19:39 -0400
Received: by pzk9 with SMTP id 9so193503pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:cc:content-type;
        bh=bS/eDb6CpLUqd1rVwIj9/NWKKCTOkPTDIKcn1HbOD9o=;
        b=gFIPpo7JHlwFyLiIiXP3Qjxsp/vY+TOaoxyxu4G/jpYAwUhWEWW6oTVfq0Uzym8Rp1
         gSWKe98t/MsnuCvFpXFu8RkIaaeiZGw21ftCNfge9rLOMUdbgxznJg8zV6Hv8BjqxgW2
         4MYlW/dN3zm9xBTwmKpmNAoP3Nt6qYiPv72tI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=E9BsCcPhueln8ihOK/9Ibh66p3+5UTTFqyV2vFCh3VbdmUksiaVgz5qALLUf/uc4js
         5E/vLjL2ydt2f/cGO3frVUMGEkaSI2to0RKJb1fSpX+cmNpqB9C5TzB1mCLu1M4loeQF
         BpqnA3Vu2AKnxLP9kY+EWXMqxsGhi3kj+Jbv8=
Received: by 10.68.20.166 with SMTP id o6mr718681pbe.151.1307531978567; Wed,
 08 Jun 2011 04:19:38 -0700 (PDT)
Received: by 10.142.97.15 with HTTP; Wed, 8 Jun 2011 04:19:38 -0700 (PDT)
X-Google-Sender-Auth: 25Jul2jIiRzEblYCDhjStY3_DUY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175355>

Hi,

I work on the Git-Mediawiki project.
(http://lists-archives.org/git/746959-gate-between-git-and-mediawiki-remote-helpers.html).

I'm trying to establish a feature to clone and work on some pages of a
mediawiki instead of all of them.

The problem is not the feature in itself but the way you call it.
Just so you remember, here is the command  to clone the mediawiki :
git clone mediawiki::http://yourwiki.com

As it is now, git clone does not implement a way to define a set of pages.
The 2 solutions we think of are :
	* git clone mediawiki::http://yourwiki.com$$page1$$page2 ...
	Where $$ is a separator still to be determined. It should not be
something which could appear in the title of a page.
	It is a simple way to proceed but it becomes horrible when you want
to clone many pages.

	* write a git-mw-clone script which asks the user to enter a set of
pages  and may store this set of
	titles in the git config. This script should then call git-clone
which will call the remote-mediawiki functions.
	git-mw-clone would clone the entire wiki and git-mw-clone --pages
would ask the user to enter their set.
	The problem here is that a not git-like command is required.

What do you think about those solutions? Do you think of a better one?

Thank you very much.

--
Claire Fousse
Grenoble INP - Ensimag
claire.fousse@ensimag.imag.fr
