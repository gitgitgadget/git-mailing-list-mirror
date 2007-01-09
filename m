From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] --utf8 is now default for 'git-am'
Date: Tue, 09 Jan 2007 09:28:51 +0100
Organization: eudaptics software gmbh
Message-ID: <45A35243.FB9FB121@eudaptics.com>
References: <7vlkkduqm6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 09 09:28:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4CLZ-0005hz-S4
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbXAII2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAII2i
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:28:38 -0500
Received: from main.gmane.org ([80.91.229.2]:45152 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbXAII2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 03:28:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H4CLI-0002O3-WD
	for git@vger.kernel.org; Tue, 09 Jan 2007 09:28:25 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 09:28:24 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 09:28:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36328>

Junio C Hamano wrote:
> @@ -128,7 +128,9 @@ do
>         -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
>         sign=t; shift ;;
>         -u|--u|--ut|--utf|--utf8)
> -       utf8=t; shift ;;
> +       shift ;; # this is now default
> +       --no-u|--no-ut|--no-utf|--no-utf8)
> +       utf8=; shift ;;
>         -k|--k|--ke|--kee|--keep)
>         keep=t; shift ;;
> 

How is

  git-am --no-utf8 --utf8 mbox

to be interpreted? I'd expect that the last option on the command line
has precedence, for example, if git-am is used in a script like this:

  git-am --no-utf8 $userpreferences $mbox

With you patch --no-utf8 always overrides any --utf8 that is specified.

-- Hannes
