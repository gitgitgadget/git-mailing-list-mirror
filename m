From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: self contained executable
Date: Wed, 16 Sep 2009 18:44:17 +0200
Message-ID: <81b0412b0909160944xe2ae0b4u988e8ced7416e5f6@mail.gmail.com>
References: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com>
	 <81b0412b0909160113t7edf9b4vdd7b79ca0dae762d@mail.gmail.com>
	 <C3C630B6-7B54-42BE-9312-20BC20B7F051@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Joel Saltzman <saltzmanjoelh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnxf7-00065X-Bg
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 18:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908AbZIPQoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 12:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759902AbZIPQoR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 12:44:17 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38082 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759838AbZIPQoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 12:44:14 -0400
Received: by bwz19 with SMTP id 19so3630072bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OaC7virhrgLCkDBaDyPvIdBS0ESlvOJJtzCj8cphnpY=;
        b=iFwXxdYh3veSvByCZqOkj7PHtJfJkIbjJ1cqDB2PQ6nHHpFiGWiOR4b4nlZ2jWx9w/
         iCmbrCZ06rAy24u8fXf2sUzq7Z703xnYK1XMWh5sYNa7ED52fhxe/ocNne/KUU2oZVTp
         MCysr42tzK7fHDrmIV6lT5+q0dV0DZHrOKMxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bu71vIJwZqX4b3w3MkVPNlARUgGu7xAImDSN4yn1mwGDqh/J0PZ7RfU9XXd3+D/C9M
         4I00UPOBPelE7gzdvmq8dlecY/hEgtB0vsJCO0vM97r5z6SaDXz+QLlcz/J8QQVOKst6
         LmTN+oODsE4hAyqzKOLHDIeEhNC4YjDpmtbU8=
Received: by 10.204.23.203 with SMTP id s11mr7575795bkb.17.1253119457174; Wed, 
	16 Sep 2009 09:44:17 -0700 (PDT)
In-Reply-To: <C3C630B6-7B54-42BE-9312-20BC20B7F051@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128663>

On Wed, Sep 16, 2009 at 18:36, Joel Saltzman <saltzmanjoelh@gmail.com> wrote:
> The last part is what I am trying to figure out. How do I set those linking
> flags?

Below, I assume you're a familiar with compilation.

Open Makefile and find the line "Platform specific tweaks".
That should be an example(s) for variables to set. Don't
mind the ifeq's.
Open config.mak and put there all the -I$$HOME/... and
-L$$HOME/... you need to reach the missing headers and
libraries. Your configuration will override the preset values.

That's almost it: you have to find out what exactly you're
missing on your own (for example, you may actually have
curl and openssl).
