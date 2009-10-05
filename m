From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: previous references
Date: Mon, 05 Oct 2009 23:11:07 +0200
Message-ID: <1254777067.26111.105.camel@localhost>
References: <8E72DAAF9F8E4024BB819F3F83CCFC79@teddy>
	 <200910041127.29588.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Octavian =?UTF-8?Q?R=C3=A2=C5=9Fni=C5=A3=C4=83?= 
	<orasnita@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muuri-0006cn-2a
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbZJEVMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbZJEVMQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:12:16 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:41025 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbZJEVMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:12:15 -0400
Received: by ey-out-2122.google.com with SMTP id 4so668415eyf.19
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=afV4BgpwvFYPuLyA8tQ6rTc54CwzSBnyEuDb+5UQtt8=;
        b=hNV5hluSOmsGuEi3IA0/dUEBNHkZSLfD1kAtZb01N17wPdfHfAQwNo63VtyV+OqVhx
         44+grG2R+ta1m8Pjwy6DKs43OtkN5lrKjY9WUS0mMxHgIHRY5/6kr9VUr53t+yT0C1wP
         +m5OQBLeHWbqQ4UbPNNGCPpW2o8w7M7joASJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ScHrdj09hOeast0terJviOTBMydIpMbYN3nYSfXQhgeHlZl9xl4aYCo1bzSHBVzkBc
         kGhrO484YVtaDYUeIaJs4sTVVdovHOyLLsnb+8FGtPIAEqg069cnCo4BVWjn66mb0Wzx
         p1L9N58j93dC/GWIfK/TZlhfS3TQEJX2jvmaU=
Received: by 10.210.93.27 with SMTP id q27mr3859641ebb.6.1254777066144;
        Mon, 05 Oct 2009 14:11:06 -0700 (PDT)
Received: from ?192.168.1.2? (host33-1-dynamic.50-82-r.retail.telecomitalia.it [82.50.1.33])
        by mx.google.com with ESMTPS id 24sm65573eyx.33.2009.10.05.14.11.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 14:11:04 -0700 (PDT)
In-Reply-To: <200910041127.29588.johan@herland.net>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129590>

Il giorno dom, 04/10/2009 alle 11.27 +0200, Johan Herland ha scritto:
> On Sunday 04 October 2009, Octavian R=C3=A2=C5=9Fni=C5=A3=C4=83 wrote=
:
> > Are the following commands specifying the same reference?
> >=20
> > prompt> git log -1 HEAD^^^ ... log entry ...
> > prompt> git log -1 HEAD^~2 ... log entry ...
> > prompt> git log -1 HEAD~1^^ ... log entry ...
> > prompt> git log -1 HEAD~3 ... log entry ...
>=20
> Yes

the ~ is used to select the first parent of a commit and their
grand-parents

HEAD~ means the parent of the current head
HEAD~2 means the grand-parent
HEAD~3 the grand-grand-parent..

the ^ is used to select a direct parent of a commit
HEAD^ is the same as HEAD~
HEAD^^ is the same as HEAD~2 (parent of the parent)
HEAD^2 is NOT the same of HEAD~2, it means the "second parent" of HEAD:
this make sense only if HEAD has at least two parents (because it is a
merge commit) if it hasn't you'll get:

fatal: ambiguous argument 'HEAD^2': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions


you can read the same here: http://progit.org/book/ch6-1.html

regards,
Daniele
