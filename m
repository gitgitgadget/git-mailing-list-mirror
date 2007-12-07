From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:50:31 -0500
Message-ID: <9e4733910712071350w3c0e12dfkf366d33d61b55266@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0l5y-0007Q0-LJ
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbXLGVue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbXLGVue
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:50:34 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:63247 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbXLGVud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:50:33 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7322271roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=S1a8IaWYxd80YEMlhMzX2Nw9DTNKMPXhE31h9ZlAsFs=;
        b=XOCm9OpY/xJ7+r//tDJo3si/BPMfMbHT8ZBEpWIQIQWJGlgIOgPZn3+i/vjN++ko/MPv9NIlgKJuz4whlGBVj8B0RhCfJpuZMtiNtS5IQa+YZBbtAEWHezSL8nObjTcV2B3tvPm6butLnj2FNZD24SBu2yBoIlvzY1CtCVgT2eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nMokpn0kYLrlvrs3biiD0kplRqt9k3/71q+dyNo4Mt4rNLEjLUxbKOcTKkcmFumU0hpYzHNmRCSRddVXFn1dHWiTYwRRBsJ/Ag8OEe1VmJ6RdLv3SpWFbm58DJXKXmSqTVpmA435ezqRizJGiMJYlEmkSrRt0JNSafm6RgVy+lE=
Received: by 10.114.135.1 with SMTP id i1mr3518865wad.1197064232011;
        Fri, 07 Dec 2007 13:50:32 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 13:50:31 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67475>

This is for a 3.3GB process with the 2GB pack as input
Looking at my process map, why is the pack file in the map four times?

2ba1f703b000-2ba23703b000 r--p 00000000 09:01 33079321
  /video/gcc/.git/objects/pack/pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
2ba23703b000-2ba23703c000 rw-p 2ba23703b000 00:00 0
2ba237c86000-2ba239352000 r--p 80000000 09:01 33079321
  /video/gcc/.git/objects/pack/pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
2ba2394b1000-2ba2794b1000 r--p 40000000 09:01 33079321
  /video/gcc/.git/objects/pack/pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
2ba2794b1000-2ba27a4b2000 rw-p 2ba2794b1000 00:00 0
2ba27bcb2000-2ba281c29000 rw-p 2ba23703c000 00:00 0
2ba281c29000-2ba2a32f5000 r--p 60000000 09:01 33079321
  /video/gcc/.git/objects/pack/pack-bd163555ea9240a7fdd07d2708a293872665f48b.pack
7fffb75e2000-7fffb75f7000 rw-p 7ffffffea000 00:00 0                      [stack]
7fffb75fe000-7fffb7600000 r-xp 7fffb75fe000 00:00 0                      [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
  [vsyscall]

Here's the heap:

00400000-004b9000 r-xp 00000000 08:16 296588
  /usr/local/bin/git
006b9000-006bd000 rw-p 000b9000 08:16 296588
  /usr/local/bin/git
006bd000-0c17f000 rw-p 006bd000 00:00 0                                  [heap]
40000000-40001000 ---p 40000000 00:00 0
40001000-40801000 rw-p 40001000 00:00 0
40801000-40802000 ---p 40801000 00:00 0
40802000-41002000 rw-p 40802000 00:00 0
41002000-41003000 ---p 41002000 00:00 0
41003000-41803000 rw-p 41003000 00:00 0
41803000-41804000 ---p 41803000 00:00 0
41804000-42004000 rw-p 41804000 00:00 0



-- 
Jon Smirl
jonsmirl@gmail.com
