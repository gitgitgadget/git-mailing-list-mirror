From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] Move chmod(foo, 0444) into move_temp_to_file()
Date: Sat, 28 Mar 2009 11:48:41 +0100
Message-ID: <200903281148.41982.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <200903261616.47185.johan@herland.net>
 <7vskky18ds.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 11:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnW7R-0000lL-5g
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 11:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326AbZC1Kst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 06:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbZC1Kss
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 06:48:48 -0400
Received: from mx.getmail.no ([84.208.15.66]:34914 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758261AbZC1Ksr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 06:48:47 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH700J1QQ179670@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 28 Mar 2009 11:48:43 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH7006TFQ16DY20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 28 Mar 2009 11:48:43 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.28.103120
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7vskky18ds.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114947>

On Saturday 28 March 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > When writing out a loose object or a pack (index), move_temp_to_file()
> > is called to finalize the resulting file. These files (loose files and
> > packs) should all have permission mode 0444 (modulo
> > adjust_shared_perm()). Therefore, instead of doing chmod(foo, 0444)
> > explicitly from each callsite (or even forgetting to chmod() at all),
> > do the chmod() call from within move_temp_to_file().
>
> I think you would need this on top.

Agreed.

Thanks,

..Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
