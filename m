From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v3 4/5] pretty: add infrastructure to allow format
 aliases
Date: Sun, 02 May 2010 10:01:50 +0100
Message-ID: <1272790910.4258.16.camel@walleee>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
	 <1272656128-2002-5-git-send-email-wmpalmer@gmail.com>
	 <7vhbmryp10.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 11:02:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8V3s-0006h3-7V
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab0EBJB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:01:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60967 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab0EBJB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:01:57 -0400
Received: by wwb34 with SMTP id 34so1053473wwb.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=PKvZJjlHr+QO39v9SiwSlCn9Jblyu3uJ+pEr3p5z8hA=;
        b=TRxbRsG2gIR87f3ARZ+wKEUj914ZvUBlaV74KNcQ/k2t+laVO0C7IMIPsN53DXnWfS
         7T4YKZD9n+H5//yEgZKMYgMpgxhfiTcX6wQWZdvl+sXTHl9XHY035YtwRQ1FSkcpKCTy
         3e4OUzynwQKM1+Su8kJ26iKGPDnrtCZ1sWWNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nSLwseymMrZ9GW/8Qv7ImIOofQEkq2pKMr+syLh//UzuFcr+WdSBHchy/ypR6osF7C
         eOKBqVmdbdz1KP4bOGcV4+QOYwb3Oa9MMsQ/rxl9E1MdebTub0+OY8EAy0unckyNWL5s
         B5dzZgKkczh/n9E3+Rdkj3RJ46ZBdn11UeWGc=
Received: by 10.216.187.204 with SMTP id y54mr422305wem.136.1272790913082;
        Sun, 02 May 2010 02:01:53 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm31455566wbv.15.2010.05.02.02.01.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:01:52 -0700 (PDT)
In-Reply-To: <7vhbmryp10.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146148>

On Sat, 2010-05-01 at 20:13 -0700, Junio C Hamano wrote:
> I however wonder if we would want to be more helpful to the users to
> diagnose this error by saying something here with error(), instead of just
> letting the caller say "invalid --pretty format: %s".

I suppose there's not really any sane reason why we wouldn't be able to
die then and there. If we pass the original name into the recursive
function, then the message could be:

"invalid --pretty format: %s references an alias which points to itself"

sound like okay wording?

-- 
-- Will
