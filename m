From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [EXPERIMENTAL PATCH] O(n) bisection algorithm
Date: Thu, 30 Jun 2005 19:03:51 +1000
Message-ID: <2cfc4032050630020359c76147@mail.gmail.com>
References: <20050630081135.27577.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 10:57:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnuqY-0002ix-EW
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 10:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVF3JDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 05:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVF3JDz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 05:03:55 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:60056 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262893AbVF3JDy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 05:03:54 -0400
Received: by rproxy.gmail.com with SMTP id i8so73483rne
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 02:03:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LGSyzsKRLKk+fau4EivDxEzd1xg2PBIaydypocoE/Wb4mdJrouksW4vd9LSSiqp9o6qmvXgji8jey0B/l0Hf1ZkaaeYgv5lJ4kOgNJ7wJd/JKVfEzRNsezrSF/qmmqIBhZothsucZeC44HglgRb5cMigRB/xTlpSUmRMOkYLEtU=
Received: by 10.38.65.5 with SMTP id n5mr454705rna;
        Thu, 30 Jun 2005 02:03:51 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 30 Jun 2005 02:03:51 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050630081135.27577.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

BTW: just in case you are wondering what these variables are for and
why they and the associated code is there...

> +static struct commit_list * topological_order = NULL;
> +static struct commit_list ** t_o_tail = &topological_order;

They are not required. This was a remnant of a previous version that
used the --merge-order code to obtain the topological order. Of
course, the final submission will remove this redundant code.

jon.
