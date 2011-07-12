From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 12:41:35 +0200
Message-ID: <201107121241.40242.jnareb@gmail.com>
References: <20110711161332.GA10057@sigill.intra.peff.net> <20110711161754.GB10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 12:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgaPk-0008VR-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 12:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab1GLKlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 06:41:55 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:58929 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1GLKlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 06:41:53 -0400
Received: by fxd18 with SMTP id 18so4859420fxd.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=b5oNYP7JLk+QVWDXNrtwC1SKNGR2u9+z9Bu6LYRDrrk=;
        b=Hn/sMIrNEvEWcQIfPfwlr3aePXkOVYwFS6iNCNMYojDrz6fEMCgbzbZAih0mdlqLcH
         DhssudSWiSEvVAnTq6mAwWMmYjfsOouLTVxI3c2ueis79I7bPbBSikzkO4etxUnLQm4f
         Sr8IC5auKbzyB21OaH6ibD4WQvXSRdXfRSwAE=
Received: by 10.223.13.211 with SMTP id d19mr9201633faa.67.1310467311848;
        Tue, 12 Jul 2011 03:41:51 -0700 (PDT)
Received: from [192.168.1.15] (abvo74.neoplus.adsl.tpnet.pl [83.8.212.74])
        by mx.google.com with ESMTPS id d15sm3206196fan.2.2011.07.12.03.41.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 03:41:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110711161754.GB10418@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176937>

On Mon, 11 July 2011, Jeff King wrote:

> There is sometimes a need to cache some information about an
> object or set of objects persistently across git
> invocations. The notes-cache interface can be used for this,
> but it is very heavyweight and slow for storing small
> values.
> 
> This patch introduces a new API, object-cache, which stores
> a mapping of objects to values in a concise and efficient
> form. See the added API documentation for details.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As I mentioned earlier, I wanted this to be generic and size-agnostic,
> because I'd also like to try caching patch-ids for git-cherry.

Could this API be generalized to support "reverse cache", for example
to map Subversion revision numbers to Git revision identifiers (for 
git-svn)?

-- 
Jakub Narebski
Poland
