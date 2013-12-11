From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 17:01:45 -0800
Message-ID: <20131211010145.GG2311@google.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
 <20131209204815.GV29959@google.com>
 <20131210084622.GC4087@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 02:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYCa-0005LO-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab3LKBC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:02:56 -0500
Received: from mail-qe0-f43.google.com ([209.85.128.43]:62190 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3LKBCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:02:55 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so4737765qeb.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kbUZQHUiFxHRpfXCIhgWCj8MWkT9I18VGl1+6fbWj20=;
        b=c/++zGcYX679OQ/ASwGOTItbDUshD2L/lqRyj7gYI2JTX80pM4Fmk/xlf2NACF1Z4g
         MBMYHRaNoLPlwg6CTEzdXrso/W/DrRfT02mTei5ZixBz0W16UkTQdyMf3MOIMeL1Xlt5
         sevOrbsDtjfWbNKSj42HOsLYg9ViIkGAXjkey0o/tmRNPO8iafcmQ6MsbepOtBW5XNXb
         U42xiM6w6gAGxQVmMB6fmSMBV8fvqyzGftMGug5KlV5FBgcsqva/jcSTE0xs0c5EkC1w
         P77yI2P+R2SYkhdkjtQPUuU/ZsiQE9YUGONu4qKfz663LoKHUiUbLhSQ6fHIGDTliEys
         sLVg==
X-Received: by 10.49.130.135 with SMTP id oe7mr199419334qeb.41.1386723774136;
        Tue, 10 Dec 2013 17:02:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r5sm52633436qaj.13.2013.12.10.17.01.53
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 17:02:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131210084622.GC4087@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239161>

Dominik Vogt wrote:

>                         How does git-new-workdir cope with
> rebasing (e.g. you have the same branch checked out in two working
> trees and "rebase -i" it in one of them)?

Generally you don't have the same branch checked out in two working
trees.  I tend to use "git checkout --detach" to not have *any*
branch checked out in most working trees, though that comes with its
own set of problems since the HEAD reflog is not shared.

>                                            Is it really a working
> option?

Yes, modulo the two warnings above. ;-)

If someone has time to work on it, the threads

 http://thread.gmane.org/gmane.comp.version-control.git/150559
 http://thread.gmane.org/gmane.comp.version-control.git/182821

describe one way to make those caveats go away.

Thanks,
Jonathan
