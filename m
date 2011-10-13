From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Thu, 13 Oct 2011 00:59:24 -0500
Message-ID: <20111013055924.GA24019@elie.hsd1.il.comcast.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 07:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REEKV-0002K2-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 07:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab1JMF7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 01:59:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37080 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab1JMF7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 01:59:38 -0400
Received: by gyb13 with SMTP id 13so1464702gyb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 22:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1OkmWckU8FIkqWafasQ7q8fB9gfyDCUKuT7BoLCN3aU=;
        b=dGjk0h9VINjBHCwdZr1vl+7H4OS+gujfWxVKZ+u5vdW+cSO5yS+FgukJUCcFoZfCHe
         vB3F/e9t2sfyn1D9tH6D/9r8wnSWW9GyDnGJH2hwt+Or4iy7MfR8wv+inmHlEs+yXYIh
         8dYYoLYAchunCyK8V538FTwV7GK6EGvj3yOwc=
Received: by 10.236.153.200 with SMTP id f48mr2563107yhk.114.1318485578068;
        Wed, 12 Oct 2011 22:59:38 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x12sm6003803yhi.10.2011.10.12.22.59.36
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 22:59:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183441>

Nguyen Thai Ngoc Duy wrote:

> How about allow users to select which messages they want to print? We
> can even go further, allowing users to specify the messages themselves..
[...]
> +	{ "service not enabled", "message.serviceNotEnabled" },
> +	{ "no such repository", "message.noSuchRepository" },
> +	{ "repository not exported", "message.repositoryNotExported" },

I administer a private server that is only accessible as "localhost".
:)  This much customization would leave me confused about what the
right choices are and what the choices mean (even if I were to make
the server public and start having security worries).

What is the intended use --- translation?  The idealist in me thinks
that should be taken care of on the client side, if at all.  (This
way, we would not be preventing especially friendly clients from
offering pertinent detailed advice for each error condition.
Alternatively, maybe some day the protocol will want to provide a way
for clients to indicate a preferred language and message verbosity.)
