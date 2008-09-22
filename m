From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 16:19:20 +0400
Message-ID: <20080922121920.GL21650@dpotapov.dyndns.org>
References: <19596152.post@talk.nabble.com> <19599905.post@talk.nabble.com> <48D74B1C.6020408@panasas.com> <20080922085200.GI21650@dpotapov.dyndns.org> <48D77643.1090908@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mwolfe38 <mwolfe38@gmail.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 14:20:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhkP5-0001x3-Vq
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 14:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYIVMT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 08:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYIVMT1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 08:19:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:39125 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIVMT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 08:19:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1349053fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pk8OvV2HysCz/GgDvpOfQgNM96yAQtx2GiGcdxf75BI=;
        b=Bv2Dkdbj3QA48S7bWO1HJBEUWs9iBaP4VPdhe5sBrokgEuvEuLk6z5wXAJrXhx/a4E
         hGeA0p+tlC5EfuLIxycURDVwnOq3Rue8udnM1a3y2nLS0JKsbC3JmObVWjhEe9wqCcTF
         eRfTGVavxz1ZFdvavIhEOs+/ysZFq4eK+AlLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gZyyIcIMsgiF0Qz5nKuuFRZkYMPfhdb3G4TKO6t2ioj+Vvrz7BHlXADESC5gL/4XXA
         8bBloWoGxW/ndKpPSn7ViA+5wjm33WE9ACUeK7CBKz5SYPwBADikQRNs3JnT2XW+LY35
         e8HQ87C8Y1i9bx4uaEvsrAeBg5XCEtIzw9VYw=
Received: by 10.86.95.8 with SMTP id s8mr4708672fgb.6.1222085964472;
        Mon, 22 Sep 2008 05:19:24 -0700 (PDT)
Received: from localhost (ppp85-141-148-201.pppoe.mtu-net.ru [85.141.148.201])
        by mx.google.com with ESMTPS id l19sm5291255fgb.7.2008.09.22.05.19.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 05:19:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48D77643.1090908@panasas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96476>

On Mon, Sep 22, 2008 at 01:41:07PM +0300, Boaz Harrosh wrote:
> 
> Ok I found it. Regular subdirectories it works as you said,
> but soft-link to a folder does not.

Why should it? Git does not follow symbolic links regardless whether
they point to files or directories. In fact, Git does extra checks to
avoid something like: symlink-to-dir/normal-file to be added as a
normal file. There was some discussion about it a couple months ago
("Not going beyond symbolic links").


Dmitry
