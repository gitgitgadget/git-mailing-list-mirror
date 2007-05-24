From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 08:59:34 +0200
Message-ID: <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com>
References: <11799589913153-git-send-email-skimo@liacs.nl>
	 <11799589922243-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Martin Waitz" <tali@admingilde.org>
To: "skimo@liacs.nl" <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Thu May 24 08:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7IQ-0007aX-9r
	for gcvg-git@gmane.org; Thu, 24 May 2007 08:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbXEXG7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 02:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbXEXG7g
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 02:59:36 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:11357 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbXEXG7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 02:59:35 -0400
Received: by ik-out-1112.google.com with SMTP id c28so359135ika
        for <git@vger.kernel.org>; Wed, 23 May 2007 23:59:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWjtop1YMAoy5m6BEM3sK37K0I+IDQyBjM/XpSiyN5gkkHtgwLGXGoLnwltUuPafqAR6CSI42XhvJfTHGLj2MhFN0n3w2PrIQNUkOebFBkQCagUUVdliDWUcTw8detx8EeIp0fQ8viUOaYTxQ36HAVl6I5LjejZ8h2DQkCxowrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IZmYuzR9LpYdus5JInQEseqw7NZvk2Fz5U2fF6VCBtiOUUEHMqd7O2JadI9pidHpFfG5WwI/JoTz9b6bK3JkfeDsX6V8j4kJOwlI9QEmpYEYcqGARz8x0hnPgqqk4FhF2HtmYfJqoe5vp/PPLqjm2dtUOm6qS5VG1saM4uwo4bY=
Received: by 10.78.142.14 with SMTP id p14mr384967hud.1179989974217;
        Wed, 23 May 2007 23:59:34 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 23:59:34 -0700 (PDT)
In-Reply-To: <11799589922243-git-send-email-skimo@liacs.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48226>

On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:

> +       args[argc++] = "checkout";
> +       if (state->force)
> +           args[argc++] = "-f";
> +       args[argc++] = sha1_to_hex(ce->sha1);
> +       args[argc] = NULL;

You should consider passing "-v" if the superprojects read-tree
had it. Some submodules will be annoyingly big
