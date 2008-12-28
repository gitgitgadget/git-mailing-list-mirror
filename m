From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 09:09:09 +0900
Message-ID: <20081228090909.6117@nanako3.lavabit.com>
References: <200812280024.59096.markus.heidelberg@web.de>
 <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Dec 28 01:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjG1-0006Hi-7X
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYL1AKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 19:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbYL1AKJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:10:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:43172 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163AbYL1AKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 19:10:08 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 97062C7A76;
	Sat, 27 Dec 2008 18:09:59 -0600 (CST)
Received: from 3075.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id YIHPJTP82LMP; Sat, 27 Dec 2008 18:09:59 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=aM5Oretl2i872TCRqwBwmjmM+CNIduv1ofeG/vYvTx3GstOdjeAHAh7jKIB4+lC/dxpP+mPPEMRyrv7PbEJybG7eDZIRwdTwiydxEkKTGG17N5ZnmlJvl/FyN5bmC72sYwhYfIf8SRFaN/mGdZ9EMtwNa+u5P9D6yelUDu6CCSI=;
  h=From:To:Cc:Subject:Date:MIME-Version:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200812280024.59096.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104033>

Quoting Markus Heidelberg <markus.heidelberg@web.de>:

>> For consistency and increased code reuse, change format: to do the
>> same as the other options.
>
> What's wrong with using the first line instead of the first paragraph
> for the other pretty options and for cases where only a small subject
> line is desired?

There were too many issues. The mail archive tells us that there were considerable discussions and thoughts behind the current behavior:

	http://thread.gmane.org/gmane.comp.version-control.git/49694/focus=49922
	http://thread.gmane.org/gmane.comp.version-control.git/46341/focus=46818
	http://thread.gmane.org/gmane.comp.version-control.git/54020/focus=54132
	http://thread.gmane.org/gmane.comp.version-control.git/21949/focus=21987

The last message mentions a bug in "git rebase" that internally uses "git am" when replaying the changes. It was corrected later with:

	http://thread.gmane.org/gmane.linux.ports.sh.devel/3833/focus=79735

Reading the discussion in the messages in this thread will help understanding the issues, after understanding why "the first line" was problematic, as discussed in the other threads.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
