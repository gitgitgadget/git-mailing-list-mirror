From: Jonathan Nieder <jrnieder@gmail.com>
Subject: t0081-line-buffer.sh hangs (Re: [PULL svn-fe] vcs-svn:
 simplifications, error handling improvements)
Date: Sat, 26 Mar 2011 04:49:04 -0500
Message-ID: <20110326094904.GB7031@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie>
 <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <7vbp12gyqk.fsf@alter.siamese.dyndns.org>
 <20110326064220.GB20529@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 10:49:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Q7a-0002P5-G1
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 10:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab1CZJtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 05:49:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49538 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab1CZJtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 05:49:10 -0400
Received: by iyb14 with SMTP id 14so1333060iyb.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 02:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xmqcjs/qXPWFu6luyu8UsAo029PrMiZcX4C1GQJDsOE=;
        b=ekk87u/CrDBFVR+zyLQo4AurJv0f9N4/2mdl0QSz+BGo/LQWOFuG8ZHeeYZLF/lqtE
         Z962Htz3XtlKaxrNnBrKuYGSD4c9HAD3FEi2APyg768y/QFp7RPGlhfTP1TaW+4D4CkX
         TtMdm+bWVp58moYhFHw3asf7Ay4luV9Yzw7vA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uC1JHQG0QAwRx8rMHs7bP3kadZreakDAiZuDq2EtWKm4ZT4f0UxLJAtYqn8layXl1G
         34qjh0QiIG5CVOEZuSAi33oISCxD9LLHwNmMDbz+iMXg/+V0lzr6aq2fUOTw/2zPrgCV
         G3jdUvJOc9q1Vj76uPdrgXUvnqmmcCxCmK1gQ=
Received: by 10.43.47.194 with SMTP id ut2mr3039274icb.66.1301132949222;
        Sat, 26 Mar 2011 02:49:09 -0700 (PDT)
Received: from elie ([68.255.102.141])
        by mx.google.com with ESMTPS id c1sm1291407ibe.15.2011.03.26.02.49.07
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Mar 2011 02:49:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110326064220.GB20529@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170047>

Jonathan Nieder wrote:

> What is your /bin/sh?

Looks like

	prove --exec=bash t0081-line-buffer.sh

is enough to reproduce this, while

	bash t0081-line-buffer.sh

works fine.  And it seems to be racy --- with prove, sometimes the
first test hangs, sometimes the 13th, sometimes none.  Sadly that's
all there's time for tonight.

Thanks for catching it.

Puzzled,
Jonathan
