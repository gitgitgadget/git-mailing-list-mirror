From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Wed, 27 Jan 2010 17:56:36 +0200
Message-ID: <20100127155636.GA18210@Knoppix>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
 <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAG8-0003cV-2f
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 16:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab0A0P4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755304Ab0A0P4l
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 10:56:41 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:35693 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab0A0P4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 10:56:41 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 39DEE13BEA0;
	Wed, 27 Jan 2010 17:56:40 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A07C8635F48; Wed, 27 Jan 2010 17:56:40 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 033504083;
	Wed, 27 Jan 2010 17:56:36 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138162>

On Wed, Jan 27, 2010 at 12:18:35PM +0100, Tor Arvid Lund wrote:

> Then, I did 'git fetch', and got a seg fault. I got around it by
> commenting out a line:
> 
> diff --git a/transport.c b/transport.c
> index 7714fdb..5b404f7 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -924,7 +924,7 @@ struct transport *transport_get(struct remote
> *remote, const char *url)
>         ret->url = url;
> 
>         /* In case previous URL had helper forced, reset it. */
> -       remote->foreign_vcs = NULL;
> +/*     remote->foreign_vcs = NULL;*/
> 
>         /* maybe it is a foreign URL? */
>         if (url) {
> 

Hmm... And just commenting out that line will break case if you have
push URL using remote helpers and second one for same remote that
doesn't. 

I'll look into that issue.

-Ilari
