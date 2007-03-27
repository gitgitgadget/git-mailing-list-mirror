From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] use xrealloc in help.c
Date: Tue, 27 Mar 2007 18:40:45 -0400
Message-ID: <118833cc0703271540l6615b413gd1df3dc5525a2d00@mail.gmail.com>
References: <1175034608589-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
To: "James Bowes" <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 00:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKLT-00037P-VC
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbXC0Wkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 18:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbXC0Wkt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:40:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:47311 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbXC0Wks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 18:40:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so37069uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 15:40:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ULzio46IawY5x1X2C+CNK0iSx5AX1FA2y75ixxSnZkfFPQxcejfTpjmATHx0mm6azXfUJZ4d1NR7luqIrAN6XckCEJMeDrdn5V0/9Q9z9p87m7kcOmEzCI+yzFTkvJ5gReqjBQS1L+anweyHScBS26DgvqxCfsFnVFF5Aup3AKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BduhzX34+/k7nUKeg6dTa5QFRNIBBZlYaamuX9GBZMHfvV2NAQCPn4o/sZZ0dmpgJ3H7EfiDJn2uZzvK2A8IS8kkzETgZqjqYGDxkKTKtrbWpqa1ut/qnvwnb9mBIEdNHduTg2UrfQLvfcPB3nouj/ytRR+QQvvXmW0Oe/EAZE8=
Received: by 10.114.195.19 with SMTP id s19mr3368539waf.1175035245521;
        Tue, 27 Mar 2007 15:40:45 -0700 (PDT)
Received: by 10.115.109.10 with HTTP; Tue, 27 Mar 2007 15:40:45 -0700 (PDT)
In-Reply-To: <1175034608589-git-send-email-jbowes@dangerouslyinc.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43315>

> -               cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
> +               cmdname = xrealloc(cmdname, cmdname_alloc * sizeof(*cmdname));
>                 if (!cmdname)
>                         oom();

If you are using xrealloc, shouldn't kill the oom check here too?

M.
