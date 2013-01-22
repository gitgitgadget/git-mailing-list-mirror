From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 02/10] t/test-lib-functions.sh: allow to specify the
 tag name to test_commit
Date: Tue, 22 Jan 2013 00:02:16 -0800
Message-ID: <20130122080216.GC6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:02:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYof-00019K-1w
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab3AVICX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:02:23 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42019 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab3AVICW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:02:22 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so3880958pad.22
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YaBJhr24XLGGXs9XDyHdYsSA9xh7u1m3FKS05Zg+DGM=;
        b=hO1mfOA+YJb5PbHiquSXFCUIALrVGlN7m+O9c7I4DGVQLA/cp0+B4pRROonEQe3OWh
         kKCyirHatO06ZRkii1Jn6p0cAKmFZLLBK/DvpM5zbgGXn6lXNd8kh+Divnexr/nQKJIT
         TPzOrkEVoxOKcUYL3nxkrQK4qZQFSLXueeCYaLqEAhcdJpeXwRy02xpaBeXPCr46wbhR
         cJMLJCy5iXDVZLyhkTYkpSxdDPVlKa1KYa88vZ93AMZU6zuhSVq9qOOw4McLeMBx5oho
         iBM5kfswpx265WsVdpnw26qUsWsqeKsJevHyYZvIX9Cb0dUrLtxDAjh+lvQKFMsa8g09
         DKxA==
X-Received: by 10.68.252.69 with SMTP id zq5mr37089035pbc.104.1358841741924;
        Tue, 22 Jan 2013 00:02:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ov4sm10287625pbb.45.2013.01.22.00.02.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:02:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-3-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214212>

Brandon Casey wrote:

> The <message> part of test_commit() may not be appropriate for a tag name.
> So let's allow test_commit to accept a fourth argument to specify the tag
> name.

Yes!

[...]
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -135,12 +135,13 @@ test_pause () {
>  	fi
>  }
>  
> -# Call test_commit with the arguments "<message> [<file> [<contents>]]"
> +# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
>  #
>  # This will commit a file with the given contents and the given commit
> -# message.  It will also add a tag with <message> as name.
> +# message.  It will also add a tag with <message> as name unless <tag> is
> +# given.
>  #
> -# Both <file> and <contents> default to <message>.
> +# <file>, <contents>, and <tag> all default to <message>.

Simpler:

 # This will commit a file with the given contents and the given commit
 # message and tag the resulting commit with the given tag name.
 #
 # <file>, <contents>, and <tag> all default to <message>.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
