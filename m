From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 16:59:21 +0200
Message-ID: <201110161659.22261.stefano.lattarini@gmail.com>
References: <20111016144215.GC22144@arf.padd.com> <20111016144435.GE22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 16:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFSBe-00038d-4M
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1JPO7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:59:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56507 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab1JPO7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:59:33 -0400
Received: by wyg36 with SMTP id 36so1437713wyg.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=gSE9EIOrCbhwxzP8qa0mD7OSJgdCtYzO4ADt7k3aZ8s=;
        b=P1vQSMLYAnZalzvBgRs/2RBih0lgBNjwMu72B4XpxhSLXZZY4zJOPRZL2nrpLORFmh
         le+01bFJJD9czvPScsSsdS31hr6rutH7l+MQFxuM8YAiKVV2xLD2KDGmCv2T/aAplENs
         ErSXWtwIZ394OiBIY72gP9He5wU/gdcu4AzBk=
Received: by 10.216.193.223 with SMTP id k73mr2548347wen.55.1318777172127;
        Sun, 16 Oct 2011 07:59:32 -0700 (PDT)
Received: from bigio.localnet (host224-95-dynamic.244-95-r.retail.telecomitalia.it. [95.244.95.224])
        by mx.google.com with ESMTPS id fy13sm25716029wbb.18.2011.10.16.07.59.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 07:59:31 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/2.6.30-2-686; KDE/4.6.5; i686; ; )
In-Reply-To: <20111016144435.GE22144@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183722>

Hi Pete, and thanks for taking my previous remarks into account.  I have
one more nit/question though ...

On Sunday 16 October 2011, Pete Wyckoff wrote:
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> new file mode 100755
> index 0000000..dff0e02
> --- /dev/null
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -0,0 +1,108 @@
> +#!/bin/sh
> +
> + [SNIP]
> +
> +		printf "three\nline\ntext" >f-ascii &&
>
With this command, the `f-ascii' file won't be newline-terminated.  Is
this intended, or the result of an oversight?  The same goes for further
similar usages in the rest f the patch.

Regards,
  Stefano
