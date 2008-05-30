From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb forgets to send utf8 header for raw blob views
Date: Fri, 30 May 2008 01:18:14 -0700 (PDT)
Message-ID: <m3tzgg1a06.fsf@localhost.localdomain>
References: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Fri May 30 10:19:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zpQ-0003aw-8Q
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 10:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYE3IST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 04:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYE3IST
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 04:18:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6172 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYE3ISR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 04:18:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1675495nfc.21
        for <git@vger.kernel.org>; Fri, 30 May 2008 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=elpJT2HFkI9D2by1Ub2oGrqCv+B6zwMI+epv1dzzzms=;
        b=AwbX9Evu21Z2vjGFz92+iucdXzQcA1mAEAciIQlVeZ5cuO8vO3MeAEoJlj5Ste+n7iF5HRuqWSbmO/XUw1pc9Ra2WekR+TlCZhvTPPOOWPzc1ggZX68K0iIyJUG7qnJU2Y5XgS7RECneBu1uWf7T9EzJ4EZLqHmRLh80kRpOMQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=meh0Vk/MLl/nAb+pECCzYuej82q4QH7M9WUgkMZPnaGh58y7yxaA+HAe6w/xGciunj1B+QHhxUUSkvFZ8KjGmQ3NGTTYpR6NiIlPn3Z3CrpWIWAYg64h1RxotXKpMOz0Xm/QcpPOHtOXfz6ds5m1GKPJpx31LHoUFJ9qMCAjtXI=
Received: by 10.210.61.8 with SMTP id j8mr2461762eba.199.1212135495322;
        Fri, 30 May 2008 01:18:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.197.146])
        by mx.google.com with ESMTPS id c14sm2786859nfi.16.2008.05.30.01.18.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 01:18:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4U8HjSq022254;
	Fri, 30 May 2008 10:17:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4U8HTV7022250;
	Fri, 30 May 2008 10:17:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83277>

Jan Engelhardt <jengelh@medozas.de> writes:

> I have configured gitweb to use utf8, and that works for text blob views 
> like on
> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob;f=bin/git-forest;hb=HEAD
> but it does not for raw blob views like
> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD

This can depend on configuration, both on gitweb configuration (you
can for example define $default_blob_plain_mimetype to 'text/plain;
charset=utf-8', and define $default_text_plain_charset to 'utf-8'),
and on your /etc/mime.types; gitweb does not add charset info if
mimetype is acquired from mime.types, which I guess is a mistake.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
