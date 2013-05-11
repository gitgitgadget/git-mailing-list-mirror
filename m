From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X
 10.8
Date: Fri, 10 May 2013 23:23:36 -0700
Message-ID: <20130511062336.GD3394@elie>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 08:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3Dq-00077d-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab3EKGXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 02:23:42 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:47455 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3EKGXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 02:23:41 -0400
Received: by mail-ea0-f173.google.com with SMTP id d10so2652586eaj.32
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P02j/Ibq+a3cN0fI5xqV/NccgpG+E5P9L8hoo8nM2Cg=;
        b=Y0tpE9NDH721O3ywsKyLqcgBOTaptONFDJg5Ag10GEsWF9aQ9wnUMS61ybbCxArqhK
         6XIkJHs6PGdYLUJZMHP9swYN0lvl2w+1bVQxUF2Okf+zJLhA8PrklzJD5SoNw88t2d0j
         x1AdEQ3L/0b6i/GD0ilyBEzUijcDqdM6rkO1GsRAIc0rvn+no7dk+2Hezqk77OxPM3/v
         7PNkkjj70mUZeRU1Gn3hD2rZq6hzm+2l3SSrwK27wbl1VWfVqVMrnAcTciitmi+ELS+p
         mfs2ZHEV1Log1lst1Kd1GOL4MmyN5bdgFDMXYFNQpfLmniHB1pJI5SQCYZMSCISeXYjF
         wg2g==
X-Received: by 10.14.221.67 with SMTP id q43mr3613284eep.1.1368253420065;
        Fri, 10 May 2013 23:23:40 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id e50sm7936803eev.13.2013.05.10.23.23.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 23:23:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368240282-89581-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223932>

Hi,

David Aguilar wrote:

> Mac OS X Mountain Lion prints warnings when building git:
>
> 	warning: 'SHA1_Init' is deprecated
> 	(declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the Common Digest SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().

Thanks.

Does this perform better or worse than just setting
BLK_SHA1=YesPlease?  I'd naively think it could go either way: on one
hand adding another library dependency can slow down startup, and on
the other hand the implementation may or may not be optimized better
than the generic block-sha1/ implementation.

Curious,
Jonathan
