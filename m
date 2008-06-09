From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes are missing
Date: Mon, 09 Jun 2008 04:07:14 -0700 (PDT)
Message-ID: <m3lk1ex3s6.fsf@localhost.localdomain>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
	<alpine.DEB.1.00.0806090033030.1783@racer> <484C73DA.10804@gmail.com>
	<alpine.DEB.1.00.0806090201090.1783@racer>
	<484D033A.3020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 13:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5fES-0002IL-15
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 13:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759530AbYFILHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759487AbYFILHR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 07:07:17 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:22658 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759440AbYFILHP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 07:07:15 -0400
Received: by an-out-0708.google.com with SMTP id d40so480752and.103
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=PKTTM6uY+xJIjHZzHyvRpzX29wQ1Gk7+7Os8c32DkrU=;
        b=sLXnGHoDCIwlcSeeYmNOwmxa/s8hPUXcig3WJEC0Hi0dWuMq65dqdb6spyXJEQlXh/
         MNezxTAcqhY43gr7io3t9ertl2Z1t7qHl7fvoAD1PoI/5kYA3OTCgLx+bnLqAEi2Dlic
         7w8w+O5VZeHYm6+0UUfjjCKUEq+A9ZIeFqW9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fsUNgE+pvkKiCePXQFKSUmu7JDxSDUyZo6XTkcYgfI9yGIvouTyibBLbKdQET9t9MW
         FwPjwvS0WdznCoV0DwpD8muZ6mBJm96EmVSBXDoMU3yIf9bPneJU1WGmhSmnpXYhYMYG
         B7qsdUjz6jZ7dUUNaE19sl6dO7Xoj9l/BhysQ=
Received: by 10.100.92.9 with SMTP id p9mr3370912anb.13.1213009634884;
        Mon, 09 Jun 2008 04:07:14 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.230])
        by mx.google.com with ESMTPS id c13sm19742182anc.32.2008.06.09.04.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 04:07:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m59BAI85015884;
	Mon, 9 Jun 2008 13:10:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m59BAH1P015881;
	Mon, 9 Jun 2008 13:10:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <484D033A.3020006@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84376>

Lea Wiemann <lewiemann@gmail.com> writes:

>  From a recent IRC conversation (with permission):
> 
> Dscho thinks that git-cat-file --batch should print an error and exit
> if passed an invalid revision (as opposed to the current behavior of
> printing "<object> missing" and continuing), since anything else would
> be unexpected. [1]  He says that an --ignore-missing option should be
> introduced instead, and cat-file --batch should exit on non-existent
> objects unless the --ignore-missing option is given.
[...]

> If Dscho (or anybody else) wants to introduce an --ignore-missing
> option, feel free to submit it separately, but please don't object to
> my patch because of it -- my patch is merely fixing the existing
> code. (Note that such an option is unlikely to make it into the code
> though, since it would have to change the existing behavior of
> cat-file --batch, which other programs rely on.)

I think the (usual) solution is to add --ignore-missing and
--no-ignore-missing (or --noignore-missing), add configuration
option 'catfile.ignoreMissing', make ignore-missing default and
deprecate it with some transition time...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
