From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 14:16:14 +0100
Message-ID: <e1dab3980709240616p5badae12t23ffd323a0d873d@mail.gmail.com>
References: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
	 <Pine.LNX.4.64.0709241400410.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZnnU-0002B7-BJ
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 15:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbXIXNQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 09:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756335AbXIXNQR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 09:16:17 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:7635 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbXIXNQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 09:16:16 -0400
Received: by py-out-1112.google.com with SMTP id u77so2903296pyb
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iJm/WIGk/gxl+1njfY/bcA5BCjkOpZTm/GmYDjSu5p8=;
        b=fNz6UiWz5oKeoEifQzix3DEyr/QU7sGbcGhrP80zu+HUInzIfCTpFZGr51nclWHd8J2JpGoebgvq1glsvW23Hy5AF3fOHzkMwCeirY6QtapXPJt0IpMISkcIRlthRUodZbAkwU1uPb+7OSsxUCZTKWPn1H0LHO19aVfUpbBhfDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dt44u/dG/VNMNmLeqSaIXJyO3mOwWKur8I0qiNX9hnQWag73f2ZrbtU9F9aL6LqWoS3V0sCqPl9qDn2SVYjdFAmut8u7gwj2WlctjYlWq6Zy5dBwHq5bBcBDVnex4mqI6CzZ+EhLtqL6N+AwDIWANIftUWT2qGAp7rY5AGoNnDs=
Received: by 10.65.119.14 with SMTP id w14mr1660531qbm.1190639774586;
        Mon, 24 Sep 2007 06:16:14 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Mon, 24 Sep 2007 06:16:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709241400410.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59046>

On 9/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Yes, this is fully expected.
>
> The @{time} notation accesses the _reflogs_, which are purely local
> beasts.  They are not transmitted when cloning.

Thanks of your reply; however I suspect this isn't the problem
here since I just tried with just master and I get the same thing.
To be clear, I'm doing this on the same machine with the same
user account as the git directory, just from a directory outside
the git tree, eg, the git tracked tree is in $HOME/V and I'm
in $HOME/A running

env GIT_DIR=$HOME/V/.git git diff master

As a guess without looking at the code, what I imagine
is happening is that git diff limits showing changes to the directory
tree below $PWD, and when $PWD isn't actually within the git
dir that ends up somehow as an empty tree.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
