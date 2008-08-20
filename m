From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git am with MIME
Date: Wed, 20 Aug 2008 21:57:34 +0200
Message-ID: <20080820195734.GE16626@blimp.local>
References: <48AAEBB6.9070306@gmail.com> <20080819170731.GA2424@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtpK-00022D-TH
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbYHTT5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbYHTT5h
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:57:37 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:44459 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbYHTT5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:57:37 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (fruni mo13) (RZmta 16.47)
	with ESMTP id y06949k7KGh0Rb ; Wed, 20 Aug 2008 21:57:35 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 17043277AE;
	Wed, 20 Aug 2008 21:57:35 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 0198336D18; Wed, 20 Aug 2008 21:57:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080819170731.GA2424@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93024>

Jeff King, Tue, Aug 19, 2008 19:07:31 +0200:
> On Tue, Aug 19, 2008 at 05:50:14PM +0200, Lea Wiemann wrote:
> @@ -107,7 +107,7 @@ static void handle_from(const struct strbuf *from)
>  	el = strcspn(at, " \n\t\r\v\f>");
>  	strbuf_reset(&email);
>  	strbuf_add(&email, at, el);
> -	strbuf_remove(&f, at - f.buf, el + 1);
> +	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
>  

 +	strbuf_remove(&f, at - f.buf, el + !!at[el]);

(Some people'll kill me for that :)
