From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Thu, 15 Apr 2010 03:02:47 +0200
Message-ID: <201004150302.51242.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004150225.42101.jnareb@gmail.com> <7veiihmtjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 03:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2DTR-00018F-Lh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 03:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab0DOBCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 21:02:24 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:51967 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab0DOBCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 21:02:23 -0400
Received: by bwz25 with SMTP id 25so919598bwz.28
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Hv8yU5KxCHT6Zf7Sp1dYKlOIQLgrKDeMnLN6YEFGPOE=;
        b=O0GJesoDZIJJl5ls4RqNo6h5DsR9GcycG38vD81O+FS0i4DxkftFq/0j74Oxd6Omyu
         Fod0KJBCG6/WfE+LBsYSRt2tCrEtQMw7AXFpewxU24nJtsEPSID6XfFPEGRtB6uTZT6K
         LgBptXjJLrCcm4/WDTR6ZRx4jiyJ18BALbjsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QIBkh77t3834ouXw1Xx2TsD3linIPO9R/vbsrWdbXQKdG8LKp2xt/1IEGfiZSiuLMG
         lGC0+n2XJ2fEjbAmSWip3KK4OqcnetNcSQCPBSym/509t1Y23UR8m43DEoGtP3dv/PM5
         Pgpn7D+XLwZhMJZwuTahdEIvNbZXgC+BwuzsE=
Received: by 10.204.131.80 with SMTP id w16mr2074180bks.35.1271293340191;
        Wed, 14 Apr 2010 18:02:20 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 14sm811086bwz.2.2010.04.14.18.02.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 18:02:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7veiihmtjw.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144937>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> >> -gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
> >> +gitweb.cgi: gitweb.perl
> > ...
> > That makes gitweb.cgi not depend on gitweb.min.js, not gitweb.min.css.
> 
> That is what I inteded to do.
> 
> Unless you are including gitweb.cgi (iow, the contents of the generated
> file depends on the _contents_ of gitweb.min.js (or gitweb.js), gitweb.cgi
> does _not_ depend on these files.  Of course if you generate gitweb.cgi
> out of gitweb.perl with one setting of GITWEB_JS and then change your
> mind, then you need to regenerate it, but that is not something you can do
> by comparing file timestamp of gitweb.cgi and the file timestamp of
> $(GITWEB_JS) anyway.  You would need to imitate something like how
> GIT-BUILD-OPTIONS is used by the primary Makefile.

Right.  I agree.

P.S. This is nt the case with git-instaweb, which literally include 
gitweb.js or gitweb.min.js...

-- 
Jakub Narebski
Poland
