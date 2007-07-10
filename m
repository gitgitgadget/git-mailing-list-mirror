From: Sam Vilain <sam@vilain.net>
Subject: Re: Per-file, possibly even per-hunk cherry picking
Date: Wed, 11 Jul 2007 00:48:15 +1200
Message-ID: <4693800F.4010308@vilain.net>
References: <469378AB.7030909@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 14:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8F9C-0005v9-S3
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 14:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758506AbXGJMsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbXGJMsK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 08:48:10 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43822 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757706AbXGJMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 08:48:08 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8ACB721CEB3; Wed, 11 Jul 2007 00:48:06 +1200 (NZST)
Received: from [192.168.1.3] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 9DCC721CEA4
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 00:48:01 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <469378AB.7030909@vilain.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52060>

Sam Vilain wrote:
> I'm interested in extending the cherry analysis to allow specification
> of the diff options used when calculating diff IDs, presenting the
> calculated diff IDs for analysis by external tools, and even calculating
> and dealing with per-hunk diff IDs.
>   

On reflection I think so long as --cherry-pick works together with a
file selection, it would probably be enough.

ie, if I have these commits:

A---B
 \
  \
   C

B changes a file foo.c, adding a line of text.  C changes foo.c as well
as bar.c, but the change in foo.c was identical to change B.

I want this to show me nothing:

  git-rev-list --left-right --cherry-pick B...C -- foo.c

Would it be the right approach to put this information in ids->diffopts,
or somewhere else?

Sam.
