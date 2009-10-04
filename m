From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Sun, 04 Oct 2009 13:02:21 -0700
Message-ID: <1254686541.507.9.camel@swboyd-laptop>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
	 <20091004133333.GA13894@sigill.intra.peff.net>
	 <20091004141355.GA15783@eideticdew.org>
	 <20091004182746.GA22995@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Petter Urkedal <urkedal@nbi.dk>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 04 22:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuXLx-0004Pn-E9
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 22:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbZJDUDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757869AbZJDUDg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 16:03:36 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:38416 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751AbZJDUDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 16:03:35 -0400
Received: by qw-out-2122.google.com with SMTP id 3so889802qwe.37
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=sRn52+TnYhjf6Btz8TA5qZQrw1XN2U4l5mUYEvI0Beo=;
        b=NoT8SKt1oZGLFN2ooWxiEKDL+naNlzJ4TauX6KyA3oEqmow8hIkwNFmh1eDGkBlYWO
         wMIscVh8+QUt1f2WBT9j1TmezipgVdskdZaG64j2L1vv5EFyhvjr37efBditfqtEPZDC
         avJZSa+tcA0GegBE2FWzE5ymEuPg0eZ+WGJCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=AZCnGJ7r5C8YjNMfquuppD3KQX8T5gyTa5TKE5XidgcQsulJ1Hm44gWdzMbvfA7N7n
         Z9pliQlblq6W0JrasVls81hG0oeQWU5iAMYn2wCPxhp09OmXntmXAZ6uo2tP3Q68disU
         qtUO5ZODmUENvZeAwSKUJfpEfu82Jfnk2sCVI=
Received: by 10.224.70.202 with SMTP id e10mr2707791qaj.16.1254686548901;
        Sun, 04 Oct 2009 13:02:28 -0700 (PDT)
Received: from ?192.168.1.6? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm60409qwg.3.2009.10.04.13.02.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 13:02:27 -0700 (PDT)
In-Reply-To: <20091004182746.GA22995@coredump.intra.peff.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129517>

On Sun, 2009-10-04 at 14:27 -0400, Jeff King wrote:
> 
> Ah, thanks, for some reason I wasn't able to produce it before, but I
> can easily replicate it here. I think it's a regression from converting
> show-branch to use parse_options, which happened in May, but I didn't
> actually bisect it. I'm not sure showbranch.default has worked at all
> since then (which I guess goes to show how many people are actually
> using it).

Correct. Junio sent a patch to fix this problem in June[1]. I guess he
must have dropped his own patch, or he wasn't satisfied with how parse
options clobbers things.

[1] http://article.gmane.org/gmane.comp.version-control.git/121142
