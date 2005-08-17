From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 18:12:36 +0100
Message-ID: <tnxvf24o5bv.fsf@arm.com>
References: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 19:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5RTn-0006gn-6H
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVHQRN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVHQRN0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:13:26 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:9372 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751174AbVHQRNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 13:13:25 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7HHCHOU019229;
	Wed, 17 Aug 2005 18:12:17 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id SAA11613;
	Wed, 17 Aug 2005 18:13:10 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 17 Aug 2005 18:13:09 +0100
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com> (Marco
 Costalba's message of "Tue, 16 Aug 2005 13:01:32 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 17 Aug 2005 17:13:09.0782 (UTC) FILETIME=[F11B9360:01C5A34E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> wrote:
> Suppose a possible scenario involves using a couple of git archives, one 
> for releases and stable code, say MAIN, and one for experimental stuff  
> or new development, say HEAD.
>
> Suppose there is stuff in HEAD you don't want merged in MAIN, more,
> you need to update MAIN with only a subset of patches in HEAD, peraphs 
> in different order. Or simply, you are not interested to see the history 
> of the HEAD tree when looking MAIN. All this points could keep you 
> from merging.

As others already recommended StGIT, I will just add a simple usage
scenario (I do this with my StGIT repository).

The MAIN/stable repository (or branch) is only managed with GIT, not
StGIT. The HEAD one is managed with StGIT (only, you can use 'stg
clone'). You can create patches, modify them etc. (I updated the
README in the latest snapshot and it contains some kind of tutorial).

Once you want a subset of these patches merged into MAIN, just pop
everything from the stack and only push those you want merged, in the
order you want (if there are some dependencies, the push will fail and
you can correct them or the order). When you are happy with the
patches pushed on the stack, just do a 'git pull <HEAD>' in the MAIN
repository. After this, doing a 'stg pull <MAIN>' in the HEAD one will
mark the patches already integrated into MAIN as empty and you can
safely remove them ('stg clean' does this automatically).

This way I found StGIT useful for maintainers as well, not only for
contributors.

-- 
Catalin
