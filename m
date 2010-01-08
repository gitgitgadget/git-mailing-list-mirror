From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] base85: No need to initialize the decode table in
 encode_85
Date: Fri, 08 Jan 2010 16:46:41 +0100
Message-ID: <4B475361.60506@drmicha.warpmail.net>
References: <alpine.LFD.2.00.1001071253400.21025@xanadu.home> <1262958000-27181-2-git-send-email-agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 16:48:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTH4b-0000tw-W7
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 16:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab0AHPsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 10:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315Ab0AHPsW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 10:48:22 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53850 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184Ab0AHPsV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 10:48:21 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 09589C991B;
	Fri,  8 Jan 2010 10:48:21 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 08 Jan 2010 10:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pZnH5R8ELC15yc/h1wyb2VRuZ34=; b=PovnoKtjOSplWRHxows/vajnWwBTpR8DBiBQBv7hECJTQAXXRWnuhQKco4r1JR9KbhALpTnAkIr+IQvFP3mgrQ9lkZ8eaxkfJ/9qCZTQLNYRiFUn6vPrnR1p8ERCXMNIvtgJAaHeqQJsAXrFJy/6eKRJdDo4z0nsQOgCVvyu/nU=
X-Sasl-enc: CJi/fCdq9IpKh2cNcvh0/Nzn/hopd8cc1yJi4Mboq+b8 1262965700
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 708A2284D1;
	Fri,  8 Jan 2010 10:48:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <1262958000-27181-2-git-send-email-agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136446>

Andreas Gruenbacher venit, vidit, dixit 08.01.2010 14:39:
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> ---

For the less informed it may be worthwhile to have an explanation in the
commit message why encode_85() does not need to initialize the table. (I
strongly suspect it's a matter of de vs. en, i.e. "because it only
encodes but does not decode."...)

>  base85.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/base85.c b/base85.c
> index 1d165d9..7204ce2 100644
> --- a/base85.c
> +++ b/base85.c
> @@ -84,8 +84,6 @@ int decode_85(char *dst, const char *buffer, int len)
>  
>  void encode_85(char *buf, const unsigned char *data, int bytes)
>  {
> -	prep_base85();
> -
>  	say("encode 85");
>  	while (bytes) {
>  		unsigned acc = 0;
