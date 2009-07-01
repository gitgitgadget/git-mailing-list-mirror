From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: git bisect; is there a way to pick only from the children of a
 given commit
Date: Wed, 1 Jul 2009 12:22:51 -0700
Message-ID: <BLU0-SMTP20683A1D7E5DEC1370D496AE2E0@phx.gbl>
References: <loom.20090701T170535-707@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Stonehouse <rstonehouse@solarflare.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM5Ob-0005c8-Be
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 21:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZGATWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 15:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZGATWy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 15:22:54 -0400
Received: from blu0-omc3-s28.blu0.hotmail.com ([65.55.116.103]:19765 "EHLO
	blu0-omc3-s28.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753596AbZGATWy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2009 15:22:54 -0400
Received: from BLU0-SMTP20 ([65.55.116.74]) by blu0-omc3-s28.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 12:22:57 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP20.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 12:22:55 -0700
In-Reply-To: <loom.20090701T170535-707@post.gmane.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 01 Jul 2009 19:22:55.0446 (UTC) FILETIME=[55D41F60:01C9FA81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122593>

On Wed, 1 Jul 2009 17:12:16 +0000 (UTC)
Robert Stonehouse <rstonehouse@solarflare.com> wrote:

>   $ git log --graph --abbrev-commit --pretty=oneline
>   * b394c57... master4
>   *   7e8d675... Merge branch 'featureB'
>   |\  
>   | * 8d87aee... featureB2
>   | * c1a8450... featureB1
>   * | 44c5601... master3
>   * |   269602a... Merge branch 'featureA'
>   |\ \  
>   | * | 91b1bbb... featureA2
>   | * | 0c15834... featureA1
>   | |/  
>   * | 1ea4a0c... master2
>   |/  
>   * 204f839... master1
> 
> Tag featureA1 was my good commit, and HEAD was the bad.
> I was surprised that git bisect was asking me to test commits on the featureB
> branch. I couldn't test the build target that was broken on branch featureB
> because it wasn't present in the code at that point.

You can exclude the featureB branch by listing at good.  Git will know there
is no need to test anything on that branch:

$  git bisect start HEAD featureA1 featureB2

HTH,
Sean
