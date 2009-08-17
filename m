From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 22:02:58 +0200
Message-ID: <4A89B772.8060307@gnu.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>  <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com> <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Pe-0007gQ-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZHQUC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbZHQUC3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:02:29 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:35431 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZHQUC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:02:29 -0400
Received: by bwz22 with SMTP id 22so2526977bwz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=xLtM7u7GL7exIpRjR26GuOfr1Arl6uMyi+IRrmdfQzI=;
        b=SMgyxFjpOwz35WRcRpKxso3H8kUxEWBl5cCZRTSb7pu4hHAsbYo8LlXDSIg2YVhOiZ
         NvH229OgeNtcolBulEjY3o0ecXqUWPrWprp+UCWaJf0uKmGBiJVRylupSsROkH+2afiH
         3E9xdVmZdjAgM5j9FbSI3mraX8uUxhkZuM9S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=eoFxnHuiUtqNb8ILZdh7sdmKPlUsjE/pk2Hdo5fCFaHwZ9woclrTlATl4lJuloTuAf
         sBLPANkxMAEYRSAUaOxG0UHDMrFUEvHmOek6cqsJxwm0Z51NFtJ5FBKpG2zj35PDU0hg
         m/zFZu5WLnvIqcvqjR8wkajJAN/DQxkucnbBk=
Received: by 10.204.148.69 with SMTP id o5mr3074916bkv.99.1250539349283;
        Mon, 17 Aug 2009 13:02:29 -0700 (PDT)
Received: from scientist-2.local ([85.93.118.17])
        by mx.google.com with ESMTPS id 21sm5428171fkx.14.2009.08.17.13.02.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 13:02:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126268>


> I think the killer argument against such a script (I actually though of 
> that myself, but decided against it for that very reason) is that the 
> result is to be used by Microsoft Visual Studio users, who do not 
> typically have a scripting language, and who would not want to use it 
> anyway.

But the script could run whenever the Makefile is updated, even under
Unix.  Of course, there are chances of bitrotting, but it cannot be
worse than having failures every time a builtin is added or otherwise a
file is added.

The main problem I see with the script is that the output would
naturally be a .gitignore-d file, but it will not be for the reason you
mention.

> Of course, we could have a script that verifies that the .vcproj files 
> contain reference the appropriate files (which it would know about by 
> being called from the Makefile and being passed the file names), maybe 
> even be able to edit the .vcproj file if it is missing some.  Should not 
> be too hard in Perl.

Yes, it's not very far from what I had in mind.

Paolo
