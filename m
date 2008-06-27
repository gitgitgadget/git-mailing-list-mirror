From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Fri, 27 Jun 2008 07:46:50 -0700 (PDT)
Message-ID: <m3prq3hr6n.fsf@localhost.localdomain>
References: <4864DD65.1080402@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mircea Bardac <dev@bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 16:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFEt-0003pd-Rl
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 16:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbYF0Oqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 10:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbYF0Oqy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 10:46:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:29897 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661AbYF0Oqx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 10:46:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so387482ugf.16
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=bPSHotRSO49f2PK1VOfxHVanwgR0vw5mfOYf0i6Ca00=;
        b=BlnOA1bGSZp5VY6zkW14naJzVXS1jByGBXELcOrf3U2lqDXjgQ6GKa4AogQafdIpYT
         KrBLOO0fWVnjy78mpVQ0PddtNpU6OrVnpexLssomuz6gQBssN3dX1/+y+sXw+QHsf/gg
         uYSztmBv7+Vm0lUlLu2GmOez/t6j8LBbHW1EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=gdIikQVnGyEBHppcNZ/o0nENqQuwJ+7H6kcdl2eruZzAPyM9KpChvbFl+LBLP2oDeM
         aBwe5KEivPOqrCuGl+PEGmncDUtj7tfOqwdFnqrRB3qZUAdAzIR/zEFnEv9kCCqRF/E6
         NKrbj2NIdHrf3GLMQJl9hX+fcfJ6EuqVPuLx8=
Received: by 10.67.24.18 with SMTP id b18mr2122317ugj.11.1214578011548;
        Fri, 27 Jun 2008 07:46:51 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.205.161])
        by mx.google.com with ESMTPS id e1sm193068ugf.19.2008.06.27.07.46.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 07:46:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5REkFhK030428;
	Fri, 27 Jun 2008 16:46:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5REjrhh030422;
	Fri, 27 Jun 2008 16:45:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4864DD65.1080402@mircea.bardac.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86568>

Mircea Bardac <dev@mircea.bardac.net> writes:

> $ ./configure
[...]
> configure: CHECKS for header files

Here ./configure check for existence of heder files, but only those
that can be skipped by defining some macro...

> configure: CHECKS for site configuration

...and here is check for --with-zlib=<path to zlib>

> configure: creating ./config.status
> config.status: creating config.mak.autogen
> 
> $ make
> GIT_VERSION = 1.5.6.1
>      * new build flags or prefix
>      CC daemon.o
> In file included from daemon.c:1:
> cache.h:9:18: error: zlib.h: No such file or directory
> make: *** [daemon.o] Error 1
> 
> (installing zlib1g-dev on Ubuntu 7.10 fixed the problem)

What should ./configure do (what ./configure for other programs
or packages do)?

You cannot compile git without zlib!
-- 
Jakub Narebski
Poland
ShadeHawk on #git
