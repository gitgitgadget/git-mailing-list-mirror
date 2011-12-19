From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/2] attr: drop C/C++ default extension mapping
Date: Mon, 19 Dec 2011 12:10:03 -0600
Message-ID: <20111219181003.GB12200@elie.hsd1.il.comcast.net>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
 <20111219155737.GB19829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 19:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RchfF-00042v-MF
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 19:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab1LSSKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 13:10:14 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45078 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1LSSKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 13:10:12 -0500
Received: by vcbfk14 with SMTP id fk14so4224705vcb.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=br3KjqqnJq5QnSeT2Cu7YV6W3HKOquiST5iXRNClQGo=;
        b=A7VhZjNGFOlXcPmtL8lUu+iyJED8WVkFAA3a4KOGuikebXA3KA2rXhc3s0rwj4yHBb
         IwnhFrXBzwsCbgJs6Qg1uq8jgReO2FjomPhfH+uLBdoJaXvXPrJpAkyLDGRMiMF81Ebz
         2RzGY5CvTG2g5Ruhu06S+X4rxwVbEtpj7Fs6w=
Received: by 10.52.24.43 with SMTP id r11mr4968722vdf.125.1324318211624;
        Mon, 19 Dec 2011 10:10:11 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c7sm16920816vdh.12.2011.12.19.10.10.10
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 10:10:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111219155737.GB19829@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187463>

Jeff King wrote:

> But when you think about it, if our funcname pattern is bad, shouldn't
> preventing (2) be the right thing? That is, if our funcname pattern is
> really worse than the default language-agnostic match, wouldn't we be
> doing everybody a service to simply remove the builtin
> diff.cpp.xfuncname pattern?

I don't see why.  Anyone who has set "diff=cpp" either likes suffering
(maybe they are hoping to improve the pattern) or is working with a
codebase for which the current pattern works better than the default
behavior (maybe their codebase has a lot of goto labels aligned at
column zero).  So removing the funcname pattern can only hurt them.
