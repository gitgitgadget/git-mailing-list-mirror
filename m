From: Uri Okrent <uokrent@gmail.com>
Subject: Re: git push --confirm ?
Date: Sun, 13 Sep 2009 09:59:01 -0700
Message-ID: <4AAD24D5.1010504@gmail.com>
References: <1252777897.2974.24.camel@localhost.localdomain> <20090912184342.GB20561@coredump.intra.peff.net> <7vvdjn8ymk.fsf@alter.siamese.dyndns.org> <20090913093324.GB14438@coredump.intra.peff.net> <7vljkjuo43.fsf@alter.siamese.dyndns.org> <20090913105247.GA21750@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 18:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmsPy-0002mp-C4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 18:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZIMQ7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZIMQ7D
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 12:59:03 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:51097 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbZIMQ7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 12:59:01 -0400
Received: by ywh4 with SMTP id 4so3331252ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BnSNC4/OIlgYqbfyqz9lNQBGDHjzzuA77pRUWZesPqM=;
        b=rGsra+nRqfLmVstMg3ail8YSs7Oo9cYWY8xZ7vn7hZa0sh8+wj2miqk8EXB+I/KJZX
         7l527N4uCYjUNo4bsHQJ8PC0CSE3YNreWtq63MS0LHnpcFscwVqOVbVylGOJzPTPzcmI
         GKaAUEPu9rekO6q/UtrTcuYwl/m5QwoHh0qhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kF180nOyL9dNEcmElLEBdw6s8+d8lengm/tc1t3wa3vU+A49wuTSJvZbqC1UYuknJx
         WXolqxJAW5vo1g/DtJUcZVwZuKaZ5V1XInDHJ9AgY1JhJ5yAF3x1n7KSnrABtS3IFGh7
         zL+lMC+dBsXLKYpI1KuLZ3wicQcCrr71pN2jI=
Received: by 10.91.143.18 with SMTP id v18mr3247624agn.71.1252861144117;
        Sun, 13 Sep 2009 09:59:04 -0700 (PDT)
Received: from ?192.168.0.4? (cpe-76-90-28-9.socal.res.rr.com [76.90.28.9])
        by mx.google.com with ESMTPS id 39sm7422505agb.23.2009.09.13.09.59.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 09:59:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090913105247.GA21750@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128372>

Jeff King wrote:
[snip]
> Besides being a lot more annoying to implement, there is one big
> downside: in many cases the single TCP connection is a _feature_. If you
> are pushing via ssh and providing a password manually, it is a
> significant usability regression to have to input it twice.
> 
> Also, given that ssh is going to be by far the biggest transport for
> pushing via the git protocol, I suspect any timeouts are set for
> _before_ the authentication phase (i.e., SSH times you out if you don't
> actually log in). So in that sense it may not be worth worrying about
> how long we take during the push itself.

That doesn't seem like a huge hurdle to overcome. Most ssh clients support some
sort of ServerAliveInterval parameter for just this reason. Sending a keep alive
packet every 60 seconds or so while waiting for user confirmation doesn't seem
all that egregious.
-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
