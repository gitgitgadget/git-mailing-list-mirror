From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 09:21:37 +0100
Message-ID: <CAOs=hR+u_MrHK4iNFZj4pLVhZ6-_75YpqN7tqWnSjh+di8Lzxw@mail.gmail.com>
References: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de>
 <alpine.DEB.2.00.1110292230500.28196@tvnag.unkk.fr> <CAOs=hR+YuF+HP0n0132Ktm3RdeWsnVp0Bgt89LNn+VyT6W0mcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 09:22:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLW5H-0007BA-RX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 09:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab1KBIWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 04:22:02 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:34542 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1KBIWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 04:22:01 -0400
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com [209.85.161.174])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 6CF62249C2BB
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 09:21:59 +0100 (CET)
Received: by ggnb2 with SMTP id b2so329499ggn.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 01:21:58 -0700 (PDT)
Received: by 10.236.152.2 with SMTP id c2mr5512827yhk.36.1320222118101; Wed,
 02 Nov 2011 01:21:58 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Wed, 2 Nov 2011 01:21:37 -0700 (PDT)
In-Reply-To: <CAOs=hR+YuF+HP0n0132Ktm3RdeWsnVp0Bgt89LNn+VyT6W0mcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184615>

>> Calling select() with max_fd+1 (== 0) will then not be appreciated by all
>> implementations of select() so that case should probably also be covered by
>> the 50ms sleep approach...
>
> Actually, the 50ms sleep was also implemented using select(0, ...)
> before the patch. I tried to keep the previous behavior when curl does
> not give us any information.
> I assumed that the select(0, ...) was some portable way to sleep with
> microsecond granularity.

Upon a bit of research, it seems that select(0, ...) is indeed quite
commonly used. So I'd just keep it as it was unless you know of a
problem it causes.

Since I'm new here, I don't really know what the next steps are for
the patch, should I just wait? Or send it directly to someone?

Best,
 Mika
