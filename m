From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 3 Feb 2008 22:51:30 -0800
Message-ID: <402c10cd0802032251y626f373eke66c35b200ccf5b1@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 07:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvBU-0007sr-Sm
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 07:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYBDGvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 01:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYBDGvc
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 01:51:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:56613 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbYBDGvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 01:51:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1907434fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 22:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oVGtBCtbSESuFz7MEFAsRoUMpuawXFwRhfho+y86kGg=;
        b=tTQ8WCWQdPWVqdvEvND5rTlPc4uPlCCHh6QeqTbFLQKmVwrNFEq1cylTL1rrScKOnIh4kc6Y6zAU0EqKjTZEt98czid3DUYU7DyqQ6JCReID+xkxly11LxFShBJJRjqlPXJR3t2j3G+UY1Vx7DsrULDrCkjgPPvuPDNC4EHrWsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YStzvWA6xwou9gNyUHKRjDG7hRusmZwAnqyK3LikGjA6zwQxdwMZsy1ZMYz8ZtfWeomMcMRYNuUSvxB8F5U4NODWI9ijlHFwbA8OgxV9i44Es+t92GYjnbp/He4B/1NM3ff7isjpKhlyqumiFs/GLDYKY2epSfTNVlLKpRc7SUU=
Received: by 10.82.161.19 with SMTP id j19mr12423126bue.25.1202107890218;
        Sun, 03 Feb 2008 22:51:30 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Sun, 3 Feb 2008 22:51:30 -0800 (PST)
In-Reply-To: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72464>

On Feb 3, 2008 4:54 PM, Sverre Hvammen Johansen <hvammen@gmail.com> wrote:
> This patch also uses the real heads found instead of those
> specified for real merges.  This means that merge startegies
> that only take two heads can now accept more than two heads
> if they can be reduced down to only two real heads.  However,
> fast-forward of head in combination with a real merge is
> handled as before.

I intend to also submit a patch that does fast forward in combination
with a real merge.  This means that some case can be reduced down to
only two real parents and we can select a  twohead strategy instead of
an octopus strategy.  In cases where we have at least three real
parents there is no point in doing this.  We only need to specify the
fast forwarded head right after head to allow git-merge-octopus to do
its best.

I need some advise how to implement fast-forward in combination with a
real merge.  I know how to do this with an update of the directory
tree and the index with the fast forward before the real merge is
done.  But, how canweI do this without updating the directory tree
with the fast forward?  Or is it OK to always update the directory
with the intermediate state we get from the fast forward?

> --
> Sverre Hvammen Johansen
>



-- 
Sverre Hvammen Johansen
