From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 08 Jun 2007 15:19:31 +0200
Organization: eudaptics software gmbh
Message-ID: <46695763.D65CDC30@eudaptics.com>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 15:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HweN2-0007u6-UT
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 15:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938116AbXFHNTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 09:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966776AbXFHNTP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 09:19:15 -0400
Received: from main.gmane.org ([80.91.229.2]:41676 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938030AbXFHNTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 09:19:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HweMZ-0007cx-Pv
	for git@vger.kernel.org; Fri, 08 Jun 2007 15:18:47 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 15:18:47 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 15:18:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49473>

Johannes Schindelin wrote:
>  # list all parent's object names for a given commit
>  get_parents () {
> -       git-rev-list -1 --parents "$1" | sed "s/^[0-9a-f]*//"
> +       case "$filter_subdir" in
> +       "")
> +               git-rev-list -1 --parents "$1"
> +               ;;
> +       *)
> +               git-rev-list -1 --parents "$1" -- "$filter_subdir"
> +       esac | sed "s/^[0-9a-f]*//"
>  }

I think --full-history in the subdir case would make a lot of sense.

-- Hannes
