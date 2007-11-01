From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Wed, 31 Oct 2007 17:46:40 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
References: 18216.31314.990545.518458@lisa.zopyra.com
 <1193861145-20357-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 01:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InOEj-0008EF-Kn
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 01:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXKAAs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbXKAAs0
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 20:48:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53344 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752122AbXKAAsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 20:48:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA10kfnc009993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 17:46:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA10keQJ004860;
	Wed, 31 Oct 2007 17:46:40 -0700
In-Reply-To: <1193861145-20357-1-git-send-email-mh@glandium.org>
X-Spam-Status: No, hits=-4.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_53,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62900>



On Wed, 31 Oct 2007, Mike Hommey wrote:
> +	if type cpio > /dev/null 2>&1; then
> +		local=yes
> +	fi

Isn't "type" a bashism?

Maybe just do

	if echo . | cpio -o > /dev/null 2>&1; then

instead? Maybe even doing this at install time to avoid the overhead of 
executing another process..

		Linus
