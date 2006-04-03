From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 10:26:27 -0400
Message-ID: <118833cc0604030726r44b0682etec3349f62986e3c0@mail.gmail.com>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
	 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 16:27:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQ0v-0005Fe-Ft
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWDCO0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDCO0i
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:26:38 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:39704 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751277AbWDCO0i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:26:38 -0400
Received: by zproxy.gmail.com with SMTP id o37so1850175nzf
        for <git@vger.kernel.org>; Mon, 03 Apr 2006 07:26:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=imG1SC/yqu2pJqTy7V7SqZlo4GlC/W2b9eyEf0BW2PE99lBu9bJ7E6QpH/WfIHzcO11N144rtpfjddk2RAO6icxmK+wUijvwYyGt4eYlOxkVsD7BKMT9lSIt1QmYsyDkvhrB0VMh7GEBVszwV2GXR82/EIEYEN9LxHsh3Pr7bic=
Received: by 10.35.127.7 with SMTP id e7mr1269080pyn;
        Mon, 03 Apr 2006 07:26:27 -0700 (PDT)
Received: by 10.35.39.13 with HTTP; Mon, 3 Apr 2006 07:26:27 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18330>

> The problem is not mmap() on cygwin, but that a fork() has to jump through
> loops to reinstall the open file descriptors on cygwin. If the
> corresponding file was deleted, that fails. Therefore, we work around that
> on cygwin by actually reading the file into memory, *not* mmap()ing it.

Maybe, but you aren't going to be able to handler much bigger packs
even on *nix.  Unless you go 64-bit, that is.

M.
