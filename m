From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.perl suggestion
Date: Thu, 8 Jul 2010 21:01:40 +0200
Message-ID: <201007082101.41286.jnareb@gmail.com>
References: <19509.14862.368282.470934@winooski.ccs.neu.edu> <m339vum1od.fsf@localhost.localdomain> <19510.3108.337932.666012@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwM1-000862-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360Ab0GHTBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:01:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33874 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0GHTBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:01:43 -0400
Received: by fxm14 with SMTP id 14so612078fxm.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=svOY5oRU97CWRBvNgqKbDEMogwIsm2CgAmTQIMN6+Hg=;
        b=RioK/1XkvTJKNtOfFsZ4QTNkYbW1YfBv4aUQMZEhOA5JH59EFMOfBZcJNFzUluypg7
         vZQjPrj4Ijc8vqzVZC8Gp42/TrC19eEns3gUbpE335v1HGWmT5LummQ+HsQ13k67H1kw
         HJzKf+fSKY1dkXwdheuhuLbkiUV0wA0R5e0dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Mb6q0XhzSLY6emPiB97WHIFHRyFdZKYO+0uzH+jMYcPnbyYeEN/VEblLpIPQ24Mvrs
         4fRnM+3eY17sVOhGPce1a6EXokUsA6rff054T7AeUmi3wE25AIlM2eROMzIXuDnsL8BJ
         5SUtKf8MllpdhWEoi8+pNzY/WiyXE/+P5uB+A=
Received: by 10.223.112.75 with SMTP id v11mr7452207fap.106.1278615701776;
        Thu, 08 Jul 2010 12:01:41 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id 24sm16684890far.12.2010.07.08.12.01.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 12:01:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <19510.3108.337932.666012@winooski.ccs.neu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150595>

Eli Barzilay wrote:
> On Jul  8, Jakub Narebski wrote:
> > 
> > So your proposed solution is good enough, but perhaps better would
> > be to leave 'action' unset if there is no parent info?  Then
> > dispatch would guess action, instead of doing it in less
> > sophisticated way in evaluate_path_info().
> 
> Ah, looking at the dispatch point, I see what you're talking about.
> But that sounds like a larger change to the code -- since it would
> probably lead to more default actions that get determined in dispatch
> instead of earlier.

I don't remember if it was the real reson why http://gitweb/project/<object>
defaults to 'shortlog' action, but <object> can be commit, but can be also
tag.  The 'shortlog' action makes sense for both... assuming that tag
points to a commit object, that is.

P.S. As usual, patches welcome...
-- 
Jakub Narebski
Poland
