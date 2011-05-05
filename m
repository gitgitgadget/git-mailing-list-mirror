From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 5 May 2011 10:38:39 +0200
Message-ID: <20110505103839.2a051583@mkiedrowicz>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
	<4DC2418E.4070006@viscovery.net>
	<20110505094147.22e3d158@mkiedrowicz>
	<4DC2567A.1060502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 05 10:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHu5B-0003tV-2G
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 10:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab1EEIio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 04:38:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54399 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab1EEIin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 04:38:43 -0400
Received: by fxm17 with SMTP id 17so1368531fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=n6ZnHexrwC8ww8i20TYanokXDHW2aZnbalAgywaP8nI=;
        b=lulf4ruwtFy/V0HDBlxQbxlOBN0fg8Vw7PMvmAqckcTjYixDSevokRqsCm/bhtjmGV
         9cs7QknL05jfylz+0vBcECU8IeL/druyHK+NfIt5KyfsOMgOVwYnVEIQwqv4UNd7YPXi
         JVl6V5m3tIaWWkrN4RkUFuIq7UCsgysxdy1uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=K6s6QU11J04RHeuKJEUKK74SZAVqgwUl6lC/UZWe9wsz6B77w0ojzp2lYSG6HUgeM4
         E4NkC8wr/nGonPdq6lr5OUijcBDz96VUFViv2nXTNGyyPYRVLqZoc/qbzcqfc/+87d/c
         78TRvkIeZ0/RvJAmP7ilWQ4dXqsvpKpBSu9j4=
Received: by 10.223.59.81 with SMTP id k17mr2423723fah.94.1304584721900;
        Thu, 05 May 2011 01:38:41 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl [153.19.128.10])
        by mx.google.com with ESMTPS id 13sm659163fau.40.2011.05.05.01.38.41
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 01:38:41 -0700 (PDT)
In-Reply-To: <4DC2567A.1060502@viscovery.net>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172817>

On 05.05.2011 09:49:14 +0200 Johannes Sixt <j.sixt@viscovery.net> wrote:

> Am 5/5/2011 9:41, schrieb Michal Kiedrowicz:
> > But I can abstract these calls to die_pcre_not_supported() to not
> > repeat die() message.
> 
> Gah! Don't over-engineer. The compiler will un-duplicate the message
> texts for you if you carefully copy-and-paste them.
> 
> -- Hannes

The whole point of using die_pcre_not_supported() is that it'll take
care of this "if you carefully copy-and-paste them" and remove
redundancy in _source code_, not binary. But still these die()'s are
minor nit (IMO).
