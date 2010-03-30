From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: malformed threads when using both --in-reply-to and --compose
 with git send-email
Date: Tue, 30 Mar 2010 10:12:57 -0400
Message-ID: <4BB206E9.8050807@xiplink.com>
References: <1269902972.3392.42.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Tue Mar 30 16:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwcBu-0002Cr-7r
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 16:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab0C3ONI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 10:13:08 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:47456 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0C3ONG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 10:13:06 -0400
Received: from relay12.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay12.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id E80D52080258;
	Tue, 30 Mar 2010 10:13:04 -0400 (EDT)
Received: by relay12.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 82D9F208018E;
	Tue, 30 Mar 2010 10:13:04 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
In-Reply-To: <1269902972.3392.42.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143568>

Sylvain Rabot wrote:
> Hey,
> 
> I don't know if it's the wanted behavior but It seemed odd to me.
> 
> If I want to send a series of patches to an already started thread using
> --in-reply-to option and --compose this is what I would get :
> 
> git send-email --to git@vger.kernel.org --compose --in-reply-to <Message
> #2> --format-patch HEAD~2
> 
> + Message #1
>   + Message #2
>     + [PATCH 0/2] My Serie of patches
>     + [PATCH 1/2] My first patch
>     + [PATCH 2/2] My second patch
> 
> I would have expected something more like this which is done when
> starting a new thread :
> 
> + Message #1
>   + Message #2
>     + [PATCH 0/2] My Serie of patcher (In-Reply-To : <Message #2>)
>       + [PATCH 1/2] My first patch (In-Reply-To : <My Serie of patches>)
>       + [PATCH 2/2] My second patch (In-Reply-To : <My Serie of
> patches>)

I encountered this as well and agree with you that the latter would be
better.  --compose should only apply the --in-reply-to value to the composed
message.

Care to make a patch?

		M.
