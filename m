From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/5] transport: expose git_tcp_connect() and friends in
 new tcp.h
Date: Thu, 8 Mar 2012 16:28:03 +0100
Message-ID: <CABPQNSbSkq3DnxvJ8tDp4KdyaeW1H6GriT9V3X6SLCRjkNR-fw@mail.gmail.com>
References: <20120308124857.GA7666@burratino> <20120308130304.GA9426@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fGq-0000gz-Ib
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab2CHP2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 10:28:44 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35124 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab2CHP2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 10:28:43 -0500
Received: by pbcun15 with SMTP id un15so1605349pbc.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 07:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=7tmi+uaKHOOD3ftPtHBn6nNeiTdi0GH6oU5GBM8lay8=;
        b=yDVoNul8L3gUfOVILzMBzV0u4fmPwrFoTbIs3HixdY1ReW1mPSlD4wdF8NTsSlCIvl
         aTLi7qX2u19hQQWv/KNjRf/9LMXb5lwvsBNB5Na+/2ZoXjsgIoBHWThLiN+t+t2c2oIX
         GVH6qbKIaTfpLwS9wwJRB2J80vxrGW18YF07fa/utxp4+aJ/xT0W9GRF9dYJC41ueY4J
         lcnn0D/EMdEYiZVlRVbjhejqU8efWWnKqinMSi8A1+OLZhJmuFtTw6+9WuWbguNm02i2
         B/yXoO/mqt1h/RHZROz611951ucufpGT9CvCxdD1GUBATw9KpKv2RzE3RN5v/XSMS+Yx
         0hKQ==
Received: by 10.68.233.99 with SMTP id tv3mr10201075pbc.73.1331220523207; Thu,
 08 Mar 2012 07:28:43 -0800 (PST)
Received: by 10.68.1.135 with HTTP; Thu, 8 Mar 2012 07:28:03 -0800 (PST)
In-Reply-To: <20120308130304.GA9426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192609>

On Thu, Mar 8, 2012 at 2:03 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Date: Mon, 6 Jun 2011 04:37:14 -0500
>
> Split off a new tcp.c with the functions git_tcp_connect() and
> git_proxy_connect() that resolve and connect to a host.
>
> Part of a series to teach git to respect DNS SRV records when making
> new connections. =A0This is a preliminary step to make the connection
> library easier to understand before changing it.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Nice. Now that this has been libified, someone can probably get rid of
some code in imap-send.c (specifically in the imap_open_store
function) on top of your topic...
