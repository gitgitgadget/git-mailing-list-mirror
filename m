From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/5] dir.c: rename to name_compare()
Date: Wed, 18 Jun 2014 12:09:56 -0700
Message-ID: <20140618190956.GU8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-5-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:10:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLFK-0001FF-G3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbaFRTKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:10:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46082 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbaFRTKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:10:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so1041025pac.33
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y/xoTrYK+UMINsrYpe2jAo4Lx7fd/iBjgahk3LD4ny8=;
        b=eISPfJUrfgAcL0suEqyZ1eORe2MYmhev/gdsXNJM9Mp2Jt/x9zhT6DMv/1B4XIMZBe
         CjE79vMolpl0BNS4Nu50oDha0QZ9hZzUl+FM3mZ6BJGXz8GY4MNhztqrf2LrtWjatQcN
         G0Jb1GbJrF2rw7iKPz5FCdFRxPBsHkn8wvvvGMjBge0AFFlUZ7Maj7ASolKMKefozl2T
         idTdWXaV+fcS++fLMNYqSwDZ5vHas5vEExk7REhwok6TMn1Ahjpr12Bwta9FdbYZbouV
         pI1VHVkRN4Dz+kL2qj8qlR2tsC9Cla78331QS7qHDdQLuBtAobOp8iFFj5BUg9dBztGg
         /pMQ==
X-Received: by 10.68.203.132 with SMTP id kq4mr188069pbc.12.1403118599369;
        Wed, 18 Jun 2014 12:09:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wn7sm14511103pab.18.2014.06.18.12.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:09:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-5-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252028>

Jeremiah Mahler wrote:

>     This is a case where cache_name_compare() was used even though it had
>     nothing to do with a cache.  The new name makes it clear that no cache
>     is involved.

That's a perfect sort of thing to put in the commit message. ;-)

Unlike patches 2 and 3, this could make sense to me as a separate
patch from 1/5.  Except... how does git work at all with patch 1 and
without this patch?  I thought that patch removed the public
cache_name_compare function.

Would it make sense to delay the removal of cache_name_compare until a
patch at the end of the series?

The patch is small enough that squashing into patch 1 seems fine, too.

[...]
> Rename the call to cache_name_compare() to name_compare().

It's not actually renaming but calling a different function, right?
So I'd say something like

	read_directory: use name_compare instead of cache_name_compare

	This is a case where cache_name_compare() was used even though it had
	nothing to do with a cache.  The new name makes it clear that no cache
	is involved.

	No functional change intended.

Thanks,
Jonathan
