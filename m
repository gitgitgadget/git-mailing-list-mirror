From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Git bug. gitattributes' pattern does not respect spaces in the
 filenames
Date: Mon, 10 Oct 2011 19:51:45 +0400
Message-ID: <20111010195145.0d1fc966@ashu.dyn.rarus.ru>
References: <20111010110221.38e9985a@ashu.dyn.rarus.ru>
	<7vipnwooh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 17:51:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDI8y-0000AV-Fc
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 17:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab1JJPvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 11:51:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50751 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1JJPvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 11:51:50 -0400
Received: by ggnv2 with SMTP id v2so4626623ggn.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=N6lEH8lTsh5thRi+V4uDcFmH8tzr4mp6BxS5cpPGUCw=;
        b=mD7bNj42dD4VW4SWDTRqEqjxOijJx+PRjzRF9FuCBqIAn6nwIPHJiGuBSnOsQhbewj
         VQs3hsQ9j5UbQYytOl/fDCCR6Lp6ezWjohvcyDzfG2TgVnwUakO7v4ng8y8386nxX+eE
         vmoY6vigBxoKq8yy21+XpIghyH5d65lue1oWA=
Received: by 10.216.229.41 with SMTP id g41mr6267808weq.62.1318261909794;
        Mon, 10 Oct 2011 08:51:49 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id p2sm33424258wbo.17.2011.10.10.08.51.48
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 08:51:49 -0700 (PDT)
In-Reply-To: <7vipnwooh1.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183245>

> Alexey Shumkin <Alex.Crezoff@gmail.com> writes:
> 
> > As far as cp1251 and UTF-8 files are in different folders,
> > it is logically enough to set pattern like
> >
> > <folder with a UTF-8-xmls>/*.xml diff=utf8-to-cp1251
> >
> > for the UTF-8 files.
> 
> ... IN the directory that needs conversion and not in the other one
> or at the toplevel. Problem solved, no?
Oh! yes! solved! thanks!
I did not take into account that each folder can have
its own .gitattributes-file

> 
> Another idea may be to use "?" in the directory part of the
> pattern. Unless the directory structure is sick enough to have these
> directory names:
> 
> 	dir-1/utf8-file.xml
>         dir 1/cp1251-file.xml
> 
> dir?1/*.xml would match the matter, so...

hmm... I like more the case above :)
but TMTOWTDI principle rulez

thanks again
