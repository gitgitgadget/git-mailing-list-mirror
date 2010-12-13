From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: [PATCH/RFC] ident: die on bogus date format
Date: Mon, 13 Dec 2010 19:00:45 +0100
Message-ID: <4D065F4D.1090807@gmail.com>
References: <loom.20101213T161633-993@post.gmane.org> <20101213170225.GA16033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:00:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSChJ-0003OF-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab0LMSAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 13:00:24 -0500
Received: from mail-wy0-f194.google.com ([74.125.82.194]:36966 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757293Ab0LMSAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 13:00:23 -0500
Received: by wyf23 with SMTP id 23so2076566wyf.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HK/Nigffnr5JJSDu5RTctBifztiDWSEXjfeZ2DMn6BQ=;
        b=Y+Es/+0k+TK4Ibg3ue5gkLb8GUxZgoFv0BOQeMZ2h9t2zBYEhM4pz6/UY4RW6S6K6h
         /qFU7HrXhxgWaXair/4F69bShK5+ZuCgPSWRF4+nk4qiU+SHLqnArOTRAQdCtRiVr6iT
         v2osFr4UDrVQtZ5Wof8llSNT/SP04io8T57I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Nrl8ME14yRFUfeM0673nCTjvuSLTFrK0rUmLPCOY5gn6PS50EXb+ON9a7O2nh1E4EY
         cl+bTEkkC/+lCQYS0jmsXOGFxuCIycnTPvA/nd0fBM9L4GnahUat32Z2SNZ07rF0lsb8
         s1FExa1tbdDZSOzDI42SJf7MnzCJPzs4Fk/uU=
Received: by 10.216.141.37 with SMTP id f37mr873938wej.31.1292263222405;
        Mon, 13 Dec 2010 10:00:22 -0800 (PST)
Received: from [137.204.107.60] (i2-ve060.ingce.unibo.it [137.204.107.60])
        by mx.google.com with ESMTPS id o33sm2334804wej.37.2010.12.13.10.00.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 10:00:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20101213170225.GA16033@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163570>

Thanks for looking (and coding) into it!

For my usage case, a warning would be ok too. If the commit generates a warning,
one can notice the warning and --amend the commit.

One can perhaps have the warning now and maybe an
error from version 1.8, so: (i) we are sure that the different behavior does not 
break anything and
(ii) there is time to move the fmt_ident up in the code so that it is invoked 
earlier
(to avoid the burden of writing the commit message and then seeing the commit 
aborted).

By the way, note that I got into the issue by trying to use --date forgetting 
the time.
Don't know if it could make sense to accept the date with some default time in 
this case.

Regards

Sergio
