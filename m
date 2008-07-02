From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: git push requires a subsequent git reset --hard ?
Date: Wed, 2 Jul 2008 17:45:11 +0400
Message-ID: <37fcd2780807020645h463cf232oba7886cda6d7a768@mail.gmail.com>
References: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
	 <m3vdzpfr16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Neshama Parhoti" <pneshama@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:46:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2ex-0004eK-Vj
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYGBNpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbYGBNpO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:45:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:59291 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbYGBNpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:45:13 -0400
Received: by yx-out-2324.google.com with SMTP id 8so85749yxm.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SdJ3V3llo/Q0dvKt6bLRPTIFmjufcXWdP5PF+y0H7B8=;
        b=Xc+/3YjV6RamCp7HXvdLqbtlR5yJo+yBbokvYirUNeYjllVOSmVFcsPgmqwVeBZB8t
         UHgeG7E8wjMRabXw9uqRh3YvbHiLH4oXms/n78Lb43qTRNsCTWOPiu+4KYaDi0aEx8P+
         WDnaRdLyPzOe//bnnoPgVCVFHTyH/wkyNR9ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tzUF124n8l8pNbKRkVnwBVAPMVrZuTXzNk2atLzeRyFOwfz/rSt4YffASirCzGOsyL
         ndJBa+1COUpl8JR+Da+o/irD5HJc/Qf79JobqgfJhlDs7xpSCWqS6Ilv2uYvyY/4GGEp
         uwaddYOAHXamzEokywlzcXpO3FIGJElmm8Mz8=
Received: by 10.143.30.10 with SMTP id h10mr3064224wfj.7.1215006311540;
        Wed, 02 Jul 2008 06:45:11 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 06:45:11 -0700 (PDT)
In-Reply-To: <m3vdzpfr16.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87137>

On Tue, Jul 01, 2008 at 10:29:38AM -0700, Jakub Narebski wrote:
>_
> This is considered normal.  Push would never touch index nor working
> area (although if you are the only user, and you know what you are
> doing, you can add "git reset --hard HEAD" to post-receive hook).

Doing "reset --hard" makes all your uncommitted changes to be lost.
OTOH, if you push on the local branch associated with HEAD then
recovering all uncommitted changes later will not be easy either. So,
I wonder, if git push should require --force to push to HEAD of a
non-bare repository. It will be at least some warning (especially for
novices) to not to do that, and those who understand what they are
doing can use --force.

Dmitry
