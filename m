From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/3 v3] minor gitweb modifications
Date: Wed, 29 Dec 2010 14:41:40 -0800 (PST)
Message-ID: <m3fwtgcido.fsf@localhost.localdomain>
References: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Dec 29 23:41:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY4iK-0007yg-Di
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 23:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab0L2Wln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 17:41:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36302 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab0L2Wlm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 17:41:42 -0500
Received: by fxm20 with SMTP id 20so10820938fxm.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wXK8h4MGJEwhMsi/vha7jfr2lMeeL/5VuX8dfQUX+WE=;
        b=Dl6yNG73KA8Kj4b/n8wvaryOTHwIn8gK9Xns2ZsSMuu0pC9IahP3WDnkkcr7hpqeJX
         Lg0BXigqFXxN3b31aItGlnCRxbeI4adkQg4a4SnFIrK/hb2a0fqaIy/lJpC8x+5JLFwi
         0MOvrUhOX7r32Q8FBql0bbPjtIB5o1XqRqtSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pdVU4jRGR4y6NuaOnHuqskLbKJCV13ipegqkhQe/kVOm/L5VLJRW7VFtoqcKBPOl97
         Wub8/Lp6xjezKbIJOWVt2z/T/BDyCXe3Okck9epiLbHC/P5iA6nyLQia9cV4bC/uX5C6
         hUeRy6QeT1Xdl0+caLeUvSSOQTKJJNRozSnz8=
Received: by 10.223.96.198 with SMTP id i6mr1175531fan.10.1293662501638;
        Wed, 29 Dec 2010 14:41:41 -0800 (PST)
Received: from localhost.localdomain (abvc66.neoplus.adsl.tpnet.pl [83.8.200.66])
        by mx.google.com with ESMTPS id e6sm3645786fav.8.2010.12.29.14.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 14:41:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBTMf95Y027217;
	Wed, 29 Dec 2010 23:41:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBTMepF0027213;
	Wed, 29 Dec 2010 23:40:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164337>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> here a three patch serie with minor updates for gitweb based on master.
> 
> This serie has been improved regarding the comments of :
> 
>  - Jakub Narebski <jnareb@gmail.com>
>  - Jonathan Nieder <jrnieder@gmail.com>
> 
> Regards.

A few comments, in this version about commit messages, not the code:
 
> Sylvain Rabot (3):
>   gitweb: add extensions to highlight feature

It is about adding support for supporting additional file extensions
for syntax highlighting, not about extending the highlight feature or
adding some plugin thingy to it, as one can think on first read.

>   gitweb: remove test when closing file descriptor

It is about closing open pipe (file descriptor) without checking for
error in the case where we don't care about errors in the caller; in
short about not testing status of closing filehandle in git_highlight

>   gitweb: add css class to remote url titles

It is about distinguishing visually type of link using styles; adding
CSS class is just a way to do it.

This actually has few comments about code.

> 
>  gitweb/gitweb.perl       |   18 +++++++++---------
>  gitweb/static/gitweb.css |    5 +++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> -- 
> 1.7.3.4.523.g72f0d.dirty
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
