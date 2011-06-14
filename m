From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is current HEAD pointing at a given revision ?
Date: Tue, 14 Jun 2011 02:00:55 -0700 (PDT)
Message-ID: <m3mxhkvlcw.fsf@localhost.localdomain>
References: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWPUd-0001Ct-38
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 11:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab1FNJBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 05:01:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57903 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638Ab1FNJA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 05:00:58 -0400
Received: by fxm17 with SMTP id 17so3428047fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=ZjPuZ2qIFOe0pV0EgB/pWupzzF43dEg3zZwFq6066qU=;
        b=Wx3KVD4mtsk12wJOpCDwfjv3dpSKDxNIKePsg9f0Y3UpCadINGya5SsrQJFRH704Zw
         +lMZldF31M7Od/g4y5ZCh9NNTWcaZ8ysZljTGkszfvnl3Nwp70D5lwkD+GJEtJQk8gpr
         ihKdWI6OrDfkmqWF96sQsS1uzHflbjoircZoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=akCNkzVERx/Y0oGKJhx1ylMYJP5fkVmaZ3OcvW4qLDEb7630dh1abBsF6+DZU4UyAe
         2g0PwgEdrZQ5nc+jAtOM1nXMmAdYvs5QujYD5ASqZfyKR4ms7lwGuDAU2EOO3lPVu+rX
         G48PsaQmOw1F2kMLZ9YXM3XGKJRaqmrvqKo0Q=
Received: by 10.223.13.10 with SMTP id z10mr396483faz.69.1308042056770;
        Tue, 14 Jun 2011 02:00:56 -0700 (PDT)
Received: from localhost.localdomain (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id b26sm2547126fak.24.2011.06.14.02.00.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 02:00:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5E90SZU011268;
	Tue, 14 Jun 2011 11:00:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5E90HIi011262;
	Tue, 14 Jun 2011 11:00:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTikFTHc4Qiu1YLxXgPhweNnVqMO11Q@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175752>

Francis Moreau <francis.moro@gmail.com> writes:

> I have a given revision (tag, sha1 ...) and I'd like to know if that
> revisions corresponds to what the current HEAD is pointing at.
> 
> Could anybody give me some advices for achieving this ?

If you want to know if given revision (or ref) points at the same
thing as HEAD, you can use

  [ "$(git rev-parse HEAD)" = "$(git rev-parse $ref^{commit})" ]

or something like that.  The '^{commit}' is here in case $ref points
only indirectly to commit, via a tag object.

If you want to kow if current HEAD is tagged, you can use instead

  git describe --exact-match HEAD

-- 
Jakub Narebski
Poland
ShadeHawk on #git
