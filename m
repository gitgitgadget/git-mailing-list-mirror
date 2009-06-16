From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv3 3/4] submodule, repack: migrate to git-sh-setup's say()
Date: Tue, 16 Jun 2009 00:38:08 -0700
Message-ID: <4A374BE0.4060604@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>	<1245117905-19351-2-git-send-email-bebarino@gmail.com>	<1245117905-19351-3-git-send-email-bebarino@gmail.com>	<1245117905-19351-4-git-send-email-bebarino@gmail.com> <7viqiwg1rl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 09:38:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTFS-0007d4-IH
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 09:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbZFPHiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZFPHiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 03:38:09 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:59429 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZFPHiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 03:38:08 -0400
Received: by pzk17 with SMTP id 17so2506908pzk.33
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZA1o9U0YqS6VX/qZJ/nGaLoEnTFjf3wL2SeMnZRPwyU=;
        b=fjg/l/todb8eRz6aliCGgklWKsRiYjSBawDEBBqg19aqyoQcAe6XHYxg82u/sssI1l
         ccKQMP1Ojb+uzPNFsszk3iBhUBIA4U+gSk3QZ2XwNvJrHPJJgr6tosrM7i6TusBaSBnu
         CoF0zelCKQbSlqr8pKXbIbjIPfsPjJpsG01OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D+B5cymbLoeN3JO7Q371VwIdv0ws/ejHKYkXWm6OdYpIJyOeRGTxcDg1s65Lyq4VWL
         rMDBnFWZ630LnKA1BWAfzlb7uAncO7ROpBLmQl2v0GaRxdQcZ/FQDvu+6L0cSQygyeuj
         kQMMjyk+4MxSHPotRQXyOJ6ItXjBdKCTUnRCQ=
Received: by 10.143.42.6 with SMTP id u6mr3950613wfj.149.1245137891341;
        Tue, 16 Jun 2009 00:38:11 -0700 (PDT)
Received: from ?192.168.1.5? (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 30sm47452wff.29.2009.06.16.00.38.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 00:38:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7viqiwg1rl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121661>

Junio C Hamano wrote:
> This is not exactly a very nice style.

I had a feeling ;-)

> If the convention is "GIT_QUIET, when set to non-empty string, squelches
> the output", then I think the callers should be more consistent and the
> call to prune-packed should say something like this, which is admittedly a
> roundabout way:
>
> 	git prune-packed ${GIT_QUIET:+-q}
>
> for consistency (and then what you set to GIT_QUIET in the first hunk I
> quoted does not matter anymore---it can even be t or 1 or whatever).
>
> I think this does not matter too much, because I suspect that in the
> longer term scripted Porcelains are going away, but still...

I think this is fine. At least it's more explicit and localized. I'll do
the same for git-am
