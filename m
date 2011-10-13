From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Wed, 12 Oct 2011 21:14:04 -0500
Message-ID: <20111013021404.GA21045@elie.hsd1.il.comcast.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andreas Ericsson <ae@op5.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 04:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REAoU-0002sb-6d
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 04:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab1JMCOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 22:14:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49670 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1JMCOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 22:14:21 -0400
Received: by gyb13 with SMTP id 13so1311102gyb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bYMquMs4GeGk3HCt4zZabQTRNe4PSPBU40nSrtqI4rU=;
        b=fpJsmQ0PouWObrUrXiY8Sbo4N6R+Oaaoax9POhLGY8BMHG2jp2qMBm5M+VCYgygkgR
         7MNmZFHKjiZgxvfwDL9mVyakTgp1k37ps/ZpO/2Ij2JuYbbeZV6mLra6+LazJZItIp0X
         RG8M4qqenYGrko87Ihx2SehmPwYhHjOY7BUZw=
Received: by 10.236.129.141 with SMTP id h13mr1962507yhi.120.1318472058831;
        Wed, 12 Oct 2011 19:14:18 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z6sm11608695anf.22.2011.10.12.19.14.16
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 19:14:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111012200916.GA1502@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183434>

(+cc: Andreas[*])
Jeff King wrote:
> On Tue, Oct 04, 2011 at 08:55:09AM +1100, Nguyen Thai Ngoc Duy wrote:

>> The message is chosen to avoid leaking information, yet let users know
>> that they are deliberately not allowed to use the service, not a fault
>> in service configuration or the service itself.
>
> I do think this is an improvement, but I wonder if the verbosity should
> be configurable. Then open sites like kernel.org could be friendlier to
> their users. Something like this instead:

FWIW the more verbose version you suggest also sounds fine to me.  A
person trying to find the names of local users by checking for
repositories with names like "/home/user" would always receive the
error "no such repository", whether that user exists or not and
whether the actual error encountered was ENOENT, EACCES, lack of git
metadata, or the path running afoul of a whitelist or blacklist.

Either Duy's patch or this patch sounds very good to me.  Thanks to
both of you for working on it.

[*] context:
http://thread.gmane.org/gmane.comp.version-control.git/182529/focus=183409
