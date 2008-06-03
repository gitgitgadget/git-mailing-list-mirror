From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Tue, 03 Jun 2008 02:20:57 +0200
Message-ID: <48448E69.30203@gmail.com>
References: <7vy75oalh7.fsf@gitster.siamese.dyndns.org> <1212358587-15948-1-git-send-email-LeWiemann@gmail.com> <7vfxrwa008.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3KHr-000401-MY
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbYFCAVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 20:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYFCAVA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:21:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:21354 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYFCAU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:20:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so882276fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=b1En40egyPX7Log4uV1ylGmNHJ+cUhUXUefF1+4izaw=;
        b=JdylmfQWOR0wJtB0jmk3hfE+v9AR+oSfHgmMoP3fw8X+QO8b0ff+KqSqi9O+VFX3t8ybxau5tMHVAkUk9KiifTkuUiInE/cLOQQLqs2Qrc53LYqVNoGhfs1wpQjMAu/r2K/BgwSOjytBUCiv4Db3nPBl4GFu1OwNDprxXBCooxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=FoLAqoX4ZQCvAGlNlVY/c2WJcMo655PRuvK3dF/WTvZTgEgg8u6aDT6aCYz7eoiLFsChVLcuH7r/oHzaP69a51yonlFw9mUqoWPngwb16TSXYzJM4UtzfvxBYg/pvtaFiZu+hkbj3RpAmnQ2rRyMzVzqEHQfA0V5FIADP46nfD0=
Received: by 10.86.82.6 with SMTP id f6mr1727417fgb.73.1212452454595;
        Mon, 02 Jun 2008 17:20:54 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id o11sm11857360fkf.16.2008.06.02.17.20.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 17:20:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vfxrwa008.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83600>

Junio C Hamano wrote:
> the primary Makefile has this rule to munge our perl scripts:
>
>                 [snip]
>                 sed -e '1{' \
>                     -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>                     -e '	h' \
>                     -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
> 
> so that people do not have to have that path on PERL5LIB in their
> environment when they use [...] scripts that do "use Git"
> 
> The real fix to the issue [is]  to fix the build
> procedure of gitweb/gitweb.perl so that the above script rewriting is also
> applied to it.

I'm not good enough with sed to fix this, so if anyone wants to write a 
patch to the Makefile that adds "use lib (split(/:/, $$ENV{GITPERLLIB} 
|| "@@INSTLIBDIR@@"))" to gitweb.perl, please go ahead. ;-)

-- Lea
