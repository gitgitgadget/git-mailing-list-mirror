From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 1 Dec 2010 10:34:06 -0600
Message-ID: <20101201163406.GD26120@burratino>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:34:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpdN-0003wX-0W
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab0LAQeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:34:16 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53765 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab0LAQeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:34:15 -0500
Received: by vws16 with SMTP id 16so415157vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FTSzHAPjjwpI6XnPrjqw3XgJ/AN1jlaVholdOAi1gOQ=;
        b=mxJEYxqx22X/eKEITCW7CiG22kyVjtYuiQVaD54gMh8bG83Al5Lbf5xcR8jp/xQUPB
         BWsI2zVCGb8Im3uFMAf+ehT4o/GNaFymGoR6LyC2PtBVNmrah4oGfeWYsTTwx5wZSIFP
         miJKFVQN9wEI6PsOxoLx5jYjqu4ZUrDqmbwng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AqVoKi+yV24rYz090QgSQL45BAEBXlZQYnrlJ2J6BMkRi4vRxqc3oAy0T8xSlQsIKr
         PLDsHP9Kp0NDIPpu1SdA9srK9/rSew8nN1ECAyD1GMYvSr+xYmTQclOyxKIE9PI8+P7a
         OH0hzxOqLm2YmohvSkypQ2aVtcuotZU0u+xYg=
Received: by 10.220.182.199 with SMTP id cd7mr42264vcb.176.1291221254706;
        Wed, 01 Dec 2010 08:34:14 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id j7sm41702vcr.39.2010.12.01.08.34.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:34:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3aakp4g5o.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162545>

(+cc: Jeff, config parsing wizard)

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I somewhat like this idea.  So let's build a full table, shall
>> we?  The embedded dashes are meant for the command-line options
>> rather than the config file.
[...]
> Good idea, though I'd rather we avoid new convention for multi word
> names separated with '-' (multi-word), but rather use camel case
> (multiWord).

No disagreement there. :)

> Currently we have only unfortunate exception of `add.ignore-errors',

Maybe we can teach the config file parser to ignore dashes in addition
to case (except in the names of [genus "species"] headings)?  That
would be an incompatible change for third-party tools, though, so
maybe "git config" would have to take an explicit --strip-dashes
flag to do it.
