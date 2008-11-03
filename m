From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Mon, 03 Nov 2008 11:35:42 +0100
Message-ID: <490ED3FE.8040103@op5.se>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil> <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, nico@cam.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 03 11:37:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwwo2-0002Ox-SI
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbYKCKf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 05:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbYKCKf5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:35:57 -0500
Received: from mail.op5.se ([193.201.96.20]:35025 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbYKCKf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 05:35:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BDD581B80C9F;
	Mon,  3 Nov 2008 11:30:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9r4fJLd2IDO6; Mon,  3 Nov 2008 11:30:43 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 787701B80062;
	Mon,  3 Nov 2008 11:30:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99931>

drafnel@gmail.com wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> Objects residing in pack files that have an associated .keep file are not
> supposed to be repacked into new pack files, but they are.
> 

I think that's a misconception. Packfiles that are marked with .keep files
should never be deleted. There are, afaik, no rules against packing the
same objects into other packfiles as well. This is nifty for dumb ref
walkers, as they can use a small pack for incremental fetching while using
a mega-pack for initial cloning.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
