From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Intricacies of submodules [was: Migrating svn to git with heavy use of externals]
Date: Wed, 9 Apr 2008 16:27:58 -0400
Message-ID: <32541b130804091327x475efc4cw978b336769f2ff9e@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
	 <47FBDA77.2050402@et.gatech.edu>
	 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <1207771054.13123.228.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjgv8-0007mZ-9e
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbYDIU2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbYDIU2C
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:28:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:25104 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbYDIU2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:28:00 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1271665nfb.21
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oclMeFmfOd52tIal0r/2rWSP+k+UzsAWGnqqOWt7CYQ=;
        b=YJbLh2EsB8HM0utGBAPmyVDnENqMr9pwruT/k4119ciIJnKT9xesVrKTntf5tDqTx0fYOWXNmjzd7avDs6Hpku5vBqTYdJLnXNtylvUDcHr19fpZvD6iIL7ze8WU+wqpuIa560gOk36S/vhelBiGRTj22uWmCxTLqr6NncNio5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=feMvSFyGclsHDm6f5c5HiUfHZypAnNqbHXE7MV/QUnafu0fYjhZiqb1dUo5s06vs8aIkxCL3Cmz8wLgQiCQXCtBtEYJc7Ln/xLJLv9wdFdXiB2fKqLA98IPn28/2x9oglPfYicZPNcE+WkwgaHKqrPO/eED7jnJcWZHdm97eCNg=
Received: by 10.82.113.10 with SMTP id l10mr880804buc.72.1207772878389;
        Wed, 09 Apr 2008 13:27:58 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 9 Apr 2008 13:27:58 -0700 (PDT)
In-Reply-To: <1207771054.13123.228.camel@work.sfbay.sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79131>

On Wed, Apr 9, 2008 at 3:57 PM, Roman Shaposhnik <rvs@sun.com> wrote:
> On Wed, 2008-04-09 at 02:34 -0400, Avery Pennarun wrote:
>  > So everyone will have all the necessary refs anyway; as long as
>  > git-checkout checks them out, .gitmodules shouldn't have to exist at
>  > all, becaues there's nothing "special" for git-submodule to do.
>
>  I would very much like to have that, yes. Please do provide additional
>  details on how's your setup is different from mine.

Sorry, I wasn't clear.  I meant that there's no fundamental reason
that this shouldn't be possible; as far as I know, there's no way to
make git do this in an obvious way (yet).

It's encouraging that other people seem to want the same behaviour as
me, which means I might get to working on it sooner :)  Not that this
should discourage you from trying, of course: perhaps I'm just missing
something too.

Note: I think a big part of the secret is using "." as the location of
the submodule's repository in .gitmodules.  "git submodule add" seems
to expand . to a full path, but you can change it by hand if you edit
the file.

Have fun,

Avery
