From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Mon, 09 May 2016 16:12:38 -0400
Organization: Twitter
Message-ID: <1462824758.24478.37.camel@twopensource.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 22:12:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azrXr-0005rz-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcEIUMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:12:42 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36210 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcEIUMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:12:41 -0400
Received: by mail-qk0-f171.google.com with SMTP id x7so101341805qkd.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=b8goEY2nVQOYiDOaGzkxkMWuE0ugR+7wCzMQ5geaAas=;
        b=QrXNi8mMWyipUUVRPGhOw3oSoJsYEsQiXPrxoktUbGsh2aJxxfWwZVo6gL8pW1T79m
         xQxqqWzhIXpnj3XoWfyu6B+vWsrIbAJrWzNWhpD1qBmPsJQCjW2atjk3wOSfa0xATJ6C
         WHqPnpGSbjPbU8+qfbotnIe8tTU2AzzFk+AHdrH2ve5RVJ6WDiJ53CGJ0qQ7WB73s8Sm
         cPLMFDwWIj2Ul4LgAI42lH/XRlkLttpIWIRE0n80cfEHuxu3cbbaMr+7QRqAhPaJVElq
         V4Kqv3YkHjosRXhHFNl9LPiHSV1LVptPAG8BE2i2g/3dp3XNn/ES5i4sQ76un8VAR9uC
         QwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=b8goEY2nVQOYiDOaGzkxkMWuE0ugR+7wCzMQ5geaAas=;
        b=SxFpsnQc06YUTKn8UiTjj7HZXrQAYr4HuS3zZMTNAdatPK8N+TDAeYQAT4uCFWZZfZ
         Ak+Gob1fZJ5sW8KCHN6vw4KprodGZTH/4xGo1Nb5E9jZrWkvigzYNbsXquV4RkltQKST
         ruYh/YH6N2hlQ6VTO64OsbtgygtEXAKgHbxHGGzQmBOz0gdJ5syq/YWdzwxnt+cIigWj
         DGhkbEuzBzHsUFbIgl9X8OQLf+nYC7syEkR7PYWYzrvAQhCyqjSzrx1T0ee8mCmTpB/q
         uhw0G6Y6k1BSS3kvnBlgbY94zsTSc7V9WSwaqf2r9m/YTWLQkRnRIKJjQ21qJtxKCWYf
         Lz+A==
X-Gm-Message-State: AOPr4FUTk9Gg9Yl5HqrwXkwrW0DN7aKNFuW+j8udFNDi1IqZPdXNCe+n06cvNIUvkYByag==
X-Received: by 10.55.209.134 with SMTP id o6mr15276447qkl.153.1462824760046;
        Mon, 09 May 2016 13:12:40 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id j88sm12528237qgf.7.2016.05.09.13.12.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:12:38 -0700 (PDT)
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294046>

On Fri, 2016-05-06 at 18:13 +0200, Michael Haggerty wrote:
> Thanks to David, Junio, and Peff for their comments on v1 of this
> patch series [1]. I think I have addressed all of the points that
> were
> brought up. Plus I fixed a pre-existing bug that I noticed myself
> while adding some more tests; see the first bullet point below for
> more information.
> 
> Changes between v1 and v2:
> 
> * Prefixed the patch series with three new patches that demonstrate
>   and fix some bugs in reference resolution that I noticed while
>   inspecting this series:
> 
>   * "t1404: demonstrate a bug resolving references" -- this
>     demonstrates a bug that has existed since at least 2.5.0.
>   * "read_raw_ref(): don't get confused by an empty directory"
>   * "commit_ref(): if there is an empty dir in the way, delete it"

I generally like to put the bug fixes before the tests for those fixes
(so that bisect on the complete suite works).  But maybe the git policy
is different.

Other than that, these changes look good to me.
