From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 12:41:56 +0200
Organization: eudaptics software gmbh
Message-ID: <4624A474.77756C86@eudaptics.com>
References: <200704171041.46176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:41:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdl8B-0003Bc-Ek
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbXDQKls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDQKls
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:41:48 -0400
Received: from main.gmane.org ([80.91.229.2]:52646 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbXDQKlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:41:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hdl80-0003WP-9f
	for git@vger.kernel.org; Tue, 17 Apr 2007 12:41:40 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 12:41:40 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 12:41:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44760>

Andy Parkins wrote:
>         switch (git_path_check_crlf(path)) {
>         case 0:
> -               return 0;
> +               changes += 0;
>         case 1:
> -               return forcecrlf_to_git(path, bufp, sizep);
> +               changes += forcecrlf_to_git(path, bufp, sizep);
>         default:
> -               return autocrlf_to_git(path, bufp, sizep);
> +               changes += autocrlf_to_git(path, bufp, sizep);
> +       }
> +
> +       switch (git_path_check_keyword(path)) {
> +       case 0:
> +               changes += 0;
> +       case 1:
> +               changes += keyword_unexpand_git(path, bufp, sizep);
>         }

I think there are 'break's missing all along the way.

-- Hannes
