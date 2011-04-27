From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 13:07:49 -0400
Message-ID: <4DB84D65.6070906@gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>	<4DB80747.8080401@op5.se>	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>	<4DB82D90.6060200@op5.se>	<BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com> <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF8Db-0004ht-EF
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 19:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573Ab1D0RH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 13:07:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45022 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759568Ab1D0RH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 13:07:56 -0400
Received: by vws1 with SMTP id 1so1470645vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:disposition-notification-to:date
         :from:reply-to:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ghQaWLSJygn5E6BaZhWrS1LLYW+nPVSmtqam4JgLaps=;
        b=f+0UyMPu1frCEObVMUESlXMxOv09bEV7MXRayJFkvSClJ5/HvJILTAn8/D+Dv3sW22
         vNgqgxfqBwUb+PcVHUihmncY+XOIxnUN6odsB7BxgC/S6qEIR/X2mKoZuFZaHtVa1X1p
         6gFD1GzJ1+30yrYrTFYHvQNifKdCCahrwLKnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=cge0JLm6Mw2o9XWuEhksn1u191xVtM6PLoQLIKAu/rqxjGnF0UUWI/LtomQ+aXTDer
         pUdsEW8BPyBvJ94kQVgNX98uzoi4GoGdx4oKvquMkmGLIyne3kuCH6ShgMUynOYU8oyJ
         sDHDU/BW5lqZakU90KA8fu6FA+QNWgaCIXFls=
Received: by 10.220.110.39 with SMTP id l39mr722596vcp.7.1303924076085;
        Wed, 27 Apr 2011 10:07:56 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id x29sm212573vcf.2.2011.04.27.10.07.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 10:07:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110307 Iceowl/1.0b1 Icedove/3.0.11
In-Reply-To: <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172245>

On 04/27/2011 12:13 PM, Jon Seymour wrote:
> I think my use of the word package was unfortunate, since it suggests
> I am proposing an alternative to tools such as apt-get, brew, rpm etc.
>
> This is not the intention. The intention is to manage _plugins_ to
> git, treating git itself as a platform.
>
> Plugins will be delivered via platform-specific package managers
> (perhaps sequenced by git-pm), but once they arrive on the OS platform
> they will be _activated_ by the plugin manager and this made available
> to the git command line.
>
> Platform specific concerns such as building and (most) dependency
> management will be delegated to platform specific package managers.
>
> The overriding objective is to allow a git user to install a git
> plugin called foobar with 4 words:
>
>       git pm install foobar
>
> given that someone, somwhere, has done the work to create a plugin
> descriptor and create an installable package of some kind for whatever
> package managers are required in order to successfully install the
> plugin on the target platform.
>
> The same command should work whether your git platform is hosted on
> MAC OSX, cygwin, Debian, Fedora, AIX or Windows.
>
> Where git can be used as the underlying package manager, it will be
> (for extensions which really are just source repos). If more
> sophisticated build support is required, then that will be delegated
> to a platform specific package manager via one of a small number of
> package manager adapters.

For a git plugin ecosystem to work, a (relatively) stable API/ABI is 
necessary for the plugin authors to code to. Where is your proposal for 
that.
