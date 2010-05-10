From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized repositories
Date: Mon, 10 May 2010 21:09:48 +0200
Message-ID: <99999847-7CFD-4F44-94BE-35AAE8CC9835@gmail.com>
References: <20100510171119.GA17875@pvv.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 21:09:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBYMY-00063l-SW
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 21:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab0EJTJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 15:09:53 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:59654 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0EJTJw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 15:09:52 -0400
Received: by ewy20 with SMTP id 20so1083951ewy.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=m9md5xMv6hFg9N2ixkeOe3/mQeiZxjag2GA1BfC9yms=;
        b=iQ6EFf81S3cpWh6kxAHQYc1Jd6QWteHjLgd2YDH3M1RWhWa3eImMWq/t1W5qVMtp88
         bdcv4YlcH9KuQTS/E03RCRKwW2sTgNpYgQ9kTybnaWEEd6izayeUYp05V1riNpZfAKVT
         iUvEsk8gKal9lN9bZcSq8m+XHxHtK6647Q0IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=mryjEqmMlKIA+c0fy6zTsLwbOstjtn3iYVPhQ9MLoTnwYMKLhHOVJxb+9XfxzIF1TD
         64e4qnoJo9OMwOj21KyyQoiZdLWxX7LG1mh9QmYaZnjrQOaHHImL3T0wc55LaHz8q4ZK
         EFDjY/1VcbniN4kU9OQf431sKspMAS9hcolWQ=
Received: by 10.213.57.140 with SMTP id c12mr1822512ebh.3.1273518590347;
        Mon, 10 May 2010 12:09:50 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2662811ewy.9.2010.05.10.12.09.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 12:09:49 -0700 (PDT)
In-Reply-To: <20100510171119.GA17875@pvv.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146846>

On 10. mai 2010, at 19.11, Finn Arne Gangstad wrote:

> Previously, autocrlf would only work well for normalized
> repositories. Any text files that contained CRLF in the repository
> would cause problems, and would be modified when handled with
> core.autocrlf set.
> 
> Change autocrlf to not do any conversions to files that in the
> repository already contain a CR. git with autocrlf set will never
> create such a file, or change a LF only file to contain CRs, so the
> (new) assumption is that if a file contains a CR, it is intentional,
> and autocrlf should not change that.

I'm of two minds about this: on the one hand, it appears to fix autocrlf's biggest problem (that it breaks down when the repository is not normalized), which was the main reason I started working on it in the first place.  On the other hand, it does nothing for the user interface, which was (obviously :) another big motivator.

I'll submit a cleaned-up series with optional extras in a couple of days.
-- 
Eyvind
