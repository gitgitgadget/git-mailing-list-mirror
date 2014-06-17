From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] add strnncmp() function
Date: Tue, 17 Jun 2014 10:48:17 -0700
Message-ID: <20140617174817.GQ8557@google.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <53A02195.8080202@web.de>
 <20140617154953.GC5162@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 19:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwxUy-0007Rs-8V
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbaFQRsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:48:21 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54842 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaFQRsU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:48:20 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so5932902pab.36
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KGmIyrN0spB1Fjx1tbh4Rkya2k9LYOP6gQ5FRZ2gAZg=;
        b=lM6DnJu1GXn1l6KmS/HZc1+CjfYoViDk2zy2+24Z3f1FGm2WLaywVRzLd5LUOUp+F4
         0Cyd/blQ5tc3Y4A9SYnT/XpAD50lQwtf5UqwvTuritDM/Jidr71aJrymBPmMFQDmUEOW
         nNL7O3Tjx/CElK/rAA7kBsTKJbC5SDmT59OQzODVQdqmlmG6PkkDvZhtSTAjmbWzGpir
         7mvF+bKPf12lQ4lNUIOMEDzhFgoGAGeucBc4Z50SWRPGSn2vsUCHwHFYExRH7g6BeMa7
         UgcGAT2id3eCa/pJ33FAfGiBfHNLX99szum6RaR09VHiwf/vF62vkVmTwRxrxYxVx+vQ
         SQuA==
X-Received: by 10.66.65.225 with SMTP id a1mr34793141pat.139.1403027300298;
        Tue, 17 Jun 2014 10:48:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ja8sm25057894pbd.3.2014.06.17.10.48.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 10:48:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140617154953.GC5162@hudson.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251929>

>> On 2014-06-17 09.34, Jeremiah Mahler wrote:

>>> Also, strnncmp() was switched from using memcmp() to strncmp()
>>> internally to make it clear that this is meant for strings, not
>>> general buffers.

Why shouldn't I want to use this helper on arbitrary data?  One of the
advantages of other helpers in git that take a pointer and a length
(e.g., the strbuf library) are that they are 8-bit clean and can work
on binary data when it's useful.

Thanks,
Jonathan
