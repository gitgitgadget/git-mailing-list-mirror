From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: [PATCH v3] git-svn: Make following parents atomic
Date: Mon, 22 Dec 2008 09:41:35 +0100
Organization: Intra2net AG
Message-ID: <200812220942.05001.thomas.jarosch@intra2net.com>
References: <20081207222444.GA10881@euler> <20081208233523.GB21675@hand.yhbt.net> <200812161422.58814.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Leonard <talex5@gmail.com>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Dec 22 09:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEgO0-0004sO-VI
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 09:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYLVImL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 03:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYLVImK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 03:42:10 -0500
Received: from re01.intra2net.com ([82.165.28.202]:42506 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYLVImJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 03:42:09 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id AEF04927E;
	Mon, 22 Dec 2008 09:42:07 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id BB5A32AC4B;
	Mon, 22 Dec 2008 09:42:06 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 363412AC4A;
	Mon, 22 Dec 2008 09:42:05 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-53.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <200812161422.58814.thomas.jarosch@intra2net.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-22_04)
X-Spam-Status: hits=-2.5 tests=[ALL_TRUSTED=-1.8,BAYES_20=-0.74]
X-Spam-Level: 975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103749>

On Tuesday, 16. December 2008 14:22:44 Thomas Jarosch wrote:
> This patch has a very nice side effect, it seems to fix a long standing
> problem with subversion imports. Here's the original report:
> https://kerneltrap.org/mailarchive/git/2008/4/8/1377514/thread
>
> Many of the 121 tags in my SVN tree were created by cvs2svn,
> which often created tags by copying older revisions
> of sub paths into the current tree.
>
> I've written a small script that checks out the same tag via git and SVN.
> It runs a diff against those two trees and saves the result to a file
> so I can manually check it. With git-svn from 1.6.0.5, the results are
> horrible: Over 30% of the tags didn't match the code in SVN.
>
> With git-svn from 1.6.1rc3, my first two manual probes look very good.
> Right now I'm reimporting the svn tree and will have the results
> of the complete "checkout comparison" tomorrow.

Yipeee, our SVN repository is fully migrated to git and split into handy 3-5GB 
repositories. All the git tags match the code from the SVN tags,
so I guess this was a good stress test for git-svn 1.6.0.6 :-)

Cheers,
Thomas
