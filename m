From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Checking out messes up execution bit
Date: Sat, 6 Nov 2010 20:11:24 -0400
Message-ID: <AANLkTimCm7f445K-RhK4cPhvccVP7LcdQPCxRQ+uVzcW@mail.gmail.com>
References: <4CD5C478.1010604@physik.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Manuel Strehl <manuel.strehl@physik.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Sun Nov 07 01:11:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEsrI-00073q-PE
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 01:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab0KGAL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 20:11:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64744 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab0KGALZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 20:11:25 -0400
Received: by bwz11 with SMTP id 11so3777979bwz.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=6xNQzyRYzqhesuexBQoyropSNVlfLPu+YfIhqIKJh6I=;
        b=nHMwLj6bhHF1IBs2a0PU3VwpY7v/aW751qJzBN4he/vk0+gSAh+2C+zNK7BfznwnzM
         aCSZltRN9812Zcm1FK/eVJHng8mpuucO/oWfc6fKduu2nJ2pQWEFRIoKvj+o8WwxdPP2
         diLhYuMVrrYgwloP2ScY2p/LplZ1/iVDksDy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=v2+kJRwEP4oN2h0EFJLeMbzWKZy7Gcoq3aHdmmmApMdegukwNXhsbDouIt4x+174lH
         VBA0LJi1Chn7SIyzLJ2gMxmDiQTmV4+PFYoqwqOl0YrUjtY1gV1qpq+sFyn/pTrGxQc0
         L15XipNuVj/FQg1V84JvYQ5IOBHHFUMSrXDg4=
Received: by 10.204.62.3 with SMTP id v3mr3359702bkh.99.1289088684463; Sat, 06
 Nov 2010 17:11:24 -0700 (PDT)
Received: by 10.204.4.153 with HTTP; Sat, 6 Nov 2010 17:11:24 -0700 (PDT)
In-Reply-To: <4CD5C478.1010604@physik.uni-regensburg.de>
X-Google-Sender-Auth: y8ilW7B9Exw5pJkO0b4-CrE_ekc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160862>

On Sat, Nov 6, 2010 at 5:11 PM, Manuel Strehl wrote:
> To put it in a nutshell: I edit and commit a file in branch "master", then I
> check out branch "dev" and the edited file gets the execution bit set. This
> leads to a working copy differing from the content of the index. It's
> especially painful when I try to merge "master" into "dev", which fails
> then. I'm working under ext4 and Samba/CIFS, respectively.

This is because CIFS does not support the execution bit.

> One answerer at superuser thinks that this looks like a bug in git itself.
> Therefore I'd like to check with you, if there is possibly another
> explanation for my observation, before I issue a bug report.

See core.fileMode in "git help config"

Peter Harris
