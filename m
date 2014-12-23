From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 12:14:16 -0800
Message-ID: <20141223201416.GA29365@google.com>
References: <20141223084536.GA25190@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 21:14:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Vqa-0004vK-UG
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 21:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbaLWUOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 15:14:20 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32810 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaLWUOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 15:14:20 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so5991400igj.10
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0/6Gd7jbfCgXrC1VIue6o0oBq0SWZLB3kjRl1L40Dss=;
        b=0bmw79aDlPey38+DukC+SMyED4KRdPk0MUyNcuDme5ioB0PHL78E3j3ZVTL3uXMEu8
         t6ou7RnP+/rWvTT7xJS6RROh1v0yC5Mn3E6BicBYIIEB59PNDv3BNZR84wrajOPb4GM6
         iknVL4Me0Jn9cHa7wsseO2n5ik69VcjxkxZ2xFw5cYW6b+sA/6eW22WgztQ9369weKUg
         DwzlPwYWtaC7yPly8B9E1Rkk6MRggMVwyKl/QzZiEfoK07Lw0iJ4P2Sj3X/2St8PZBi/
         zo/kJ1qh+KNvOHz5YGidgNTo3BsnBE19gzBLpaxcH5TsagTqm9rll6g13tomFwD4+vhZ
         E9qg==
X-Received: by 10.107.7.142 with SMTP id g14mr27274713ioi.81.1419365659332;
        Tue, 23 Dec 2014 12:14:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id kv4sm6759840igb.13.2014.12.23.12.14.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Dec 2014 12:14:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141223084536.GA25190@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261771>

Jeff King wrote:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1450-fsck.sh | 16 ++++++++++++++++
>  utf8.c          | 17 ++++++++++++-----
>  2 files changed, 28 insertions(+), 5 deletions(-)

Mph.  Sorry I missed this before.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> +++ b/t/t1450-fsck.sh
[...]
> +		git fsck 2>err &&
> +		cat err &&
> +		! test -s err

Nit: if this said

		test_line_count = 0 err

then the error message would be more obvious when it fails with
--verbose.

Thanks,
Jonathan
