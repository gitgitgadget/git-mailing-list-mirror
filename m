From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 23:39:51 +0200
Message-ID: <201107292339.51753.jnareb@gmail.com>
References: <1311934832699-6632987.post@n2.nabble.com> <m3pqktql6s.fsf@localhost.localdomain> <4E32B637.1030201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: llucianf <llucianf@gmail.com>, git@vger.kernel.org,
	Ferry Huberts <mailings@hupie.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 29 23:40:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmumr-0000Ju-SR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 23:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1G2Vj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 17:39:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42522 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1G2Vj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 17:39:58 -0400
Received: by fxh19 with SMTP id 19so2644545fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lFPWqtFvT6UdKCcRacxm1gBcpqXWAS9APfbW8aqUI4A=;
        b=Gw3d0y4ghCn5XvV8lbOambjCZatGpiPjCeDW5juerHN8utMOqeZCcnGPIG2LbHXKgZ
         oQbaUTHqb3WiBQL4ZI+9WCaVS0lYgt/GE4XAUDk5c6nndWuQcTMQBXSdyx3nuxZXfmyp
         RxqxuM9xj0bN0YgMmsN6Q38am+YKm1YIZOL+4=
Received: by 10.223.91.75 with SMTP id l11mr2421191fam.66.1311975597762;
        Fri, 29 Jul 2011 14:39:57 -0700 (PDT)
Received: from [192.168.1.13] (abvz37.neoplus.adsl.tpnet.pl [83.8.223.37])
        by mx.google.com with ESMTPS id j18sm502411faa.22.2011.07.29.14.39.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 14:39:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E32B637.1030201@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178168>

On Fri, 29 Jul 2011, Johannes Sixt napisa=B3:
> Am 7/29/2011 15:19, schrieb Jakub Narebski:

> > Are you sure?  It seems to work as I thought it would.
> > [...]
> > Notice that change to 'bar' didn't get comitted.
>=20
> Of course, it didn't get committed, you promised not to change it, so=
 why
> should git commit it?
>=20
> However, your example does not show the dangerous part. git-commit is=
 not
> dangerous. But you might run into trouble when git has to merge conte=
nt
> into the worktree or index; in this case, git may decide to just read=
 the
> file instead of to unpack an object - assuming that the content on di=
sk is
> identical to the unpacked object (it will do so because with
> --assume-unchanged you promised not to change the file). If you broke=
 your
> promise, you get to what you deserve ;)

True, it is *assume-unchanged*, not ignore-changes bit; though the latt=
er
would be also possible to implement, I think... but having some file no=
t
changing and marking it as such for better performance is saner use cas=
e
than tracking some file but not really tracking it.
=20
> No code reference, sorry, because I'm just parrotting what I've read
> elsewhere on the list, for example,
> http://thread.gmane.org/gmane.comp.version-control.git/146082/focus=3D=
146353

Well, there is hint that there might be problems, but not really says
that they are, and where (if one is lying about assume unchanged by cha=
nging
assume-unchanged file).

--=20
Jakub Nar=EAbski
Poland
