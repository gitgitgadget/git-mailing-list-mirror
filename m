From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pager: config variable pager.program
Date: Mon, 31 Jul 2006 14:56:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607311454040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1G6wM1-00040z-Bu@moooo.ath.cx> <7v8xmabo37.fsf@assigned-by-dhcp.cox.net>
 <E1G7WfC-000728-9j@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 14:56:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7XJx-0005dp-Lb
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 14:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWGaM43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 08:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWGaM42
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 08:56:28 -0400
Received: from mail.gmx.de ([213.165.64.21]:3783 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750719AbWGaM42 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 08:56:28 -0400
Received: (qmail invoked by alias); 31 Jul 2006 12:56:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 31 Jul 2006 14:56:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G7WfC-000728-9j@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24520>

Hi,

On Mon, 31 Jul 2006, Matthias Lederhofer wrote:

> Signed-off-by: Matthias Lederhofer <matled@gmx.net>

The commit message no longer reflects what the patch does ;-)

> -	const char *pager = getenv("PAGER");
> +	char *pager;

You do not need to lose the "const" (it means that you cannot access the 
memory it points to, but you can change the pointer). Also, you could make 
a more minimal patch by replacing PAGER by GIT_PAGER here, instead of 
having this extra line:

> +	pager = getenv("GIT_PAGER");

Ciao,
Dscho
