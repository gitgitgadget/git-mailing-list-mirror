From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Mon, 8 Sep 2008 11:12:19 -0400
Message-ID: <9e4733910809080812g4a7e5916l82bd3bf496f16324@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
	 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
	 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
	 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
	 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
	 <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
	 <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
	 <9e4733910809071333t57d03257m34fd6a752e40177e@mail.gmail.com>
	 <alpine.LFD.1.10.0809081008330.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KciQl-0000Ee-2v
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbYIHPMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 11:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYIHPMV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:12:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:10594 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYIHPMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 11:12:21 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1180791waf.23
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Opxd4EPeUHvSDNy4vMKsPxYN1J0p0y9GQ1FLCqxCnS0=;
        b=DemeSs7N+Dn/yfEFDlckg4ur8NVYFvHzSHwbHb/V8MLpqHP44fFF48ewq6c5V2Txnf
         DWaIUewprhrmS2GUV760joP0nXKhDP+WAFEpccaa9BKawczRv9n/KDaYpcCMf6ZkEqgu
         QvFzPXlFbg9QRhTjYuD+z2wYeFN40KtSl80iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LM3sx5dA7/FK79206eEIbXqBTu1PCyGvuAgx7nN1DpJgJCd55WwuNF6hVo1iR8vlnM
         29SQRS+Haco+mGpNV5hP/fnf5OYoeLS1CcFpCFRH/yikFKkEVqipKU081ZYTGNrbQSbC
         ztXTEKus1JY+a93zAKSlK3ue6sgowDZA0KB8I=
Received: by 10.114.205.1 with SMTP id c1mr12521129wag.56.1220886739682;
        Mon, 08 Sep 2008 08:12:19 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Mon, 8 Sep 2008 08:12:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809081008330.23787@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95259>

On 9/8/08, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 7 Sep 2008, Jon Smirl wrote:
>
>  > On 9/7/08, Nicolas Pitre <nico@cam.org> wrote:
>
> > > Please have a look at commit eac12e2d4d7f.  This fix improved things for
>  > >  my gcc repack tests.
>  >
>  > Do you have any test numbers for something like a 2000 delta chain
>  > before and after?
>
>
> What kind of number do you want?

See if repacking a 2000 chain delta still takes 30 minutes. It can be
any 2000 chain delta.

>  Before that change I wasn't able to repack an already tightly packed
>  (about 340MB) gcc repository on my machine while the same but sparsely
>  packed (3GB or so) repository could be repacked just fine.
>
>
>  > You can get to Mozilla CVS with rsync.
>  > https://wiki.mozilla.org/How_to_Create_a_CVS_Mirror
>  > I think it was the master Mozilla makefile with the 2000 deltas.
>  > The whole repo is 15GB so you probably just want the Makefile,v
>
>
> I have a test Mozilla repo dating back to the time you were playing with
>  it too (I think).  Its directory date is 2007-04-12.  It was quite
>  tightly packed already, but I just ran a "git repack -a -d -f
>  --window=100 --depth=2000" on it and now have a 380MB pack file for it.
>
>
>
>  Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
