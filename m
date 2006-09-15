From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 10:43:20 +0200
Message-ID: <200609151043.20681.jnareb@gmail.com>
References: <200609142327.23059.jnareb@gmail.com> <eedjrj$tja$1@sea.gmane.org> <7vvenpzi1h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 15 10:43:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO9Hp-0001c0-DZ
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 10:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWIOIm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 04:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWIOIm4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 04:42:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34364 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWIOImz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 04:42:55 -0400
Received: by ug-out-1314.google.com with SMTP id o38so140100ugd
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 01:42:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EpuqF7yg6dh/bz6V3caA3P9V25q77aLEnNXi3JW6O6jItP0Ilb0ZStHZ42bpjEu4OpC9cHVR9ZIULQ4bJMql1pDK5ZmvzwDZoHZbpZHgEDhVuCE2imZZf9BN5OR2LTErRtlcKW7K5mJQ5gkgexZv5I9nmX/WSTEnBJS9ikVR7Zw=
Received: by 10.66.221.6 with SMTP id t6mr5322916ugg;
        Fri, 15 Sep 2006 01:42:54 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id 30sm1172555ugf.2006.09.15.01.42.53;
        Fri, 15 Sep 2006 01:42:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <7vvenpzi1h.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27068>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > But, if we change git_get_refs_list to do also work of git_get_references,
> > we should also change git_get_references to not use info/refs file at all
> > (it can, and usually for unknown reasons is stale) but always use
> > git-peek-remote, for consistency.
> 
> Yes that would make sense.  A repository served by gitweb does
> not necessarily has to serve objects over http transport, so it
> is nicer not to require info/refs to even exist or up to date.

We do not require info/refs, as currently git_get_references falls
back to git-ls-remotes (should be git-peek-remote as it is faster)
if info/refs does not exist. But info/refs is usually stale; I guess
it is updated on pull/fetch/push, but not on commit.

-- 
Jakub Narebski
Poland
