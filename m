From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH/RFT] Work around http-fetch built with cURL 7.16.0
Date: Fri, 29 Dec 2006 09:37:52 -0300
Message-ID: <200612291237.kBTCbq0P010010@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 13:38:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Gzq-0002aS-5c
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 13:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbWL2Mh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 07:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbWL2Mh7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 07:37:59 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37103 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbWL2Mh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 07:37:58 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBTCbqFg031052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Dec 2006 09:37:52 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBTCbq0P010010;
	Fri, 29 Dec 2006 09:37:52 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Thu, 28 Dec 2006 16:40:13 -0800." <7vfyazttzm.fsf_-_@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 29 Dec 2006 09:37:52 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35590>

Junio C Hamano <junkio@cox.net> wrote:
> It appears that curl_easy_duphandle() from libcurl 7.16.0
> returns a curl session handle which fails GOOD_MULTI_HANDLE()
> check in curl_multi_add_handle().  This causes fetch_ref() to
> fail because start_active_slot() cannot start the request.
> 
> For now, check for 7.16.0 to work this issue around.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * I think people who were having trouble with cURL 7.16.0 want
>    to have the issue resolved before v1.5.0-rc1.  Please test
>    and report, or else ;-).

Checked it out. Now clone and pull both work here.

Thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
