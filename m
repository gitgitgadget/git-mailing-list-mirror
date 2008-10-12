From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode
 == true
Date: Sun, 12 Oct 2008 16:23:18 -0400
Message-ID: <48F25CB6.10702@gmail.com>
References: <20081012133934.GB21650@dpotapov.dyndns.org> <1223837086-2864-1-git-send-email-mlevedahl@gmail.com> <7vskr1fvys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 22:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp7U1-00034I-NH
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 22:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYJLUW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbYJLUW5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 16:22:57 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:50860 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbYJLUW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 16:22:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so113481and.103
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=p9yT4rCVOVfRDWrdrjPO9dlhCxkLmGwwuwAQ1nW1X8Q=;
        b=xSsn4oNpGVJyaAFa08oaBfy1lnC+mjIHQ1lpUglhMgvVl4u5UXk2B2v9VteR7sUmEK
         0gezV8pFvCb1/rfn3ebFKMY04yZkDNz1CsIzsdie/iFUXitv/nPLnlct7O0ye/Xu6yiT
         NlXi1Zt0FzBFD410B8qso5WT96c1mIOdOg8pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NBrCb0zUIrydDdDdiShtAMUk7QAIbCsqemmYhV0S7j1a6nFtcXFqG3SvZeEmUruyUw
         tsDma/jF8tUzAlx9Mi6u0b3e1vhQqjgVvA2seJZl+lOCLk8DqeYjQA+xV8JbVstB9HQl
         eIdYA7ixc2CIIWHxVXuZNmHmj/jqkPfYADvcQ=
Received: by 10.100.198.13 with SMTP id v13mr4861388anf.123.1223842975380;
        Sun, 12 Oct 2008 13:22:55 -0700 (PDT)
Received: from ?192.168.1.117? (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id b12sm12914200ana.14.2008.10.12.13.22.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 13:22:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <7vskr1fvys.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98051>

Junio C Hamano wrote:
> Before you do that, can you explain why git_cygwin_config() should
> duplicate the setting of that variable instead of using the existing
> parser for that variable by calling git_default_config()?
>
>   

I don't like traversing the same list of configuration variables / files 
twice, each time looking for a different variable just so that one of 
those traversals can use a standard function, rather than just 
traversing once and getting exactly what this routine needs; this seems 
wasteful to me. However, I am (obviously) not the maintainer of this 
code so I will do this however it is desired.

Mark
