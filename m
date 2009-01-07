From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 7 Jan 2009 15:24:02 +0100
Message-ID: <36ca99e90901070624p2c102f3ey392ef813db9f9187@mail.gmail.com>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru>
	 <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru>
	 <20090106203203.GA11274@lapse.rw.madduck.net>
	 <20090107112754.GA15158@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "martin f krafft" <madduck@madduck.net>, git@vger.kernel.org,
	pasky@suse.cz
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Jan 07 15:25:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZLi-0006Ty-1H
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 15:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbZAGOYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 09:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZAGOYH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 09:24:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:42382 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbZAGOYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 09:24:04 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3014442fgg.17
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zUEpmYFjHTw9s8GQ5c3c/pLfOyoBRnZ49qUFrdPyCfQ=;
        b=IlWpczGkEH8iSSN6m++p/wOaX93JEt4pAc7lkC5ojwOPYd/wwqs5/62+PoW7xW01a+
         9bEjdBF/dQQhD3i/+peDNE4XiHnw6iat4oYsd/twaDNDBgJFq5awyI3TG3x0vLj1+N6J
         Gy+XE3xzapz7UjF3tjIB2oIpCKgrgUAGJrO0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XrTL55S2hsVwjK5Mqtt0zrW+rjx2YUC1hVdTuF3IV5JQzIPen6k2NHQydYyQHOnOcJ
         HyJ+gnflakF+FAKfWy0iLYyD5vwo4MknyjpELv+VgWPKDJSiszk+5t10JFzqS5kqIyDN
         a8bIlfPyc7OLBOVOODFUrq6QJ1qYWs2r6ZB1I=
Received: by 10.86.91.12 with SMTP id o12mr13565017fgb.16.1231338242543;
        Wed, 07 Jan 2009 06:24:02 -0800 (PST)
Received: by 10.86.3.2 with HTTP; Wed, 7 Jan 2009 06:24:02 -0800 (PST)
In-Reply-To: <20090107112754.GA15158@roro3>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104797>

On Wed, Jan 7, 2009 at 12:27, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> Martin, thanks for your review.
> +       # atexit(close(1); wait pager)
> +       trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
I think you need to escape the double quotes.

Bert
