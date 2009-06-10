From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been 
	removed from CVS
Date: Wed, 10 Jun 2009 09:06:01 +0100
Message-ID: <e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
References: <4A1F1CF5.8030002@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEIp3-0008V5-RL
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 10:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852AbZFJIGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 04:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbZFJIGH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 04:06:07 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58050 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbZFJIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 04:06:04 -0400
Received: by fxm9 with SMTP id 9so557827fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pK30OueSs5OmVgE2nw/1K3nEzPBVFccwH/hFuKx30VQ=;
        b=TMjfXYlkJ3/dkg2+tj0/JR9TxmL+XgZrboZmXuQnGp+J+p6SO3+kVCkMPO/V2NU+e9
         oLzG2JuQ+lxCKtyKsHxNdqKpZbOwdd6r7OnuP25lv/iX5ROKXtIQ2dK4FAmwm0un5FMU
         AbTfLBtXV7In6hhBxciiwAD/g/vuO+6SHG7eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pLH4kwGexh0mpZu0DLbOIU/iy7CkU6hJ6URUevoSnQ1XzMlL6wl3G3gKj+9/BxX5Kc
         Gq0Vx+pOZZY0KZ+ZhK08+tSfjuNywJp1g/leKcYGMHASbWck9x3O6iTrpO4G+ag1+mVD
         3MvE4Tt8X47EMmTVoq2FbofLUKJjqs78YW/Sk=
Received: by 10.223.107.135 with SMTP id b7mr902113fap.30.1244621161159; Wed, 
	10 Jun 2009 01:06:01 -0700 (PDT)
In-Reply-To: <4A1F1CF5.8030002@yahoo.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121263>

2009/5/29 Nick Woolley <nickwoolley@yahoo.co.uk>
> Added a test to t9200-git-cvsexportcommit.sh, which tests that we can
> re-commit a removed filename which remains in CVS's attic. This adds a
> file 'attic_gremlin' in CVS, then "removes" it, then tries to commit a
> file with the same name from git.

Hi Nick, I'm seeing intermittent failures since your new test was
added to 'next' on AIX 5.3

cvs commit: Up-to-date check failed for ` space'
cvs [commit aborted]: correct above errors first!
* FAIL 15: re-commit a removed filename which remains in CVS attic
* failed 1 among 15 test(s)

Is there a possibility this test has a race condition?

Let me know if there's anything I can do to help debug it.

It could be a bug in the ancient CVS I have here (1.11.1p1) though.

cvs status: Examining .
===================================================================
File:  space            Status: Needs Patch

As it's a file from the previous tests being fingered, I've cc'd a
couple of likely lads.

Mike
