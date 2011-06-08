From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Wed, 08 Jun 2011 10:14:22 -0700 (PDT)
Message-ID: <m3lixcdz67.fsf@localhost.localdomain>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMKr-0003xI-AV
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1FHROY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 13:14:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62012 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab1FHROY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 13:14:24 -0400
Received: by fxm17 with SMTP id 17so468090fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=m1QEQh4WypuExGFdQpUDELlofryLUMfPG2At6ReVoJg=;
        b=LzvxhIHFStG231zYgcyCrFgesT/9TpTOuMPi1meQC/UEnFfqChpx90Nv2mugQHxcsU
         LoIKHLxb38pVcBfA3+s2albzkcjUoc6npMfp6sIW1f+NOkjB75iwDJJ8njjfnLfahoz5
         3H/MZxXomlPjTGqSHg9aCA6i4HB1/tHldKB9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=qemMS5rSlIWh2qBN+IBmLCoIK4X4DDdR6OuMQj9dC99kZ3QGqVbGdlBtd3AuJO9ldF
         AiFoidX+rWEOONbM8pOiFtWjB36Rc49JsLO2SjejVTY+6WHmL4ru1tzhcREQSULYrG6N
         AG4pwCoNGD1bz2eDCDIEivgB6H3RPHxmYW+70=
Received: by 10.223.6.11 with SMTP id 11mr3303608fax.92.1307553262980;
        Wed, 08 Jun 2011 10:14:22 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id q10sm321370fan.8.2011.06.08.10.14.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:14:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58HDjEM020132;
	Wed, 8 Jun 2011 19:13:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58HDKli020122;
	Wed, 8 Jun 2011 19:13:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175406>

Claire Fousse <claire.fousse@ensimag.imag.fr> writes:

> The problem is not the feature in itself but the way you call it.
> Just so you remember, here is the command  to clone the mediawiki :
> git clone mediawiki::http://yourwiki.com
> 
> As it is now, git clone does not implement a way to define a set of pages.
[...]

Well, what you need to do is to implement API for partial _clone_ (we
have some SPI for partial checkout, but that is slightly different
beast).

Currently we have --depth=<n> to limit depth of history when cloning,
and "git remote add -t <branch>" (repeated if necessary) to consider
only a subset of branches, though unfortunately not in "git clone"
yet.

Not what you wanted to hear, I guess... :-(
-- 
Jakub Narebski
Poland
ShadeHawk on #git
