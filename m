From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 20:25:07 -0800
Message-ID: <1196915112.10408.66.camel@brick>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>
	 <20071205.182815.249974508.davem@davemloft.net>
	 <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
	 <20071205.185203.262588544.davem@davemloft.net>
	 <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08Is-0003Qb-V9
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbXLFEZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXLFEZM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:25:12 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:36072 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXLFEZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:25:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so95679rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 20:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=E85kMK47zoc1x2xAP6DjceN0f5L38bh9O18x1tI3pgo=;
        b=dk/4OTmXVwd0ZixdLjV/LrNH0LTIg6ycQ5f7FptIwHa0vYhyZ9D9Fqtup/QQsyeH/vCj9Psbn3jvTsew3ZG4VxsncyMK2Tb1YsjTXg/OINN8+8eZVgihNBUvtJyPJVadd0OryMpWtuIKUs7QgNluT/hQTVXPiFLasdvMxGN2O/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QlVxX4kJ3hLjANEFfU/H3pxYUGWxKmmXSrYmgni9ulWDFlGFCizZvnvG60ZeuoCRpdhwwMO9huuYo9mxIJJy+15tF2AhJqYpKwdmQewuePgnMFYbo6md7AIGWoPATgN1RPNncTqL9lmH2EXU/Jf9rmFcwTXNXM5KU8SMAJbXCxQ=
Received: by 10.140.139.3 with SMTP id m3mr1714691rvd.1196915109519;
        Wed, 05 Dec 2007 20:25:09 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id g31sm155750rvb.2007.12.05.20.25.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 20:25:09 -0800 (PST)
In-Reply-To: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67229>

I fought with this a few months ago when I did my own clone of gcc svn.
My bad for only discussing this on #git at the time.  Should have put
this to the list as well.

If anyone recalls my report was something along the lines of
git gc --aggressive explodes pack size.

git repack -a -d --depth=100 --window=100 produced a ~550MB packfile
immediately afterwards a git gc --aggressive produces a 1.5G packfile.

This was for all branches/tags, not just trunk like Daniel's repo.

The best theory I had at the time was that the gc doesn't find as good
deltas or doesn't allow the same delta chain depth and so generates a 
new object in the pack, rather the reusing a good delta it already has
in the well-packed pack.

Cheers,

Harvey
