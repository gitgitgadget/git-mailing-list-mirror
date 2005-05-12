From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] cg-init should only process files
Date: Thu, 12 May 2005 12:37:19 -0400
Message-ID: <118833cc050512093750db7d55@mail.gmail.com>
References: <E1DWG9b-0001VV-V0@ash.dgreaves.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 18:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWGZG-0000cx-Cw
	for gcvg-git@gmane.org; Thu, 12 May 2005 18:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVELQhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVELQhX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 12:37:23 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:36134 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262073AbVELQhT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 12:37:19 -0400
Received: by rproxy.gmail.com with SMTP id a41so264274rng
        for <git@vger.kernel.org>; Thu, 12 May 2005 09:37:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dV2vjKZ/3fklkOvAwsGKi4eLL8L/1WMsQoEoCT0E+kGj41sd9voJY6zC3/asRMYsmm8MeKP1kRJReteZ21yQHKi/X5huujtDDyG6ZeHKAY9ldododVyhwj+1UdYWRHrD3S/1Hn7Xl1VuxggdUHcRCIVA+GgBOAVeVBeDQEM9XZM=
Received: by 10.38.6.75 with SMTP id 75mr888479rnf;
        Thu, 12 May 2005 09:37:19 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Thu, 12 May 2005 09:37:19 -0700 (PDT)
To: David Greaves <david@dgreaves.com>
In-Reply-To: <E1DWG9b-0001VV-V0@ash.dgreaves.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> -       find * | xargs cg-add
> +       find * -type f | xargs cg-add

I think we went through that a day or two ago:  Problems:

1. You forgot symlinks.
2. It does not work if nothing matches "*".  (Nor does the original.)
3. Either it should not match dotfiles in subdirectories, or else it
should match
   them in the top directory too.
4. With needs some -print0 and "--" protection.

Morten
