From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Sun, 6 Feb 2011 16:09:39 -0600
Message-ID: <20110206220939.GC17210@elie>
References: <4D4C5EBC.2090100@web.de>
 <201102042326.08607.j6t@kdbg.org>
 <4D4D33E7.4000303@web.de>
 <7vipwwx56r.fsf@alter.siamese.dyndns.org>
 <4D4F19D0.2000408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 06 23:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmCnn-00014s-OH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 23:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1BFWJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 17:09:46 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61760 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1BFWJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 17:09:46 -0500
Received: by yib18 with SMTP id 18so1517258yib.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ChgeqlTF8R8ViAjfyXJ9UvbB30mMfn64E5E+okUqd90=;
        b=sp//dNCdqw2D0CYVl4OQKj7xfSBi/HduXpCdzjtEPSbf+IuafvgAUQKRw6scnCf3Hk
         KpgGp3uC52MWnImCQ95mwP7cUoyHfs+3/FX0/YyTdg0YZDpw0LwuYXN/XdXj02/u+gSG
         Kzu5xZHMNyZjEV0G5xbW5FZ+xNodmiF3yOD8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZH8he8o86ZuZ9I7fmvdnlsSRlYBSt/2NmS8AY1WxXIqwFgXz1RD0kQI7wJl6/+dLL6
         AZHaYFTpEG8BgNYvxVg292NKCNaJAAr6QOG18aKosXnv/iTO0jt8cQ+bl37sVeETVuM1
         KpcVYB/5QO/rAnBm6bJsuTILlM5KBBP+SkyB4=
Received: by 10.147.170.7 with SMTP id x7mr3665161yao.23.1297030184857;
        Sun, 06 Feb 2011 14:09:44 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id f13sm2334199yhf.33.2011.02.06.14.09.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 14:09:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4F19D0.2000408@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166207>

Jens Lehmann wrote:
> Am 06.02.2011 21:45, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> Yes, but isn't that exactly what the pull man-page says? Quote:
>>> "Options meant for git pull itself and the underlying git merge
>>> must be given before the options meant for git fetch."
>> 
>> Yes, it says that, and I think that was a weasely way to say "the command
>> line parser in git-pull is broken".
[...]
> (CCed Jonathan, as he is the author of the lines I quoted)

They're from Junio. :)  See v1.5.4.5~26 (git-pull documentation: warn
about the option order, 2008-03-10).

I also agree that (1) it would be very nice to find a way to fix this
and (2) until then, it seems best as a general principle not to
regress in those odd cases where we sort of fixed it.

In other words, if we were adding --recurse-submodules today, I'd
agree that it should be treated like other fetch options, but we
already added the option and some people/scripts might be used to
the added flexibility, no?
