From: Simon Josefsson <simon@josefsson.org>
Subject: Re: gitco - replacement for cvsco
Date: Wed, 28 Feb 2007 22:31:27 +0100
Message-ID: <87y7mirmts.fsf@latte.josefsson.org>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227174035.f85e8643.vsu@altlinux.ru>
	<87bqje74u5.fsf_-_@latte.josefsson.org>
	<20070228195536.GB4149@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 22:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMWPI-0002EP-2O
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 22:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXB1VcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXB1VcO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 16:32:14 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:37661
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXB1VcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 16:32:13 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1SLVS2Y005773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Feb 2007 22:31:28 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070228:ydirson@altern.org::TLsmn3aOHnT/HOEI:GpR
X-Hashcash: 1:22:070228:vsu@altlinux.ru::o//ZoRiHEV/7hsnT:3IY1
X-Hashcash: 1:22:070228:git@vger.kernel.org::nR1muPFyhI+lr3vi:9+6n
X-Hashcash: 1:22:070228:johannes.schindelin@gmx.de::9T0BjpiqJjmEs+O6:Aqaq
In-Reply-To: <20070228195536.GB4149@nan92-1-81-57-214-146.fbx.proxad.net>
	(Yann Dirson's message of "Wed\, 28 Feb 2007 20\:55\:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-0.7 required=4.0 tests=BAYES_20 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41008>

Yann Dirson <ydirson@altern.org> writes:

> As a big fan of cvsco and friends, I admit I often miss that one in
> git repos.
>
> On Wed, Feb 28, 2007 at 03:08:02PM +0100, Simon Josefsson wrote:
>> However, one problem with that, compared to 'cvsco', is that
>> 'git-reset --hard' does not tell me tell me which files were deleted
>> and which file were restored.  May I suggest a --verbose or similar?
>
> Here is a small change to your script that does just that.  It is far
> from perfect:
>
> - uses cogito and not plain git.  Not sure how to achieve the same
> compact layout with plain git - both cogito and stgit forge this type
> of output themselves.  Would be great to get it directly from git
> itself...
>
> - not very efficient, and not very secure, since we scan the tree once
> for reporting and then once for deleting the files, leaving a window
> where files could be created by another program after the cg-status
> call, and then removed by git-reset.
>
> You've been warned :)
>
> #!/bin/sh
> # gitco - cruel checkout.  Discards everything that has not been
> # committed, and checkout missing files.
> git clean -d -x
> cg status -w
> git reset --hard

jas@mocca:~/src/libtasn1$ gitco
Removing foo
M Makefile.am
! gendocs.sh
jas@mocca:~/src/libtasn1$

Perfect!

Thanks,
Simon
