From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 19:08:45 -0600
Message-ID: <20101204010845.GC15906@burratino>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
 <20101203202923.GB15517@burratino>
 <AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
 <20101203205534.GA15658@burratino>
 <7vfwueo9ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 02:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POgio-0007s3-Az
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 02:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab0LDBPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 20:15:25 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:38766 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab0LDBPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 20:15:24 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 20:15:24 EST
Received: by gwb20 with SMTP id 20so5060413gwb.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=thTv9dGTRcKMMsRUrOzkGgKorpz46a+P4fGqv9P+ISM=;
        b=lWFOyMUZwt1Cms2NzQluXb8HuOiIlvGZDs2h8/OZ1tZTx00M68ADoBgYZar708nlBX
         TfxKRY9OGFMIj2Pgkr5xp+ofJJOcr0d1UKd8hDzGxGWjytubFgvFlEWvf28JuhViKDXA
         I+VAsFUYlwOrdeF/yFJS5GDqKoyQGyXAyyWeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JRkSqL76/I8ihZw2tDsSBv9kUliiBiNlBy2Yy/1nQGSnWnhtQjUE/8b6tFYKGtnklk
         1ooSkbTZtwVQymz36BwnK0Gog9Agm/NMp/rhmlTbXvs5CVMYGOGBo9jLZPBNADAlx6z3
         PNbHqZTxLUJXANmq43nOHexhBDwlLK04rF49w=
Received: by 10.90.27.14 with SMTP id a14mr4060644aga.113.1291424939724;
        Fri, 03 Dec 2010 17:08:59 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id t39sm2387510ano.7.2010.12.03.17.08.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 17:08:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfwueo9ie.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162877>

Junio C Hamano wrote:

> Two nits if this is really to help scripters.
> 
>  - Both -c and --cc cull merges uninteresting at the file level; if the
>    script _really_ wants to view the whole history, giving -m would be
>    more appropriate.
> 
>  - The default history traversal is --dense and also with merge
>    simplification turned on; again, if the script _really_ wants to view
>    the whole history, --sparse and/or --full-history would be necessary
>    depending on the needs.

In a "tree blame" script:

 - silence when a file was not changed from at least one parent is
   perfectly appropriate --- that is not the birth of a blob;
 - --dense versus --sparse shouldn't affect the output if the
   rev-list and diff-tree are limited in the same way;
 - history simplification is probably appropriate --- blind alleys
   are not needed to explain the origin of this blob.

On the other hand, a "lifetime of this content" script would have very
different requirements ---

 - changes from all parents would need to be tracked, requiring -m;
 - --dense versus --sparse would still not matter, but:
 - history simplification would be inappropriate, anyway --- blind
   alleys ought to be investigated in case the content made a brief
   appearance some time in the past.

--- making the options you mention quite relevant.  Thanks.
