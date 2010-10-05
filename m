From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 20:10:09 -0500
Message-ID: <20101005011009.GD9994@burratino>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <20101005005715.GB2768@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Enrico Weigelt <weigelt@metux.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 03:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2w6B-0006ry-2U
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab0JEBN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:13:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60218 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729Ab0JEBN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 21:13:28 -0400
Received: by eyb6 with SMTP id 6so2313565eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Bdefnv1JZMWUsfsgAzS548sLUyXfaCg6L1IecdcoDMI=;
        b=QbiP9CBa6HMhLkTVmvezX8pLVvIaYhmtpMaVHoOW33o8F7FCkmKH4lF1y/XCKMEg7M
         j4yJe8A+gABDzPvIJ5HMzPQ/eMPggW2r6TQtJB7NRYj/FZiQm9mF20aNxHZUPQtTiCIr
         mhWIOfQMWrBImXIsayrriYT9YTnTAO1NL/xig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K7ApdBmE8qutBWOgKg9cOIZJlA6QKNt8hmk+JdA8oIs9Qnz/93t3nyfUS+38zbtZbm
         uHBZVIJH8rCO5wmWYKdR/DOQwFIwflH2/dp7zO+m9giD+qmeEdtQzp4nQYssy57ftcDS
         w7K4ixEUmb08r1nEUyirEzHw0Ngl5wpxgE4v8=
Received: by 10.14.119.10 with SMTP id m10mr1752873eeh.10.1286241207346;
        Mon, 04 Oct 2010 18:13:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id a48sm8293341eei.13.2010.10.04.18.13.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 18:13:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101005005715.GB2768@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158155>

Enrico Weigelt wrote:

>     CC read-cache.o
>     read-cache.c: In function `fill_stat_cache_info':
>     read-cache.c:73: structure has no member named `st_ctim'
>     read-cache.c:74: structure has no member named `st_mtim'
>     read-cache.c: In function `read_index_from':
>     read-cache.c:1334: structure has no member named `st_mtim'
>     read-cache.c: In function `write_index':
>     read-cache.c:1614: structure has no member named `st_mtim'
>     make: *** [read-cache.o] Fehler 1
>     
> Is my libc too old ?

What platform are you on?  You probably need USE_ST_TIMESPEC;
if so, please send a makefile patch so the next person trying
it doesn't need to worry about it.

Also, please don't destroy the cc lists; it makes it hard for
people with some mail setups (e.g., mine) to notice when you've
replied to them.
