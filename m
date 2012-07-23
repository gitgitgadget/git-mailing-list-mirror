From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2 6/7] build: "make clean" should not remove configure-generated
 files
Date: Tue, 24 Jul 2012 01:15:19 +0200
Message-ID: <500DDB07.6050006@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org> <cover.1342683786.git.stefano.lattarini@gmail.com> <904eb7b0b17805b5265ab70709241b7da382a0cb.1342683786.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 01:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRqa-0004cS-EF
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab2GWXPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:15:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62991 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab2GWXPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:15:23 -0400
Received: by bkwj10 with SMTP id j10so5795048bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0iDsFHrI4dQgOx89yLkDLsnhQZwByu/l62Y1ebaXq/A=;
        b=BNi5a/p943d9FF7YbIZuyFxWxB7iWMiF6FkkJl/a4/Salyyap72hk8LJW2bB9ZeoOd
         oaIwcNVUU4KAi1FI5tiFGne4ZSBXHGUU5ieBJRzIMZLTFsGi7IBhdTlsRvgN1DUyk5O2
         4zpKzKEeWZOONPy2YH4rjbQVLkFvWBDHS2F4+dat3gJwPxyAYb4tFxQL1yotQg+Cua8r
         3Em1PF/KuHTwpwHhjGpE4KlGuVAXaLmgbM4sG4mgkxDMQzeJB9Yuc0nVXzgnDxGY/o65
         4BGQpbXTDZBhIkR3ZfPAV8MJchiY0xHmyXRMK46U9nvb8+DA/6n/tPaXiKfp6J45habd
         D7Ng==
Received: by 10.205.132.12 with SMTP id hs12mr8996561bkc.47.1343085321693;
        Mon, 23 Jul 2012 16:15:21 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id 25sm9166601bkx.9.2012.07.23.16.15.20
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 16:15:20 -0700 (PDT)
In-Reply-To: <904eb7b0b17805b5265ab70709241b7da382a0cb.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202001>

Hi Junio.

On 07/19/2012 09:50 AM, Stefano Lattarini wrote:
> Those filed
>
Oops, this should read "files", not "filed" ...

> hold variables, settings and information set by the
> configuration process run by './configure'; in Autotools-based
> build system that kind of stuff should only be removed by
> "make distclean".  Having it removed by "make clean" is not only
> inconsistent, but causes real confusion for that part of the Git
> audience that is used to the Autotools semantics; for example,
> an autotools old-timer that has run:
> 
>     ./configure --prefix /opt/git
> 
> in the past, without running "make distclean" afterwards, would
> expect a "make install" issued after a "make clean" to rebuild and
> install git in '/opt/git'; but with the current behaviour, the
> "make clean" invocation removes (among the other things) the file
> 'config.mak.autogen', so that the "make install"
>
... and here we should add "invocation":

    ... the "make install" invocation ...

> falls back to the default prefix of '$HOME', thus installing git
> in the user's home directory -- definitely unexpected.

Can you fix those nits locally before merging to 'next', or should
I send a re-roll?

Thanks, and sorry for the confusion,
  Stefano
