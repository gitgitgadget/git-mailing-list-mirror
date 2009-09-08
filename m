From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Improving merge failure message
Date: Tue, 08 Sep 2009 19:12:37 +0900
Message-ID: <20090908191237.6117@nanako3.lavabit.com>
References: <20090908153101.6117@nanako3.lavabit.com>
	<7vbplmhr0i.fsf@alter.siamese.dyndns.org>
	<7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 12:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkxhQ-0004GI-LW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 12:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZIHKMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 06:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbZIHKMx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 06:12:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:38652 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbZIHKMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 06:12:53 -0400
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 946EE11B7C0;
	Tue,  8 Sep 2009 05:12:55 -0500 (CDT)
Received: from 8426.lavabit.com (60.12.190.58)
	by lavabit.com with ESMTP id K8AZIVPUXTO6; Tue, 08 Sep 2009 05:12:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=bVjd8QE5Cl6IjQz2zGsbIeI59J6U/EJtU8cceVlGni4/grHBzokl4uZtzicYzu+qJLdo/X9c9nnbw8LtRtm2Hkz2uyxr2eDsxrx2eYGsxrdh99OHSlBsFI+pXxpz3uJweD2HpUwtOvc9qi7cEFFr1UhbcACx6aUYS8YGek0OOyY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127998>

Quoting Junio C Hamano <gitster@pobox.com>

> Notable points are:
>
>  - End the messages with "Aborting."; they are given when the three-way
>    merge stops without harming the work tree;
>
>  - Do not give the extra message after unpack_trees() already errored out.
>    This "merging of trees failed" message was primarily for debugging
>    merge-recursive itself, and the end user cannot do much with the object
>    names given in the message anyway.
>
>    But do give it under higher verbosity level, or when it happens during
>    the inner merge (the "recursive" one), as unpack_trees() should not
>    fail for the inner merge under normal conditions.
>
> We could later add instructions on how to recover (i.e. "stash changes
> away or commit on a side branch and retry") instead of the silent
> exit(128) I have down there, and then use Peff's advice.* mechanism to
> squelch it (e.g. "advice.mergeindirtytree"), but they are separate topics.

Thank you for a quick response. The patch works fine here, so if you want
please add:

Tested-by: Nanako Shiraishi <nanako3@lavabit.com>

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
