From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 04 Jan 2012 18:24:16 -0800 (PST)
Message-ID: <m3vcoqevjm.fsf@localhost.localdomain>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
	<1325692539-26748-1-git-send-email-drizzd@aon.at>
	<7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
	<20120104204017.GC27567@ecki.lan>
	<7vaa63p11t.fsf@alter.siamese.dyndns.org>
	<20120104222649.GA14727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 03:24:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rid0F-0006Gp-79
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 03:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab2AECYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 21:24:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35401 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2AECYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 21:24:21 -0500
Received: by eekc4 with SMTP id c4so39912eek.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1sHYepOes+vIx3THq0RGJNSfe/iuEgjRv324RO572pM=;
        b=vWRwLMhJHglwBSTRP7tKg8MC0EufzZvZRAZlTzqLuC+CKAu2a2YhanI3jzQDtPPUz6
         nlzIFr+P9dTZ30sGArsmVo2uqr/c/9yzKs1hHOSSfEbXhnR00dAfUwdShtJXG7JIK989
         5TY7ikl8+x3U/8lq2At1BZobOlwsYglMGaLGc=
Received: by 10.14.122.136 with SMTP id t8mr57702eeh.36.1325730260172;
        Wed, 04 Jan 2012 18:24:20 -0800 (PST)
Received: from localhost.localdomain (abvw18.neoplus.adsl.tpnet.pl. [83.8.220.18])
        by mx.google.com with ESMTPS id q67sm165736377eea.8.2012.01.04.18.24.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Jan 2012 18:24:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q052OFQq010051;
	Thu, 5 Jan 2012 03:24:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q052OD0b010048;
	Thu, 5 Jan 2012 03:24:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120104222649.GA14727@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187961>

Jeff King <peff@peff.net> writes:

> As a side note, it looks like we just start the daemon with "git daemon
> &". Doesn't that create a race condition with the tests which
> immediately try to access it (i.e., the first test may run before the
> daemon actually opens the socket)?

Hmmm... perhaps the trick that git-instaweb does for "plackup" web
server would be of use here, waiting for socket to be ready?

-- 
Jakub Narebski
