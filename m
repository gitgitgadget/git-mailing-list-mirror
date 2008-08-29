From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Disambiguate "push not supported" from "repository not found"
Date: Fri, 29 Aug 2008 11:20:44 +0200
Message-ID: <200808291120.44413.robin.rosenberg@dewire.com>
References: <1219969118-31672-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0bc-000647-En
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbYH2Jrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbYH2Jrt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:47:49 -0400
Received: from [83.140.172.130] ([83.140.172.130]:6307 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756381AbYH2Jrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:47:48 -0400
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2008 05:47:47 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2E531800699;
	Fri, 29 Aug 2008 11:22:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCa9G-nExKHt; Fri, 29 Aug 2008 11:22:51 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B65A880068E;
	Fri, 29 Aug 2008 11:22:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219969118-31672-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fredagen den 29 augusti 2008 02.18.38 skrev Shawn O. Pearce:
> +				if (avail.isEmpty())
> +					throw noRepository();
>  				throw eof;
>  			}
>  
> @@ -185,6 +182,10 @@ else if (this instanceof FetchConnection)
>  		available(avail);
>  	}
>  
> +	protected TransportException noRepository() {
> +		return new NoRemoteRepositoryException(uri, "not found.");
> +	}
> +

Why an extra method for instantiating the exception?

-- robin
