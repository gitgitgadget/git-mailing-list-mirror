From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 01:44:18 +0100
Message-ID: <201012090144.19858.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082047.44022.jnareb@gmail.com> <AANLkTi=AyCxn=dcKQQmT0_6Oc36AX6XDA4Dhhk7WLSN0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 01:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQUcd-0002ln-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 01:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab0LIAoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 19:44:32 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39976 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab0LIAoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 19:44:30 -0500
Received: by fxm18 with SMTP id 18so1780787fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 16:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ws6XD9o1H5nDkxOzU6T/vCuRKNo9oSrRGhjbrcy+Y/A=;
        b=alKxWoIBus+Q/ryo4K4c2L2e9sNFBm+XmvSfMF3xONCYEO++lUD9zer1rtWgDAUBQ6
         sQ+SyxdF+vpHkJUredGUjL3k+TqtB2gD6K9K+7UktweqGXb8XfxAcs1oslCviRDQdI1q
         pAaLnOtmV0fxOn18WHSvMKqLNl5cramBn/xsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KL/pgDCJjtJtcntVqawDDASWFIXD43lHhKpeKZXu4jTuE0An/woJeAbajTO65P8zmO
         XGlvj08VzkG7lO9Vq+4c+UHI8h2Oow+U0RUc8Df7B3ujc6HY1PWxpPbjIFt6ygPmuDXP
         dBaKhFRe71OauwXbV47QI70QQpLeHZYjn50K4=
Received: by 10.223.54.132 with SMTP id q4mr417231fag.117.1291855469567;
        Wed, 08 Dec 2010 16:44:29 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id f24sm365089fak.24.2010.12.08.16.44.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 16:44:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=AyCxn=dcKQQmT0_6Oc36AX6XDA4Dhhk7WLSN0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163249>

On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
> 2010/12/9 Jakub Narebski <jnareb@gmail.com>:

> > I wonder if it would be possible to make :/<regex> (which looks a bit
> > like searching the index) to be an alias to --all^{/<regex>}...
> 
> It looks a bit strange to my eyes to merge normal option name with
> revision syntax. But I think it's possible. Do we allow branch/tag
> name with leading '-'?

Well, with below proposal it would simply be

  --all ^{/<regexp>}
 
> > Or if we can make ^{/<regex>} to act on revision range specified by
> > earlier commits, so for example foo..bar^{/<regex>} would work.
> 
> There is another case: branch/tag selection. Instead of looking in all
> refs, people may want to look only in nd/* branches. My branches are
> almost flat, so I don't find any use. But someone might. And we can
> solve the "all branches" case above with simply "*". The exact syntax,
> I don't know.

  --glob=heads/nd/ ^{/<regexp>}

Similarly to the --all case.

-- 
Jakub Narebski
Poland
