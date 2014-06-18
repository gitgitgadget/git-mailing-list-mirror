From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/5] cleanup duplicate name_compare() functions
Date: Wed, 18 Jun 2014 12:14:07 -0700
Message-ID: <20140618191407.GX8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLJH-00066G-F6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbaFRTOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:14:11 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:61142 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaFRTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:14:10 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so1046285pbc.20
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qKma1sGzfTraBT3HFqpEsAGimShLBQN5reArxIAy9Eg=;
        b=yc9iRD/gtb7O3xqWA9TY4pktObVbqwOkMgk4Z0XhRmdx+h4glYFAEQu7F8f7TSd0xQ
         i0bwbXazTnx19LfOjbXU+eww1uPIe2FjQXJmkpano2eCkRWsMCpgjTPxCSVFdTwOasdB
         3tXGDZJ5c9v/6awNA2UOjM42wHEpkBr5P2tCP+1AjlsAhXcaunJH1hyQ1q2OwYXOmxMC
         zhGbQPIKsEfmswLVowaccK+i9RZ5u8IxkMSNcxU0NsxlcIlzFZ2RdqHOqIcxkKOjRctn
         fuGFAAKw1vSUB3pE9HTgIh4M/YPpV3ejEy8JpV4wRmBsEmLQAtJihP7u4uhInfZUjEkm
         gftA==
X-Received: by 10.66.132.36 with SMTP id or4mr179458pab.42.1403118849892;
        Wed, 18 Jun 2014 12:14:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qj3sm4709869pbc.91.2014.06.18.12.14.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:14:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252031>

Jeremiah Mahler wrote:

> Jeremiah Mahler (5):
>   cache: rename cache_name_compare() to name_compare()
>   tree-walk.c: remove name_compare() function
>   unpack-trees.c: remove name_compare() function
>   dir.c: rename to name_compare()
>   name-hash.c: rename to name_compare()
>
>  cache.h        |  2 +-
>  dir.c          |  3 +--
>  name-hash.c    |  2 +-
>  read-cache.c   | 23 +++++++++++++----------
>  tree-walk.c    | 10 ----------
>  unpack-trees.c | 11 -----------
>  6 files changed, 16 insertions(+), 35 deletions(-)

After looking at the patches I suspect this should be a single patch.
That way it's bisectable, and the changes outside of read-cache.c are
small enough that it's not too much of a burden to review as a single
patch.

The code change looked good.

Thanks and hope that helps,
Jonathan
