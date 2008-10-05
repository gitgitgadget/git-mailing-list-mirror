From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Build bug report: 'make check' needs sparse, but configure doesn't check it
Date: Sun, 5 Oct 2008 04:34:46 +0400
Message-ID: <20081005003446.GN21650@dpotapov.dyndns.org>
References: <loom.20081004T131652-828@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 02:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmHbP-00024S-CE
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 02:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYJEAex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 20:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYJEAex
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 20:34:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52897 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJEAew (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 20:34:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489729fgg.17
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 17:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=INvDZpZHjVnkTgD4HtbOoPrgPj1cubRqM/SCvHkozsU=;
        b=Nug26ceRDI2yZPGDx7tb8a5OzBeP57Vcb8H8jY4HMAfjkegrxfP6J4fhuJfNYE4+np
         Mv4bvwPxlloOL25Cce+6eFfOfBz+2+uOyLRSwayYhJqtyuLQo3QBG+ml3liOq1oEiAN5
         P5cIw2FmbOFpudartQQovihPLWMIV7QkdXLyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pq3zy6YNo5bGVRl7Kh5jW3MPpHXTWjIrkJM4O3aQYvQrIvKD+MX4cxtgCJ7xQurv6D
         fb2XI9v4f3/LD8oYP6L5jsvNB5b8QrKQoBxG3JhKKPdmSxwZfFjSJMkiOmauwM4i2Txb
         R3dSJZY+1I0+YGDWiXAr9CXffQ0kYhDujVbJ4=
Received: by 10.103.131.18 with SMTP id i18mr1749729mun.126.1223166891275;
        Sat, 04 Oct 2008 17:34:51 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id i5sm7848723mue.11.2008.10.04.17.34.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 17:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20081004T131652-828@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97489>

On Sat, Oct 04, 2008 at 01:19:56PM +0000, Ed Avis wrote:
> When you build git-1.6.0.2 and 'make check', it tries to run sparse and fails if
> sparse is not there.  But the configure script does not check sparse is
> installed.
> 
> I suggest that 'make check' skip the sparse tests if sparse is not there.  As I
> understand it, they are really more for the developers to get a report of
> possible errors in the source code and not to test that the built executables
> work, so it would not be dangerous to just skip running those tests for ordinary
> users who don't have the tool.

The whole point of 'make check' is to run 'sparce' on all files.
Granted, you may not have 'sparce' installed, but then why do you
want to run 'make check'? It makes no sense. If you want to build
and to test the resulting binaries then you run 'make test'.


Dmitry
