From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 21:36:35 +0200
Message-ID: <200904292136.36987.jnareb@gmail.com>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de> <0626233F-50D5-4F7E-9009-506FEA77571D@aepfle.de> <200904291514.11331.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFaP-0000Ei-P1
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 21:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZD2Tgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 15:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZD2Tgp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 15:36:45 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45155 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZD2Tgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 15:36:45 -0400
Received: by fxm2 with SMTP id 2so1394977fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5ovRjnstIK0DvejUVG/13BWoiXINHX6BysNLMp/zNx4=;
        b=KgxPjGE7v0Hb3Dxj1N0NN0Ec3j+wUX0SDQy0DZt6FFpAjh5r97ksXSsb+2OFJbwZen
         Gygu0IeSzuMhSsHjitWYb9DaR7wYISD1o3eenhAXMLHwUmgjz0WJCCsSiHDtqAM77rW7
         fNBKQ+b0Pi0WwoOUA/v30LBvOIpfXM+RuF74w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yydt98e2iJJzLz76AGxx8lTQDK1S3gqOfXFVhkzk8TJ92eepgHUw9LjsKUPzXDoFv4
         BYKyiUri3v4nknDHWIj2PtWCegdM3ZZD6EAgK/Ev18Yj4TO2rQH3VD/iFxkkzVO2vRyG
         CPTLpAk7occfZK3AF1bqwFzG5ZZYEnCIRKFB8=
Received: by 10.103.175.8 with SMTP id c8mr431508mup.117.1241033803583;
        Wed, 29 Apr 2009 12:36:43 -0700 (PDT)
Received: from ?192.168.1.13? (abwr45.neoplus.adsl.tpnet.pl [83.8.241.45])
        by mx.google.com with ESMTPS id j6sm3465837mue.1.2009.04.29.12.36.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 12:36:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200904291514.11331.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117929>

On Wed, 29 Apr 2009, Jakub Narebski wrote:
> On Wed, 29 Apr 2009, Olaf Hering wrote:
>> Am 29.04.2009 um 14:28 schrieb Jakub Narebski: 
>>> On Wed, 29 April 2009, Michael J Gruber wrote:
>>>>> 
>>>>> It should be s=torvalds%40linux instead of s=torvalds\@linux
>>>
>>> If you by hand edit URL changing '\@' to simply '@', does changed
>>> gitweb URL works correctly?
>> 
>> I tried akpm@osdl.org, and @ and . was escaped with a backslash.
>> Removing both, and using the plain mail address worked.
> 
> This problem was fixed in 7e431ef (gitweb: Separate search regexp from 
> search text), but this fix is present in git 1.5.2 and later,

I have just checked that current gitweb (1.6.2.rc1.20.g8c5b)
does not have this bug...

> and kernel.org gitweb is a fork (adding caching mechanism) of
> 1.4.5-rc0 (according to info in git.kernel.org HTML source), and
> it does not have this fix.
> 
>   http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary
> 
> I have CC-ed J.H. on this.

... so J.H., or Lea Wiemann, or whoever manages gitweb on kernel.org
should backport this fix to kernel.org's fork of gitweb sources.

-- 
Jakub Narebski
Poland
