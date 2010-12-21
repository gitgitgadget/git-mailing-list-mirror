From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'show' pretty %B without a diff
Date: Tue, 21 Dec 2010 04:56:30 -0800 (PST)
Message-ID: <m38vzjl1yr.fsf@localhost.localdomain>
References: <20101220073842.GC10354@external.screwed.box>
	<7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
	<20101220111214.GD10354@external.screwed.box>
	<7v4oa8cobn.fsf@alter.siamese.dyndns.org>
	<20101221104641.GA8600@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 13:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV1lf-0002cX-NQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 13:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab0LUM4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 07:56:34 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:48880 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0LUM4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 07:56:33 -0500
Received: by fxm18 with SMTP id 18so4266550fxm.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qm45hBQrVuW2uSj6noMuAnG5ceLPwUI/yGfSq8dR5Ws=;
        b=CC7iZdC1ryiQDEBkgpFLPOm1XnH7VbiV1RQsYskPvBZn/FsU20TlAqXdBMSs1cifr1
         48fVkDRO9eC6OLB+FIm9WOrXRZZfBUtihuRguEvSFVZG7GyuGlRSJToQ62aFyJagzMR0
         r3jVCTPCEBZwcNgjzH5/PxP2ksG/nv19qKlNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GHP2YVI8akHRtVzqwif/9d5zfAzi4fzBAxnsSawn7Wl9GqfTb0Xt1RMBwPd/3Pqmmb
         rAamXsxTkmVjEJUU+7cmpNFgYp3j/TTFofJFaqI68DrC7gwwe7V5Nfi1dGFZDnf09BXZ
         wXqSQlwmqwzygE3u3hjlWmhcJ1SpFWlqPmb1s=
Received: by 10.223.96.202 with SMTP id i10mr5230530fan.50.1292936192371;
        Tue, 21 Dec 2010 04:56:32 -0800 (PST)
Received: from localhost.localdomain (aehn132.neoplus.adsl.tpnet.pl [79.186.195.132])
        by mx.google.com with ESMTPS id y3sm1304431fai.14.2010.12.21.04.56.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 04:56:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBLCttcj018949;
	Tue, 21 Dec 2010 13:56:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBLCtfcq018939;
	Tue, 21 Dec 2010 13:55:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101221104641.GA8600@external.screwed.box>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164030>

Peter Vereshagin <peter@vereshagin.org> writes:
> 2010/12/20 10:05:16 -0800 Junio C Hamano <gitster@pobox.com> => To Peter Vereshagin :

> JCH> If your script is _not_ parsing the git command output, but is just
> JCH> blindly spewing it out to the invoking user, it is Ok to use "show",
> JCH> though.  Check "-s" option to the "show" command in that case.
> 
> "show" command doesn't seem to have "-s" switch. Skip it up though ;-)

Hmmm... true, unfortunately it is described in hidden corner: when
git-show is used to display commits, it accepts diff family
options... including `-s' described in git-diff-tree manpage:

  -s::
        By default, 'git diff-tree --stdin' shows differences,
        either in machine-readable form (without '-p') or in patch
        form (with '-p').  This output can be suppressed.  It is
        only useful with '-v' flag.

  -v::
        This flag causes 'git diff-tree --stdin' to also show
        the commit message before the differences.

I guess that `-s' should be present also in git-show manpage.

There is also `git log -1` (or `git log -1 --no-walk` for paranoid).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
