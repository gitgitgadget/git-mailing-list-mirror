From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 21:03:48 +0200
Message-ID: <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
	 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKWN-0001RU-BA
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZBKTLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbZBKTLv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:11:51 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:56052 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZBKTLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:11:50 -0500
Received: by bwz5 with SMTP id 5so509406bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 11:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LBkzWp3EQexPwV5jYMN/vlyS+soXlmhWC+WDFgqCoOE=;
        b=EY2KApCWj+rafVOIzqSBUIdfFZt/kgBMPIkDN2WaV+/ZBCHNBu70cgAfHLgdN2ShoW
         lACLmjxfwVKVUQogSD3kzrYHbL+f2nP2RTEB0Z7TMUs7VdUGvrIHhxDb82PEtMl6DIam
         N2rOHZpYEkHOSurEJWHN3TnjOoDbj+2b9DJIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=APqH8t+8edqT4C86x0vxDHSCUsbLKSyNo9P31j4Iiv++9tg1Ewswl0uictqN0RyBYa
         dNznFap/0EnUWBrBJt6pzSoKnaXurX7Wl/UeitQ0TzZzCRD9ym3THQ6mAYo8bIVkjtJh
         ajTvq4bFb+eyBQ5XlJI7wRB3mI+9fa2zCdn6g=
Received: by 10.181.23.2 with SMTP id a2mr753325bkj.166.1234379028766; Wed, 11 
	Feb 2009 11:03:48 -0800 (PST)
In-Reply-To: <20090211184429.GA27896@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109505>

On Wed, Feb 11, 2009 at 8:44 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 08:42:25PM +0200, Ciprian Dorin, Craciun wrote:
>
>>     For now I see that the problem comes from the function
>> setup_git_directory_gentry which I call inside the setup_path function
>> in exec_cmd.c
>
> I think you probably end up calling setup_git_directory_gently twice,
> which is known to have weird interactions.
>
> -Peff

    Indeed it gets called twice...

    Here is what I'm trying to accomplish: I want to add to the git
search path also the folder ${GIT_DIR}/bin if this already exists...
(This allows me to have repository specific commands...)

    So in order to obtain GIT_DIR (get_git_dir function), I have to
call setup_git_directory_gently...

    Is there another way to obtain the right GIT_DIR?

    Ciprian.
