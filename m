From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Sun, 6 Jul 2008 20:16:31 +0400
Message-ID: <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com>
References: <20080620082034.GA24913@elte.hu>
	 <m3d4mcmq20.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:17:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFWva-00019C-0Y
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 18:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbYGFQQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbYGFQQd
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 12:16:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:58459 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757438AbYGFQQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 12:16:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1797057wfd.4
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hla9m0qa+1b5kjKKT3UB98jelc+Fj2nSdGr2egNIlt0=;
        b=J+LGDkEfIFjX1Ee56I1peXiFdMmeXAcl5vl4ixGnlJJYxjsrwhFes2xxwymUjF79fq
         Tshs/hCoj3n7j9T/n7GH/kONkrbqXZRikZPRUN+nC4/2nAqSAkIgE5eR/a5pW4WqMJCX
         33dXr1U3adPVT11EFHUGjQlNbKZrRVw4vQGhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GXog9ITHHfuxq+MYS+MXjjlfUBKWd56OabRvqsGmV8fU2JZCdQknw1ID6CcZSmK6pg
         FKV46voe19mczBU4NspvwN8T0q+ZMH/o78PWpe3+MtmkJXG972btXRtyx/Tx0ptqcK9z
         Itd86R/SPnokx/8cPHy0N74dLV3ej6cQJcprY=
Received: by 10.142.188.4 with SMTP id l4mr967101wff.92.1215360992040;
        Sun, 06 Jul 2008 09:16:32 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Sun, 6 Jul 2008 09:16:31 -0700 (PDT)
In-Reply-To: <m3d4mcmq20.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87538>

On Fri, Jun 20, 2008 at 2:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
> documented anywhere, though),

The latter is not exactly a shortcut for the former.  You can try it at any
merge commit, and you will see different log. For instance, in Git repo:

$git rev-list 7ac749c^..7ac749c
7ac749c96d143ba4f76723959892cbaddbe8ed07
006f31d77f3dd5f813557c2839b39b2aaa22b925
53b22a9e45161004ff3260782abc4ee2a5b3e730
872354dcb3ce5f34f7ddb12d2c89d26a1ea4daf0
bc7c73e29cfb38232b5b6b1d1e8d59e7145a9860

$git rev-list 7ac749c^!
7ac749c96d143ba4f76723959892cbaddbe8ed07

So, I believe, rev^! means --first-parent rev^..rev

Dmitry
