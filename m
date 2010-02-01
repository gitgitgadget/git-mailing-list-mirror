From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Mon, 01 Feb 2010 12:10:04 +0100
Message-ID: <4B66B68C.7050505@gnu.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org> <20100201075542.3929.35967.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 12:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbuAc-000538-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 12:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab0BALKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 06:10:12 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64234 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0BALKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 06:10:10 -0500
Received: by bwz19 with SMTP id 19so351976bwz.28
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=RKBk8h/dsZjR3S+p6hka+XxwnDWHA3vT9bk7adnkk+8=;
        b=W6//shesge+e4tHDjKfIdz7wnqmYFoiRNSbL5vcNKEv0B7Up3auvjmCIDG1Pb1SurP
         WNGfUBRaZfbflyNoARTSqEOqv9hKkOIiNR8hCvpkdIPXIe0nylpbq0p/lvM0YclD/gJX
         yMqf5IiX0cV4VExAG0Njk0U31qDPL8+GNIGQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xLZlhe/IAorWgNqWuudJ+HzpBJhy95AXUVys0P19RU8wMc80XCrEbajgLapfQ0W6B8
         4TIwPuGmAXEDb1Ivc19N7uBlPjy0Ko3k8b+4pIsm0CTOyAuHDPhu53EngiiQuV4i3bq+
         YSydc5BvXCCrCyksJ33ymVEMkIBtfhS/gbwIc=
Received: by 10.204.148.89 with SMTP id o25mr2834134bkv.129.1265022608627;
        Mon, 01 Feb 2010 03:10:08 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 16sm2032820bwz.15.2010.02.01.03.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 03:10:05 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100201075542.3929.35967.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138600>

> +		OPT_BOOLEAN(0, "ff",&ff_ok, "allow fast forward"),

Why should this not be the default?  Instead, you'd add --no-ff.  This 
would simplify 6/6 further, like

   eval sha1=\$$#
   ...
   output git cherry-pick "$@"

Paolo
