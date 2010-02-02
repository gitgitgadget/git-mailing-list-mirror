From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A git-mv question
Date: Tue, 02 Feb 2010 07:32:45 -0800 (PST)
Message-ID: <m3r5p3ac2e.fsf@localhost.localdomain>
References: <ron1-09EE6C.16083801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:33:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKkN-0002XI-2r
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab0BBPcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:32:50 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:63193 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab0BBPcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:32:48 -0500
Received: by fxm7 with SMTP id 7so196581fxm.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lJszktAbu07VtlONIlozpjrTU61r6JVLHYlBe62ulLo=;
        b=QWKzCpnY/VKInHwA5sz8sGqfruiU6omDzodS5bv25yUnkJv4d0mbLKPOnr2EVXGZcJ
         NHQ3t4Aw+A9tE/maTskHy7rU14ipxB1PZFaaa1dnD7f9T/oZV1JWN8tAKzEgoyZGZLCz
         14Him4MXmGYAcwfHRDnLKO9bSQBMO24rFUx18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ddSoxNELDrdRMKmngjeb6TpMN8HGKT9iS4JIY3HEWRa5qt0nGjNOpg48dwhuDdtyFC
         /Jp/BKwz4aW4xaLSaiGdER+rit+qFYSzDgJ+4wUt2ioaaEIfFkdEMPPC2GEjMtaPe4WC
         nVuE5WVK78ww8FMOp1hBhoMX9k0aT8TuHwnIw=
Received: by 10.86.106.7 with SMTP id e7mr10762283fgc.1.1265124767120;
        Tue, 02 Feb 2010 07:32:47 -0800 (PST)
Received: from localhost.localdomain (abvl217.neoplus.adsl.tpnet.pl [83.8.209.217])
        by mx.google.com with ESMTPS id 16sm2564591fxm.12.2010.02.02.07.32.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 07:32:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12FWERN013155;
	Tue, 2 Feb 2010 16:32:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12FVrhR013148;
	Tue, 2 Feb 2010 16:31:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ron1-09EE6C.16083801022010@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138726>

Ron Garret <ron1@flownet.com> writes:

> If I do a git-mv *and* edit the file all in one commit, does that get 
> recorded in a way that allows git to track the change through the 
> changed file name?  In other words, if I do just a git-mv (without 
> changing the file) git can track that by observing that two differently 
> named objects in two different commit trees contain the same blob.  But 
> if the file is edited then the blobs will be different.  Is git smart 
> enough to distinguish a git-mv and edit from, say, the equivalent git-rm 
> and git-add?  If so, how does it do it?

Git does not distinguish between git-mv and equivalent git-rm+git-add;
it employs heuristic similarity based (based on how contents of files
is similar to each other) rename detection.

Also worth noting is that git does consider only endpoints for rename
detection in diff and in merge; it does not check history if there
were clean rename / rename + edit.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
