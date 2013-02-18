From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 05/10] pkt-line: rename s/packet_read_line/packet_read/
Date: Mon, 18 Feb 2013 02:19:15 -0800
Message-ID: <20130218101915.GE7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092252.GE5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NpE-0007GK-5h
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab3BRKTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:19:23 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35124 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853Ab3BRKTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:19:20 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1614911pbc.7
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=48VWrFCKMId/oxNdgUrOIDuII2I90B/1F9obDcWhzNU=;
        b=ZA4/GBfsl333SsoNXw2MByUPY82NWYE+QGcww2w6Sa1hiKwbrXjc1Q19yxcHJJbpk9
         UAC+1TRaXriv6Ld+ro9Ln9YAJEkPHCQ+c2Hv6bsd4PYEqDuRNQOOBHiFJlB7ryEwXpky
         T1xFrVX5Q8sobhQ9DRgpmJi8c9v3MrMv4BfU6qtxKdOsU06SrLMHFUXXqx3KtNgUpwCT
         vK+ETj1Bp3V3Y55MvnYdU5Ao+Au1Jv1Z7GJd2szaR/M7SyauuoaFw7LT/fpvfj+i38GR
         idiyn5KIMGdXXGJEagAsWM3FDLsTwGVbsi8hKxbkIXsIcmxxW9YhTOyPOS2Vikf4iir2
         QujA==
X-Received: by 10.68.23.97 with SMTP id l1mr28711037pbf.141.1361182760027;
        Mon, 18 Feb 2013 02:19:20 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id d1sm103328041pav.6.2013.02.18.02.19.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:19:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218092252.GE5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216467>

Jeff King wrote:

> Originally packets were used just for the line-oriented ref
> advertisement and negotiation. These days, we also stuff
> packfiles and sidebands into them, and they do not
> necessarily represent a line. Drop the "_line" suffix, as it
> is not informative and makes the function names quite long
> (especially as we add "_gently" and other variants).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Again, this is a taste issue. Can be optional.

In combination with patch 3, this changes the meaning of packet_read()
without changing its signature, which could make other patches
cherry-picked on top change behavior in unpredictable ways. :(

So I'd be all for this if the signature changes (for example to put
the fd at the end or something), but not so if not.

Thanks,
Jonathan
