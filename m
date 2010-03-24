From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 14:59:00 +0100
Message-ID: <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
References: <20100323232055.GV7038@pixar.com>
	 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
	 <4BA9DCDD.6060109@viscovery.net>
	 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
	 <20100324134048.GB10190@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 14:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuR75-0003as-22
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 14:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab0CXN7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 09:59:09 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63357 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0CXN7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 09:59:05 -0400
Received: by bwz1 with SMTP id 1so2875749bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=MtiDLGlrFknZ9k7ql33MIsz1QArgSR+qwE7mEDlMFTM=;
        b=t9DCkhnd5nB/G6t06xi8eHfL/zm0eHNINYJPuYJUVLrFxi5Q+8o+3pSSt/aKKz5O0E
         ivDnBJspo98YSFOl9c1NcUr6olqldDSZ1Md0W8rRMtnUJ923Dpt9OO76dTBw6VZPsUH7
         LQ6Nd8DkolXJ0Ym63RQeMWR46AlbdhX3LzQh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OVExStFPIex9xKzcd5K/H2HezWZP/Z/x46oTSGds75Cl3vx2C8drQvBnfQRodRYgu2
         47EPH6/gniYv49yytDRPmxRWhA2VkuAJ1/0mJguq5xADEgwhPnHNCUnBaELGWckBNX61
         VzDoHqc4q+izPVREdwgeDdfEhdsFh7c0KkQr4=
Received: by 10.204.161.197 with SMTP id s5mr3230406bkx.90.1269439140754; Wed, 
	24 Mar 2010 06:59:00 -0700 (PDT)
In-Reply-To: <20100324134048.GB10190@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143085>

On Wed, Mar 24, 2010 at 14:40, Lars Damerow <lars@pixar.com> wrote:
> From Alex Riesen <raa.lkml@gmail.com>, Wed, Mar 24, 2010 at 12:37:39PM +0100:
>>
>> Isn't it a little pointless to look for repository when you can't
>> access its config?
>
> If you're doing the trendy thing of putting repository information in
> your shell prompt, then your prompt is looking for a repository every
> time you change a directory.

Right. OTOH, if you know that your .git is accessible (on the right
filesystem), but want to avoid scans in the directories below the top-
level working directory (submodules?), you may want to have it
configurable per-repository. The environment variable will affect
scan in all your repositories you visit in this session, which maybe
what you want, and maybe not.
And yes, the config option is also in addition to, not instead of
the environment variable.

> As for making this a command-line option: that's certainly doable, but
> it makes it harder to enforce the option's use across an organization.
> It's far easier for me to set an environment variable centrally on a
> thousand workstations than to convince a potentially large number of
> users to set a new shell alias for git.

Oh, I wasn't clear. I didn't mean "instead of". A command-line option
_in_addition_ to the environment variable. For one-off uses.
