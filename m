From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 07 Feb 2010 01:15:10 -0800 (PST)
Message-ID: <m363699zn4.fsf@localhost.localdomain>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
	<201002070236.12711.johan@herland.net>
	<7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
	<20100207050255.GA17049@coredump.intra.peff.net>
	<2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 10:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne3Ei-0003KI-49
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 10:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0BGJPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 04:15:16 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:42911 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab0BGJPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 04:15:13 -0500
Received: by fxm3 with SMTP id 3so6103004fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=B0YC+WfxDwCz7SC/zeqHL5hlN12aoSPNpLBxi7+Cebg=;
        b=Tcat4EjxPygSCwUtv2Xg8VyrYTjD5wVsXsC8D4szmhQssPhb6N5V8GTdbUutZiQj40
         PU9qP03vzS1oOkGogF8EaCArSRSdFHX5HvfT06ARCINWBtqltiyPbc5xuxfeoKuUrSd6
         1KLGBCfBl3OasHZ740lV5V69+OR+nFX/O6ceY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EyDPF18ALZCdctesWgMOXHEEI9l9oi8rVDOmp391cSY1xfUrO7K+zu0/57f4enJ6nS
         ikmFsgGabl6WFsdWo98oEtl7YwUYyjPO9AngBDIx8+269Po++POqWZQ7pJNsS56CRQoI
         lAgkjGBTOnHm7U6Npeu21uhtHMFF/+rH90hVA=
Received: by 10.223.76.91 with SMTP id b27mr219096fak.4.1265534111264;
        Sun, 07 Feb 2010 01:15:11 -0800 (PST)
Received: from localhost.localdomain (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 13sm1375540fxm.9.2010.02.07.01.15.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 01:15:10 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o179EJcF029409;
	Sun, 7 Feb 2010 10:14:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o179DqU5029397;
	Sun, 7 Feb 2010 10:13:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139225>

Jon Seymour <jon.seymour@gmail.com> writes:

[cut]

> As I see it, the existing use of notes is a special instance of a more
> general metadata capability in which the metadata is constrained to be
> a single blob. If notes continued to be constrained in this way, there
> is no reason to change anything with respect to its current userspace
> behaviour. That said, most of the plumbing which enabled notes could
> be generalized to enable the arbitrary tree case [ which admittedly, I
> have yet to sell successfully !]
> 
> In one sense, there is a sense in the merge issue doesn't exist. When
> the maintainer publishes a tag no-one expects to have to deal with
> downstream conflicting definitions of the tag. Likewise, if the
> maintainer were to publish the /man and /html metadata trees (per my
> previous example) for a release tag, anyone who received
> /refs/metadata/doc would expect to receive the metadata trees as
> published by the maintainer. Anyone who didn't wouldn't have to pull
> /refs/metadata/doc.
> 
> I can see there are use cases where multiple parties might want to
> contribute metadata and I do not currently have a good solution to
> that problem, but that is not to say there isn't one - surely it is
> just a question of applying a little intellect creatively?

Are you trying to repeat fail of Apple's / MacOS / HFS+ filesystem
data/resource forks, and Microsoft's Alternate Data Streams in git? :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
