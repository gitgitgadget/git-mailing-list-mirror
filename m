From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH] Teach read-tree the -n|--dry-run option
Date: Tue, 17 May 2011 23:15:14 +0200
Message-ID: <4DD2E562.90605@web.de>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org> <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org> <4DD2CFD4.7060508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 23:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMRbw-0008U2-Lt
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 23:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab1EQVPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 17:15:17 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43900 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab1EQVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 17:15:17 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id F369619FEF595;
	Tue, 17 May 2011 23:15:14 +0200 (CEST)
Received: from [93.240.98.235] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QMRbm-0003Pp-00; Tue, 17 May 2011 23:15:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DD2CFD4.7060508@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19tjwhNbD58LsNP0LVPibgKxKYQGV75NwbqmXD/
	ho/+oOCyrM3AcLKEdDATJWh8p1bba6NtI2oP4bTxYyt4nuH71e
	KWjmLxCkGr2fzmejcDKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173824>

Am 17.05.2011 21:43, schrieb Jens Lehmann:
> The only exceptions where I could not make that replacement without
> breaking a test were:
> 
> * t1001:381 (#25) new file conflicts with untracked directory
>   This should have been detected by verify_absent_1(), but that function
>   is left early when opts->update is 0. Will look into that.
> 
> * 1011:95  (#5)  read-tree with empty .git/info/sparse-checkout
> * t1011:163 (#11) read-tree updates worktree, dirty case
>   Not sure about those two as I haven't got much experience with sparse
>   checkout. Will dig further, pointers welcome.

I found the reason for all three failures, patch coming.
