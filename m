From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 17:07:43 -0400
Message-ID: <59ad55d30608211407v74e1369dw17fae16933c0356f@mail.gmail.com>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com>
	 <20060821101346.GA527@diku.dk>
	 <59ad55d30608211312u51a4657eyd52311314a6ee03c@mail.gmail.com>
	 <Pine.LNX.4.63.0608212227040.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 21 23:09:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGzr-0000PJ-Cr
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 23:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWHUVHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 17:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHUVHp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 17:07:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:64008 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751112AbWHUVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 17:07:44 -0400
Received: by wr-out-0506.google.com with SMTP id i21so333100wra
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 14:07:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nS7qtzqNt2RnFyOi9kX4rFwtvhkiaLxvfTmvgMjPHuzsllFE7st6zzzpizVNEuTtB4KGJ33LSdc3BbIIHCyaxEj06ipThIM3VZcZTbnKrhgRPkrJ8/1oVhTTf4UKc/YcV3ApZ+v37gAJd0LE2lcBWpiQxnTRjjynD5H5xLRVOLQ=
Received: by 10.70.52.5 with SMTP id z5mr10251120wxz;
        Mon, 21 Aug 2006 14:07:43 -0700 (PDT)
Received: by 10.70.33.1 with HTTP; Mon, 21 Aug 2006 14:07:43 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0608212227040.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: a6f8b58aa563ccde
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25820>

On 8/21/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 21 Aug 2006, Kristian Hxgsberg wrote:
>
> > Thanks to all who reviewed the patch, here's an updated version which
> > should address all issues.
>
> I would have preferred the use of path_list instead of rolling your own
> thing with qsort(), but oh well.

Yeah, I saw that, but since I got flack for computing
lookup_commit_reference(head_sha1) inside the delete_branches loop, I
couldn't possibly risk the performance bottle neck of listing the
branches using a O(n^2) insertion sort.

Kristian
