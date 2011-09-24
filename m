From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: sparse checkout bug?
Date: Sat, 24 Sep 2011 14:19:18 -0600
Message-ID: <4E7E3B46.1040002@workspacewhiz.com>
References: <CAG+J_DwRPq69TUMOeqU5O9pv=cHZWEP1VJ1_NRaJv5BSFhF00g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 22:20:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7YiS-0001sM-61
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 22:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab1IXUSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 16:18:30 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:34239 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab1IXUS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 16:18:29 -0400
Received: (qmail 7343 invoked by uid 399); 24 Sep 2011 14:18:27 -0600
Received: from unknown (HELO ?192.168.1.101?) (jjensen@workspacewhiz.com@71.199.50.180)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Sep 2011 14:18:27 -0600
X-Originating-IP: 71.199.50.180
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAG+J_DwRPq69TUMOeqU5O9pv=cHZWEP1VJ1_NRaJv5BSFhF00g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182040>

----- Original Message -----
From: Jay Soffian
Date: 9/24/2011 1:50 PM
> I wanted to exclude a single massive directory from a checkout (the
> LayoutTests directory from WebKit, which includes 130k files), so I
> tried:
>
> $ git config core.sparsecheckout true
> $ echo '*'>  .git/info/sparse-checkout
> $ echo '!LayoutTests'>>  .git/info/sparse-checkout
> $ git read-tree -m -u HEAD
>
> But LayoutTests is not being excluded. I also tried every variation of
> including leading/trailing slash and trailing '*'.
>
This bug has very recently been discussed on the mailing list.

As a workaround, use:

/*

instead of:

*

You said you have tried this already, but it works for me.  The only 
thing I do in addition is this:

/*
!LayoutTests/

-Josh
