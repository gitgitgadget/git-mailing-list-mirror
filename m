From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via 'plackup'
Date: Sat, 22 May 2010 23:30:42 +0200
Message-ID: <201005222330.43532.jnareb@gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com> <1274392538-29687-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 22 23:30:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwHX-0002PD-2B
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758873Ab0EVVau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:30:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21200 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758278Ab0EVVat (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:30:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so830965fge.1
        for <git@vger.kernel.org>; Sat, 22 May 2010 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4WPzQ2wkF5qY8VjdhNbHJlduUEXdGRpQhGQTJfgTyAs=;
        b=MaIEle99bEALRxcQ1Haob/3/d1hXPannwuUf1t4SeyPH4msGTVXNiNEYvE3xr/kzlw
         8fc/RhS1/hBfAv5h6hs8cUB1DEqxYhwHHYOdoZktiYlcXwEbXc+c5lB/oLjaBfMAJflN
         iuv7N7QO66XX0RFzyOdS25jYERfEgjTv2iHgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=S8W4Lq29PjCJxJQJZrFmx1QpSh3v+nTVLRwYimrWah+O92CAu7DsLQ3+wOZd3tIKoX
         L7SZZBJVlfy96w7aSTtwbhFak9T9yfalRq/8AP67bHWshQ0mAuIeRgRfjdkO8OpiQOQl
         Az2zyOMniR++sElTfCHlaIeAs+jIg2p/OYLSo=
Received: by 10.103.125.13 with SMTP id c13mr2706482mun.81.1274563848250;
        Sat, 22 May 2010 14:30:48 -0700 (PDT)
Received: from [192.168.1.15] (abwk129.neoplus.adsl.tpnet.pl [83.8.234.129])
        by mx.google.com with ESMTPS id u26sm8986047mug.25.2010.05.22.14.30.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 14:30:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1274392538-29687-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147545>

On Thu, 20 May 2010, Jakub Narebski wrote:

> The configuration for 'plackup' is currently embedded in generated
> gitweb.psgi wrapper, instead of using httpd.conf ($conf).

A question: is this solution acceptable?  Or should the configuration
(port, address if git-instaweb was run with '--local', root) be in
a separate file.

Webrick, which is in similar situation, uses httpd.conf config file in 
YAML.  Unfortunately there is no config / serialization reader in Perl
core, so if we have to go this route either the config file would have
to be in Perl, or gitweb.psgi wrapper would have to include some simple
config file parsing.

-- 
Jakub Narebski
Poland
