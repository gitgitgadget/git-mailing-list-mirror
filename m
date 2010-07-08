From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: mangle refnames forbidden in git
Date: Thu, 8 Jul 2010 08:03:15 -0500
Message-ID: <20100708130315.GA1529@burratino>
References: <4BE3249B.7050100@theblacksun.eu>
 <20100708084356.GA29856@burratino>
 <20100708085814.GC10779@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten Schmutzler <git-ts@theblacksun.eu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 15:04:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWqlv-0007EH-D6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 15:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab0GHNEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 09:04:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48498 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508Ab0GHNEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 09:04:04 -0400
Received: by gxk23 with SMTP id 23so329385gxk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=x6pwjLQIkJ5V4GFBAoGOCkQSDc19uxfcK49h165KjW8=;
        b=sqMubLysD88VJPudxduKGVj1yQdrH8NYTKtBgca+Cfly1iKvZl/e7DW0NIe3fg+SbM
         OUqWMvX4iE6b9Rj2Styi9wIikebzuSRdBY7DUBfQtEqqyC4bhjziBpfNfelPNZmpHz2O
         JwjCwfgFokKnZl+QESk2donZ+Ni3cRkeN5ahM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yx8Y7AJBeCaADmRQnPxyqFoVagFEzg8WcUbpCTvWsRP74RrzSXDXTgyVr3NepD5Yoj
         LyiiJdYdfHtyTGolsmeRdie+DUvGM2PBEEuOR1wd+Gj+iEe3Q11aoEXwNpjqq1yCdqQX
         B56DRnk5g4K6n2nZu2fsRBsdPWyIurtdqxn8o=
Received: by 10.150.69.35 with SMTP id r35mr270466yba.103.1278594242438;
        Thu, 08 Jul 2010 06:04:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm34045045ibi.6.2010.07.08.06.04.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 06:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100708085814.GC10779@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150571>

Eric Wong wrote:

> I can't reproduce it with 1.5.1 here, does URI-escaping the "@{0}"
> to "%40%7B0%7D" work?

Yes.

 ...
 $ svn cp -m reflog file:///tmp/foo/source 'file:///tmp/foo/not-a%40%7B0%7Dreflog'
 Committed revision 2.
 $ (cd wc && svn update)
 A    not-a@{0}reflog
 Updated to revision 2.

Does that work with svn 1.5.x?
