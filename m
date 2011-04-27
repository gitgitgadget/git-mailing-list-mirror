From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] run-command.c: Fix unused variables warning with gcc 4.6
Date: Tue, 26 Apr 2011 20:16:14 -0500
Message-ID: <20110427011614.GA14181@elie>
References: <4DB6BA5E.3040306@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Ericsson <ae@op5.se>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtMh-0004i1-CW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab1D0BQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 21:16:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60724 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab1D0BQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 21:16:21 -0400
Received: by yxs7 with SMTP id 7so284161yxs.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e7acOOmNcpmySozAcJ+SRse6fX7nYT3tg0w97YmeTyM=;
        b=AlsR8uylGR9IgIND+dmaT6+gXcI4BkQsTNSZosF4I9/LAjLNr+4K2Io0c6ce9uG1R8
         MZMdnw9g42wbXElBfAhoH66E9f+LxiDSLuERLAoPlm1U/Ena0VAnmhFg6LBxjneAGaLW
         I5RPBLapEkIUGS2JJIjU6VR9iX3N4Pr0DAJ7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dQRHBJZf3272+xqi8z0EgiE230bG2N7Ijav3SLhmil1v/4iuPrfGwKMqOF/Vc9YRJn
         hJ8yHisE7uz+6M8IIsH/kXLqtcIKoZUqAhWnI07ZAv0Va3ZSaE5Uc40l2sUfK5sVbn/m
         Eu7Ct7/xl9kkeu4V86UH6kqlrnhb+zY9b+HRQ=
Received: by 10.101.46.13 with SMTP id y13mr952045anj.136.1303866980957;
        Tue, 26 Apr 2011 18:16:20 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id c38sm300004anc.18.2011.04.26.18.16.18
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 18:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DB6BA5E.3040306@elegosoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172140>

Hi Michael,

Michael Schubert wrote:

> As of gcc 4.6 -Wall includes -Wunused-but-set-variable. Remove all
> unused variables to prevent those warnings.

As the other Michael mentioned, this patch replaces one warning with
another.  You might like a111eb7 (run-command: handle short writes and
EINTR in die_child, 2011-04-20, aka jn/run-command-error-failure in
"pu"), which eliminates both.

Andreas, a patch on top to short-circuit away the later writes on
error doesn't sound bad to me if you'd like, though it seems like a
bit of an edge case.

Thanks, all.
Jonathan
