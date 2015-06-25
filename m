From: Wolfgang Denk <wd@denx.de>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 22:13:09 +0200
Message-ID: <20150625201309.5026A384E81@gemini.denx.de>
References: <20150625155128.C3E9738005C@gemini.denx.de> <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8DWR-0003cT-9O
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbbFYUNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:13:15 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48767 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbFYUNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:13:13 -0400
Received: from frontend02.mail.m-online.net (unknown [192.168.8.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 3mHXbC0fJNz3hjff;
	Thu, 25 Jun 2015 22:13:11 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.69])
	by mail.m-online.net (Postfix) with ESMTP id 3mHXbC03G8zvdWt;
	Thu, 25 Jun 2015 22:13:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.184])
	by localhost (dynscan2.mail.m-online.net [192.168.6.69]) (amavisd-new, port 10024)
	with ESMTP id 4ZeeNSqBv0ga; Thu, 25 Jun 2015 22:13:09 +0200 (CEST)
X-Auth-Info: BKKNDVAKUjpLL1TNyfyVCfqUDesgnLzg95TouZC9bCg=
Received: from diddl.denx.de (host-80-81-18-216.customer.m-online.net [80.81.18.216])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA;
	Thu, 25 Jun 2015 22:13:09 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by diddl.denx.de (Postfix) with ESMTP id 86C871AB2CC;
	Thu, 25 Jun 2015 22:13:09 +0200 (CEST)
Received: from gemini.denx.de (localhost [IPv6:::1])
	by gemini.denx.de (Postfix) with ESMTP id 5026A384E81;
	Thu, 25 Jun 2015 22:13:09 +0200 (MEST)
In-reply-to: <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Thu, 25 Jun 2015 10:32:36 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272717>

Dear Junio,

thanks for the fast replies.

In message <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com> you wrote:
> 
> > Question is: how can we fix that?
> 
> It could be that 4d0d8975 is buggy and barking at a non breakage.
> 
> If there is no message in the tag, i.e.
> 
>     -- 8< --
>     object 84ef51a632063e8cb57b2e9a4252497512831ffe
>     type commit
>     tag LABEL_2006_03_12_0025
>     tagger Wolfgang Denk <wd@pollux.denx.de> 1142119613 +0100
>     -- >8 --

It seems recent tools cannot create such tags any more?

> I do not offhand see why we want to require that there is a lone
> blank line at the end.

Hm... it seems I cannot even easily delte these tags:

-> git tag -d LABEL_2006_03_12_0025
Deleted tag 'LABEL_2006_03_12_0025' (was eb394f5)
-> git fsck --full
Checking object directories: 100% (256/256), done.
Checking object directories: 100% (256/256), done.
error in tag eb394f56db3e05d00891d6dc36a00df0025cf255: unterminated header
error in tag 9bf86baaa3b35b25baa2d664e2f7f6cafad689ee: unterminated header
error in tag c7071e6d645a8e13adb0d4cea2caad27213fa62f: unterminated header
error in tag eb394f56db3e05d00891d6dc36a00df0025cf255: unterminated header
error in tag 9bf86baaa3b35b25baa2d664e2f7f6cafad689ee: unterminated header
error in tag c7071e6d645a8e13adb0d4cea2caad27213fa62f: unterminated header
Checking objects: 100% (657288/657288), done.
Checking connectivity: 325718, done.
dangling tag eb394f56db3e05d00891d6dc36a00df0025cf255

Now I also have this "dangling tag" thingy...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"An organization dries up if you don't challenge it with growth."
       - Mark Shepherd, former President and CEO of Texas Instruments
