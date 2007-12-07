From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 02:08:09 -0500
Message-ID: <9e4733910712062308t22258c6anb685b18a663e0a31@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	 <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
	 <1196995353.22471.20.camel@brick>
	 <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>
	 <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
	 <alpine.LFD.0.9999.0712062120100.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Harvey Harrison" <harvey.harrison@gmail.com>,
	"Daniel Berlin" <dberlin@dberlin.org>,
	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0XK5-0005Sc-MT
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXLGHIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXLGHIM
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:08:12 -0500
Received: from qb-out-0506.google.com ([72.14.204.225]:28302 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXLGHIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:08:10 -0500
Received: by qb-out-0506.google.com with SMTP id e11so4514390qbe
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 23:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M9xABKCFrBngt2wfro1HCWOBn2jm2epU1EzzByrDtCY=;
        b=M4ev+aQUgjwzbNbwHfiyOSRgIbv53623h3e7zs1RUyxk1gtzHifvQwtVmWA+RTS/Jpu3TzMtY3oKsxqRbrXk7Aq39bbxqdONU0DRqNFQcw6tF/TZv+CooyG5o96ZoG5dBtBCBOy42AByzIT5Ouo3Sl+TK3/kBhKee7rWPDVrOQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lVmweiak3rSUHA3H2IrOJlt5s50H82Iq6hqmhiSEEY83D1YUdu+HQPmPDd/B63sws8QgooNkyZtv0I2nU32XREuxtpvsRNs6I2R8AUdkz/rCjIzwsGzQPD/gna88v+xFf54YQr32X+j3oH13KMeLvDNFwLp3XJ1hdb7TIdvsUpA=
Received: by 10.114.154.1 with SMTP id b1mr3191368wae.1197011289532;
        Thu, 06 Dec 2007 23:08:09 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 23:08:09 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712062120100.13796@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67389>

On 12/7/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Dec 2007, Jon Smirl wrote:
> > >
> > >         time git blame -C gcc/regclass.c > /dev/null
> >
> > jonsmirl@terra:/video/gcc$ time git blame -C gcc/regclass.c > /dev/null
> >
> > real    1m21.967s
> > user    1m21.329s
>
> Well, I was also hoping for a "compared to not-so-aggressive packing"
> number on the same machine.. IOW, what I was wondering is whether there is
> a visible performance downside to the deeper delta chains in the 300MB
> pack vs the (less aggressive) 500MB pack.

Same machine with a default pack

jonsmirl@terra:/video/gcc/.git/objects/pack$ ls -l
total 2145716
-r--r--r-- 1 jonsmirl jonsmirl   23667932 2007-12-07 02:03
pack-bd163555ea9240a7fdd07d2708a293872665f48b.idx
-r--r--r-- 1 jonsmirl jonsmirl 2171385413 2007-12-07 02:03
pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
jonsmirl@terra:/video/gcc/.git/objects/pack$

Delta lengths have virtually no impact. The bigger pack file causes
more IO which offsets the increased delta processing time.

One of my rules is smaller is almost always better. Smaller eliminates
IO and helps with the CPU cache. It's like the kernel being optimized
for size instead of speed ending up being  faster.

time git blame -C gcc/regclass.c > /dev/null
real    1m19.289s
user    1m17.853s
sys     0m0.952s



>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
