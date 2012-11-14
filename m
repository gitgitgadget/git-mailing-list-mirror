From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] var: provide explicit/implicit ident information
Date: Wed, 14 Nov 2012 09:06:57 -0800
Message-ID: <20121114170657.GC6858@elie.Belkin>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165308.GD12626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgQo-0004rx-9I
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785Ab2KNRHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:07:02 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64013 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2KNRHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:07:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so499276pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SueqMn7cI9Yye4wR0/OJcN3kHu7G07PJO//YMLvIrGo=;
        b=q9EL0hKTCglJFJQQebl5JpDYFFZr3rkVHqP0d+Nbzr2Xm9f2uQjVtPEk7fHKaee7Tb
         q22sLH+yes3c35e2l3TX5SGZWlpsIvtEqJSkgr3nFpkh/E8mdmY+ySA2Jvi75HntsivW
         NNz7D9rcdj+PRJFHwo1DWdXoOebhnSG75OEbEaxVWFLqpd+xe6+iQf7V+NTWkFSCQYwK
         oiDPTcWstxPMz3ofmgZi1A3ECdu0J1w4nL1eNJCrtmKK8L9xubzq3OPk/EjVJ1TLg6w8
         kwg2JCKGZOlIzcM0Wi+P3vszsmiC21y4V46HZ3gTZj9haIT0jlBGcfLPji8YLaAZjRyX
         lv5g==
Received: by 10.68.237.167 with SMTP id vd7mr73702516pbc.161.1352912820465;
        Wed, 14 Nov 2012 09:07:00 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id d2sm8184179paw.19.2012.11.14.09.06.59
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 09:06:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121113165308.GD12626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209727>

Jeff King wrote:

> Internally, we keep track of whether the author or committer
> ident information was provided by the user, or whether it
> was implicitly determined by the system. However, there is
> currently no way for external programs or scripts to get
> this information

What are the intended semantics?  If my machine has /etc/mailname
filled out, is that an implicit identity?  How about if I set the
EMAIL envvar but not GIT_COMMITTER_EMAIL?

If external scripts are going to start using this mechanism, they will
need answers to these questions to support users that run into
configuration problems.  A few words on this in the documentation
could probably help.

On most machines I have the EMAIL envvar set explicitly, but in the
recent past I relied on /etc/mailname on some others, so I'm also
genuinely curious about the use case here (and too lazy to dig it up).

Thanks,
Jonathan
