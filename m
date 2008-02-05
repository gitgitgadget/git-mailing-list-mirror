From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Tue, 05 Feb 2008 02:04:51 -0800 (PST)
Message-ID: <m34pcn67nu.fsf@localhost.localdomain>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
	<7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
	<20080131023629.GB7778@c3sl.ufpr.br>
	<7vsl0eg16c.fsf@gitster.siamese.dyndns.org>
	<7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
	<20080205044121.GA13263@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Feb 05 11:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKgC-0007DQ-Iw
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYBEKE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYBEKE4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:04:56 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:6276 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbYBEKEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:04:55 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2263955fkz.5
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=ZhXLesI1lE1YDhn3l1Wr5xrN+/7d0TTQHyLJZQPNwQI=;
        b=InfvtNLUBs4mNPpYhAHjvOvRhWEYjYyhSCZgQgXzdAeVnL8IG4pejLP62jbGvg3OzCHyOhocRhTLfWqiU6cvQ+bwqcIxt0WS0IcHLn1wrBWQBGWa1Sm2vUd5gGm9cZ4XCB89rXmaRyG0jIJLfHKspz3FiSM1H2OQzSUt71u4mQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=OBuNYVF4xI1n3i4rdYBwZudFymM0RImGRXh2xRpaF475bTG8DjV/IbOic5d2ym0t9mYmytQCRbUL2teJV8lFUvka1YZ7KW7u2MohhFCl9tN/fqKT5YW/5/vHIYKR0Wv9pEEkoyBPzML3G1YU0us3RsnkthSFkSo+xNHAZD7gPGU=
Received: by 10.78.167.12 with SMTP id p12mr14435634hue.20.1202205893124;
        Tue, 05 Feb 2008 02:04:53 -0800 (PST)
Received: from localhost.localdomain ( [83.8.224.128])
        by mx.google.com with ESMTPS id b36sm4110313ika.2.2008.02.05.02.04.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 02:04:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m15A4gHA004837;
	Tue, 5 Feb 2008 11:04:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m15A4bSJ004834;
	Tue, 5 Feb 2008 11:04:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080205044121.GA13263@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72640>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:

> On Wed, Jan 30, 2008 at 07:06:44PM -0800, Junio C Hamano wrote:
> > If the config reading interface is too slow (somebody has to
> > bench it on a large set of repositories), maybe we would need to
> 
> I made a simple bench as follows.
> 
> dd= 'dd if=/dev/zero of=/home/bruno/dds/$i bs=1M count=400000'

This was to provide load, and check how it works under load, isn't it?

> Machine: 4*opteron 2.8GHz
>      32GB ram
>      14*750GB RAID0 sata2 /home
>      
> Generated a 1000 projects [ too much?! git.debian.org has 668]
> For each test a 'echo 2 > /proc/sys/vm/drop_caches' was done before running
> it.
> 
> command: time gitweb.cgi > /dev/null

Didn't you mean

  time GATEWAY_INTERFACE="CGI/1.1" HTTP_ACCEPT="*/*" \
       REQUEST_METHOD="GET" QUERY_STRING="" gitweb.cgi

here (or some wrapper thereof)?

I wonder what would ApacheBench show... 

Note also that there are operating systems (MS Windows, MacOS X) where
fork is much slower than on Linux.


-- 
Jakub Narebski
Poland
ShadeHawk on #git
