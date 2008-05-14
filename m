From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 4/4] filter-branch: fix variable export logic
Date: Wed, 14 May 2008 11:33:50 +0200
Message-ID: <482AB1FE.6030009@gnu.org>
References: <20080513084338.GA23729@sigill.intra.peff.net> <20080513084638.GD23799@sigill.intra.peff.net> <7v7idxr00i.fsf@gitster.siamese.dyndns.org> <20080514045717.GA16592@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 14 11:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwDNj-0003w9-0y
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 11:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbYENJdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 05:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYENJdx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 05:33:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:45792 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYENJdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 05:33:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2472259fgg.17
        for <git@vger.kernel.org>; Wed, 14 May 2008 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=go8KBNRYllImqgXySqjRqxgjhUczcBgWtcIaOEzL8VU=;
        b=nLypOZqMrMiE6YKFISrLIerV2jo7SLxFme6RPoZC95p+mcUm+leImUK3J1J01kUrmnkcEGOhvyVD9yV91CtvDfBszWOgqe/TDbUNwkrchYJlfRTX6+t7KyGj343akclkpvo/l3uDS9q4wWQDG8zFoMt1wfKxC1SiB5QAh2d5ol8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=wpHupoUFwEOKTfdN+kIgWf2a+4pN/AvCqeJzuNzE0GCFmE8zQF1e5INL546JoHYrFPZSGquDgabARCu7xJkDOmy32gIfj1zlWEi5xohNZTVFX6QZ1xiZIVFCPa8dawbb4ctAMr+qHESelZCuPYQwZx4jqPY2REclUkIY+9QVquE=
Received: by 10.86.60.14 with SMTP id i14mr1420832fga.75.1210757631664;
        Wed, 14 May 2008 02:33:51 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id e11sm951892fga.1.2008.05.14.02.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 02:33:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080514045717.GA16592@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82090>


>   if test -n "$ORIG_GIT_DIR"
>   then
>     ...
>   fi
> 
> would be even clearer, though I'm not sure if "-n" has any portability
> concerns.

It has not.  Some autoconf scripts do

   if test "x$ORIG_GIT_DIR" != x; then
     ...
   fi

(and similarly for -z) but that's being phased out.

Paolo
