From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Wed, 10 Mar 2010 02:07:08 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1003100205170.17698@chino.kir.corp.google.com>
References: <4B90CBE5.9090102@viscovery.net> <1267780845-10547-1-git-send-email-jslaby@suse.cz> <m3pr3jkq26.fsf@localhost.localdomain> <4B9120F2.2020000@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jirislaby@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Mar 10 11:07:36 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NpIpD-0003Ut-PO
	for glk-linux-kernel-3@lo.gmane.org; Wed, 10 Mar 2010 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab0CJKHU (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 10 Mar 2010 05:07:20 -0500
Received: from smtp-out.google.com ([216.239.33.17]:58239 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0CJKHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2010 05:07:18 -0500
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id o2AA7E8f021442;
	Wed, 10 Mar 2010 10:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1268215635; bh=g0xN7ccCJX3Rb+gY99KQfINZeJ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	b=DUcj12ZXk48r+kCEASsaduP5GEXtYzOUxAft7J9YuEOKQc21pkKlBElJZipaYIkYA
	 Zep7NsiFq0KW3e+BizZkg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:
	references:user-agent:mime-version:content-type:x-system-of-record;
	b=srSYvXLMUF3jlvB+j5vBW+zjjd+uazQUxZA65K9Sveb1WS7k9qaWJbweJCfWREcVZ
	Zc2D9JaoooA1JMl8ai1WA==
Received: from pxi31 (pxi31.prod.google.com [10.243.27.31])
	by kpbe17.cbf.corp.google.com with ESMTP id o2AA7CJ7026923;
	Wed, 10 Mar 2010 02:07:13 -0800
Received: by pxi31 with SMTP id 31so1190795pxi.3
        for <multiple recipients>; Wed, 10 Mar 2010 02:07:12 -0800 (PST)
Received: by 10.114.8.2 with SMTP id 2mr746686wah.91.1268215632265;
        Wed, 10 Mar 2010 02:07:12 -0800 (PST)
Received: from chino.kir.corp.google.com (chino.kir.corp.google.com [172.31.6.135])
        by mx.google.com with ESMTPS id 20sm1063880pzk.11.2010.03.10.02.07.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 02:07:11 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
In-Reply-To: <4B9120F2.2020000@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-System-Of-Record: true
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2010, Jiri Slaby wrote:

> On 03/05/2010 11:43 AM, Jakub Narebski wrote:
> >> +!/.gitignore
> >> +!/.mailmap
> > 
> > Actually you want to *not ignore* .gitignore and .mailmap (and
> > .gitattributes which is missing here) anywhere, not only as top-level
> > file.  So .gitignore and .mailmap should not be prepended with slash.
> 
> <and moved out of the 'Top-level generic files' section then>
> 

Please either revert 3b2a8c8f3c65 or merge the fixed up patch for 
2.6.34-rc2, otherwise include/linux will continue to be ignored by git 
just like it is for 2.6.34-rc1.
