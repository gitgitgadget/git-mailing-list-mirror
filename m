From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: How to send patch series without storing them to disk?
Date: Mon, 3 Nov 2008 22:50:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811032242080.1791@sys-0.hiltweb.site>
References: <490EC57E.4080200@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 04:51:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxCxK-0004O9-Bk
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 04:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYKDDug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 22:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYKDDug
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 22:50:36 -0500
Received: from mail.gmx.com ([74.208.5.67]:58444 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752903AbYKDDuf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 22:50:35 -0500
Received: (qmail invoked by alias); 04 Nov 2008 03:50:33 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO localhost) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 03 Nov 2008 22:50:33 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/d0bUSvCLdVV83hxUcInJOYmfFqYVOBKrrF5Z1cQ
	UN/aLj/W/Q3Ggk
In-Reply-To: <490EC57E.4080200@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100028>

On Mon, 3 Nov 2008, Liu Yubao wrote:
> Hi,
> 
> I want to send patches like this:
> 
>   git format-patch --stdout --no-color -C --thread -n $oldrev..$newrev | ...send...
> 
> It seems git-send-email can't read email from stdin.
> 
> 
> I tried to send one patch using git-send-email, it reported "Syntax: AUTH mechanism".
>   git send-email --from <myemail> --to <my-another-email> \
>                  --smtp-pass <mypass> --smtp-user <myaccount> \
>                  --smtp-server <the-smtp-server> \
>                  --smtp-encryption auth          \
>                  0001-just-a-test.patch
> 
> The parameters about smtp are right, I tested with msmtp. What's wrong?
> 
> I have MIME::Base64 and Authen::SASL installed and the smtp server doesn't use
> ssl and tls.

Try removing --smtp-encryption and add --envelope-sender <youremail>.


	Ian
