From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: gitosis question: identifying/logging remote user
Date: Tue, 2 Jun 2009 09:32:40 +0530
Message-ID: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tv@eagain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 06:02:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBLD7-0002wM-8F
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 06:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbZFBECk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 00:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZFBECj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 00:02:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:49333 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZFBECj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 00:02:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so4443701yxj.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 21:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=iYf70LXepvkiQD+6MSlQ5yQotzzWNjvfWdiX+VSsEd4=;
        b=rCjQf8itnnI0rXT3HXpArJGJ4WTaaf2lz3tyyWse0o0S2GPZ6ml26LRKgc8dgZmSS9
         310Uay4rZwDSOzMCMVkAWJsPM6Cyg//exQjwSaPdaSguzUTrSNLwW0f1LongmPDIKbKi
         FI179NOqfV3kiPYHDR0bE5r9w7NaFo15iYCiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=YsGgwYhCCmXnYYCdDnnD+CQejjDdqweRRykksazJPw5nyzaeuIGumHFGpd5UhWbDV/
         cAgyVDtdJtgj0K14hzoVld6UEa/IWQu8uiJyu+UK0xftalXBwQ4Rw9gU8/NR2Qsn112y
         aYHHo0vV63/Olzmw//QcdmZ6ws8i/DY6gN2XA=
Received: by 10.231.34.66 with SMTP id k2mr1769107ibd.19.1243915360079; Mon, 
	01 Jun 2009 21:02:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120493>

Hi,

Summary:

I want to be able to log the information that the post-receive hook
receives, but I *also* want, along with that, the name of the pubkey
that was used in this particular "push".

Detail:

gitosis uses lines in ~git/.ssh/authorized_keys that use ssh's
"command=" feature.  Specifically, the command is restricted to
"gitosis-serve username".  Internally, gitosis uses this name to
decide if you're allowed to do what you're trying to do.

I'd like it to set an additional env var which will contain "username"
so that hooks etc can get that info and use it as they they see fit.

Q1: are there any downsides to doing this?  I don't see any, you're
just creating and setting a new variable but...

Q2: if it's a good idea, can someone give me a hint about where to do
this?  I'm useless at python but I'm willing to try.

Thanks,

Sitaram
