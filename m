From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 20:53:34 +0100
Message-ID: <200802112053.35141.jnareb@gmail.com>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com> <m3myq7e3ie.fsf@localhost.localdomain> <alpine.LFD.1.00.0802111436100.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOejK-00033U-Dv
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbYBKTxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757402AbYBKTxn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:53:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:58437 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbYBKTxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:53:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so362172ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=514EisYdOE0usnxFTiNkEDGeDQ1JlPegvYUCyr6m8AQ=;
        b=lj8h5fHkH5nZcu9IlTNTN0EijRfMzvpUI7WxVv9gg4aXTUg8rBhnwdKetrRTRJdl1twCGzldNkyX2ccewgX/uLOjn1N73dCKhJZR9WCSTg5XoACvAxOvgiI22If9rd5BfIhhLvnPjoj5S8pG2mIrbJDtC5kJna2TCv3PqoheKJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uKK6zF1feBwPuLysQPJvLGvqjWlguzD4xUkoBt86+xOHzw3Ba2tgJCP9WG7NxpOedBtlKlH/XM64fiEfCH5XJ16nevn2sTYoK49qPo5OX50XkHygA+f09gKP1mRf6pb1AfNvp+AWSp2iCXOR6/nRs3mxSZTJQ1ZZZy9sXVbAo+E=
Received: by 10.78.185.15 with SMTP id i15mr721280huf.61.1202759620455;
        Mon, 11 Feb 2008 11:53:40 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id 33sm484734nfu.9.2008.02.11.11.53.38
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 11:53:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802111436100.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73575>

Nicolas Pitre wrote:
> On Mon, 11 Feb 2008, Jakub Narebski wrote:
> 
> > [*1*] I hope that '--no-reuse-delta' means _try_ to find better delta,
> > but use current one as possible delta, not stupid forget about current
> > deltaification at all...
> 
> It is really "forget about everything".  And by the time you look for 
> the best delta from scratch, remembering what was the best delta before 
> won't give you much performance gain, plus it has nasty issues like 
> making sure no delta cycles are created if you reuse an old delta, etc.

So we have either: don't try to find better delta (default), or forget
totally about old delta (--no-reuse-delta), no middle ground? That's
bad...

Or the default is try to find better delta, but reuse if better?

-- 
Jakub Narebski
Poland
