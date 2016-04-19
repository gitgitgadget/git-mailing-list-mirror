From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 19:43:11 -0400
Organization: Twitter
Message-ID: <1461109391.5540.138.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
	 <20160419071403.GA22577@sigill.intra.peff.net>
	 <1461102001.5540.125.camel@twopensource.com>
	 <20160419232243.GF18255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:43:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asfIc-0000L6-TI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbcDSXnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:43:15 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33396 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbcDSXnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:43:14 -0400
Received: by mail-qg0-f49.google.com with SMTP id v14so19609552qge.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DiqsnjK/V2qTR3m7bqtioKcI+Ja6QJ5LSsT2k/MJZrU=;
        b=1q+xPjSvEErdvlZIfJWCtOfLZYOGhblMLwQS2PX8iIxwgUtUYKXmcddc7UasKYf5lb
         EjaWp3ymrvFPnfTLhr2xAZWoAkoHvxaIEVAMr3nZHfA96GRgDerp7PEtWj3ja3N7sS3q
         JDMAyNdvQ48YF7+AVSFKafs+9CokAtQUtvRo78DoTGB57jtdu/xhsseetXfKOXEFSANR
         s+YsoXD2l1WdiSoXYrA88yhrJ6V/Zi61MGdGaMYWNDAa1q65qF6q8vy4mU2twIf/8iH5
         txL2TXO3J5ONtdPY92Nh1FFXKJNPp+NsW3RAH7K62cVuWuHg846sGA/ZIkyqhiPKLy2A
         yXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DiqsnjK/V2qTR3m7bqtioKcI+Ja6QJ5LSsT2k/MJZrU=;
        b=G7fx8q6sWU9RNBzWY/+wszKrOKxJG/njVlMXvIwTUXzvcADguIiKhqTjQRF3YDnwQm
         wZyaFqPUO7Y0NFAd+fv6wiMgb03NRLMnszyNviTOtXSfuBHBJAP4wNZ5OiiimeWkPZS6
         c0ZKmdWHE3CAiEUsNtSRg2hQ5lRUjCIZYd/tX+xAYZOszddJqMqX10FX9o034g8DIAkp
         5qxnAarpRpLmrpc3kx2X9iYQdODyHjE9snojPXJxZb3Fyu8yc4L/7+HPCxqRV07qsfzb
         4LrHZ5V+XDKpKTkj5eR/zt/q7c5GdzORABKU7tAC52LbKcxxIBW3GlZpxou/sUOo73E4
         qDng==
X-Gm-Message-State: AOPr4FXorZZAdpsoKCkAf4Zt3TaxfPMr2WjJ4O+xTFRI/sto9ugV3oMN6YPj3Ahbw3PojA==
X-Received: by 10.140.199.4 with SMTP id u4mr7648596qha.56.1461109393406;
        Tue, 19 Apr 2016 16:43:13 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 65sm29916943qgz.40.2016.04.19.16.43.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:43:12 -0700 (PDT)
In-Reply-To: <20160419232243.GF18255@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291968>

On Tue, 2016-04-19 at 19:22 -0400, Jeff King wrote:
> You can find previous discussion on the list, but I think the options
> basically are:
> 
>   1. Something like v2, where the client gets a chance to speak
> before
>      the advertisement.
> 
>   2. Some out-of-band way of getting values from the client to the
>      server (so maybe extra command-line arguments for git-over-ssh,
> and
>      maybe shoving something after the "\0" for git-daemon, and of
>      course extra parameters for HTTP).
> 
>   3. The client saying "stop spewing refs at me, I want to give you a
>      ref filter" asynchronously, and accepting a little spew at the
>      beginning of each conversation. That obviously only works for
> the
>      full-duplex transports, so you'd probably fall back to (2) for
>      http.

OK, so (2) seems like what I'm doing -- it just happens that I only
implemented it for one protocol. 
