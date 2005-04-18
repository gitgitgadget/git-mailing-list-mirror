From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Mon, 18 Apr 2005 14:12:40 +0200
Message-ID: <87u0m4cmh3.fsf@deneb.enyo.de>
References: <E1DNMVX-00013d-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pj@sgi.com (Paul Jackson), pasky@ucw.cz, git@vger.kernel.org,
	mj@ucw.cz
X-From: git-owner@vger.kernel.org Mon Apr 18 14:09:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNV42-0005Pe-9M
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 14:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVDRMNB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 08:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVDRMNB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 08:13:01 -0400
Received: from mail.enyo.de ([212.9.189.167]:64932 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262048AbVDRMMy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 08:12:54 -0400
Received: from deneb.enyo.de ([212.9.189.171])
	by albireo.enyo.de with esmtp id 1DNV7J-0007bh-Ao; Mon, 18 Apr 2005 14:12:41 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DNV7I-0003ns-I5; Mon, 18 Apr 2005 14:12:40 +0200
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DNMVX-00013d-00@gondolin.me.apana.org.au> (Herbert Xu's
	message of "Mon, 18 Apr 2005 13:01:07 +1000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Herbert Xu:

> Paul Jackson <pj@sgi.com> wrote:
>> 
>> Even mktemp(1) can collide, in theory, since there is no practical way
>> in shell scripts to hold open and locked the file from the instant of it
>> is determined to be a unique name.
>
> mktemp(1) creates the file before exiting.  Other instances of mktemp(1)
> cannot successfully create the same file (they all use O_EXCL).
> Therefore this race does not exist, even in theory :)

/tmp cleaners exist, but the risks are minimal for programs which
aren't SUID/SGID.
