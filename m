From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 02:45:46 -0700
Message-ID: <5D2201A1-A945-4189-89BD-4B379EEEF045@gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1374057.qfvOg1c6C6@flobuntu> <23122876.7xH9dZiP4M@flobuntu> <20120702110741.GA3527@burratino>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:45:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuKdq-0007xp-7z
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 11:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab2GZJpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 05:45:53 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56825 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab2GZJpw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 05:45:52 -0400
Received: by gglu4 with SMTP id u4so1718968ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 02:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=inUHbB2lCkmcC2xgtAjOUDpqQjPpYBNfqosE+9HWRbs=;
        b=bqVhAjok0Rgya0/PWb81wjbXeYK0JO7LS4gGDxkev2sMK1WNTvvnbZRCuzZcferwQ5
         lPgb2Eff+uolrWhYRRD30CeDJcuJ9e6pTnYoED6V8M5kL7Tugln7QoJX/Et4+pCKAFgN
         jYiZdQv+eHuWYssR6dTOtRi8mihfI2UjWhcIy37QhFogDLCjdj8CzTcfTAQk36Az9R6Y
         MM5xdH8Q23GwBh2yZGVM/WUjDW/9+D3PQnmcVuK7OaC34XJ0idpbfFtFPgDXBbn/dOCm
         s92K1hDuazRU3AKceuio/MwmxGvyhWaY+mb0akBcAYqYO9wSJ4hh79kKh1Z4gs1+BwSr
         SkTQ==
Received: by 10.68.223.129 with SMTP id qu1mr3374439pbc.165.1343295951509;
        Thu, 26 Jul 2012 02:45:51 -0700 (PDT)
Received: from [192.168.1.125] (c-67-161-24-30.hsd1.ca.comcast.net. [67.161.24.30])
        by mx.google.com with ESMTPS id rd7sm16222642pbc.70.2012.07.26.02.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 02:45:50 -0700 (PDT)
In-Reply-To: <20120702110741.GA3527@burratino>
X-Mailer: Apple Mail (2.1485)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202253>


On Jul 2, 2012, at 4:07 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> [...]
>> diff: Use fifo instead of pipe: Retrieve the name of the pipe from env and open it
>> for svndump.
> 
> I'd prefer to avoid this if possible, since it means having to decide
> where the pipe goes on the filesystem.  Can you summarize the
> discussion in the commit message so future readers understand why
> we're doing it?

Crazy thought here but would a socket not be a bad choice here?

Imagine being able to ssh tunnel into the SVN server and run the helper with filesystem access to the SVN repo.

Akin to the pushy project use case.
http://packages.python.org/pushy/

SSH into the machine, copy the required components to the machine, and use the RPC.
Nothing needed but SSH and python.  In this case SSH, SVN, and the helper would be needed.

This also would work just fine with the local host too.

Steve

Note: Resent, Sorry it was signed, and rejected before.