From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: static variables
Date: Tue, 10 Dec 2013 17:53:14 -0800
Message-ID: <20131211015314.GJ2311@google.com>
References: <CAHOQ7J-rO-KjHyYk1Gw6Wv+iH_M7DPr76t3G7YN_sUv3YqcJcg@mail.gmail.com>
 <20131211014501.GI2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 02:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYzK-0001Ib-1L
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab3LKBxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:53:18 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:59081 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3LKBxR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:53:17 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so4532232yha.11
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B9a624010dfx12oZ9pGtMUh0gXzcvszGkqIsRqMbYz4=;
        b=eCkr5clKebXpFPNDCCcpvvSKHRQ9C70feeA4i3jV3g10ES2WRW07GyB5wFDGuSeEOT
         PAjKIXsvn0DVDrcIYdu7N0oJfjRG/IODiGZQ2rRXUqH0e7H4NyE7a1RjV+5aQaB8/+F+
         NPDYvpu6s2UAhW08xmja3ewAarxtoFVi1vxLnNpM41Tkvs5Kj4U9bj3Vvjk/WlrdczfK
         Zyp9ZEtzYtwRO9v8w5s5OrSumnzSlmN1pRIEcS5TxqPmEVEVgDbE0o9WshOOa9ju8Yb3
         DXz/Z/mLScgY4+HFNI1PvhefMWbmvOFsY+0hGLTSYO4CnSoR5mLA74NaF+jJ3T91V034
         QrLg==
X-Received: by 10.236.115.73 with SMTP id d49mr22454160yhh.12.1386726797271;
        Tue, 10 Dec 2013 17:53:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm25678885yhq.15.2013.12.10.17.53.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 17:53:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131211014501.GI2311@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239167>

Jonathan Nieder wrote:
> Stefan Zager wrote:

>> This is probably a naive question, but: there are quite a lot of static
>> variables in the git code where it's really unnecessary.  Is that just a
>> historical artifact, or is there some reason to prefer them?
>
> Sometimes it's for convenience.

See for example path.c::git_path and mkpath.

Threaded code uses a specialized thread-safe dialect of the usual C
used in git.  I wish I had better news to offer.
