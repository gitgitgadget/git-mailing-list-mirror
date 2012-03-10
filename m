From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/1] fixup! fast-import: allow 'ls' and filecopy to read the
 root
Date: Sat, 10 Mar 2012 03:18:12 -0600
Message-ID: <20120310091812.GG1992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120310085354.GE1992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 10:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6IRT-0000Tt-ND
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 10:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab2CJJSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 04:18:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33398 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab2CJJSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 04:18:16 -0500
Received: by iagz16 with SMTP id z16so3564717iag.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ptzb+wyFRayq98ADlzlZklZP/fvmM65vMon9tROHy64=;
        b=R/uiBc9bMp7BEdF0hMLKt5tZlcHmeDxf45cYGMrY37rgSe3bpQva1roFGULNRLvlT9
         LsGVuGNgetC+5xvGX85HdS7iG6C0sgWQCJi0eHMqy2w/DViTUSzxOAFQqFuu1+d4ZFOk
         bXKsL1fekdmAuYZz9oTg5b3H3d77pZzlj9ZmYX8ZQN0INZTj08u8BcNXlWps1nHmREqs
         PikDOlSevHvzskiwLV0AqOJpz6O2R9mHViFBoYzMtLDmj6abpj0n+fsSUSayiiF2EDE9
         Kom/zgauiz5XcRiTK2I40mOJtEvx2WCRSvTvwr28uGmCEgwSaN0Dll0KMS/CLCRUiJGd
         xGFQ==
Received: by 10.50.149.131 with SMTP id ua3mr8077974igb.41.1331371096300;
        Sat, 10 Mar 2012 01:18:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id rd7sm1457826igb.14.2012.03.10.01.18.15
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 01:18:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310085354.GE1992@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192776>

Jonathan Nieder wrote:

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2369,6 +2382,7 @@ static void file_change_cr(struct branch *b, int rename)
>  			leaf.tree);
>  		return;
>  	}
> +
>  	tree_content_set(&b->branch_tree, d,
>  		leaf.versions[1].sha1,
>  		leaf.versions[1].mode,

Maybe next time I will send the patch to myself and bounce it to the
list.  Sorry for the noise.

diff --git i/fast-import.c w/fast-import.c
index 51cdda29..013cbd5e 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -2384,7 +2384,6 @@ static void file_change_cr(struct branch *b, int rename)
 			leaf.tree);
 		return;
 	}
-
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
