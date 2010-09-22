From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Really beginner on Version Control
Date: Wed, 22 Sep 2010 14:50:22 +0200
Message-ID: <AANLkTinDevPY63WDfPTWVsR2xDNCZOU=aPwzu9r-Zpi+@mail.gmail.com>
References: <1285080133451-5555023.post@n2.nabble.com>
	<m3mxrak937.fsf@localhost.localdomain>
	<1285114417273-5557145.post@n2.nabble.com>
	<1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com>
	<1285155943433-5558696.post@n2.nabble.com>
	<1285156189754-5558706.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 14:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyOmP-0000hM-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 14:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0IVMuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 08:50:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62412 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0IVMuX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 08:50:23 -0400
Received: by qwh6 with SMTP id 6so441042qwh.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=wf36owd4hh61Ccl8UkK3Dy3Bg4nMYXYNArNX88je48A=;
        b=OykR2MLgGIzYoCDY8OhGL9V1Uf25ofg/7QlS122qQY05RocosmPNpPV/iYoYZZCGxf
         A50Vrl0k6M2HGTNML72BKzL5tmxhM5d75WyXXODhr3o77AiUVxeKgGViwfe46oCCYJCT
         qi0wT5WazbCBj/nuYtdQWjCJ5wMkI1WDx1B0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=qopep5scpEHb15juPlqXeQBfKobsIY8PkU/rCAZ40icuUharwmt1SzDto8mCMC7k51
         l2nVHqbHQInJXXxmUwDoVVoTLOIagYUrpdbm0D/eDO3t7C9Dxr96L40JD1Qg6LCk7OdP
         YQnJfXV/6zhZxWyRElLfIGSE3I66Y2o0LTfxk=
Received: by 10.229.249.212 with SMTP id ml20mr92240qcb.119.1285159822224;
 Wed, 22 Sep 2010 05:50:22 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Wed, 22 Sep 2010 05:50:22 -0700 (PDT)
In-Reply-To: <1285156189754-5558706.post@n2.nabble.com>
X-Google-Sender-Auth: YNwvA6M-Jjt6W9OXPgaOigb5f-c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156802>

On Wed, Sep 22, 2010 at 13:49, FernandoBasso <FernandoBasso.br@gmail.com> wrote:

> I merge testing into master (without problems) and I change master and merge
> testing into master again (without any further modification). Now, git
> thinks that the changes I've just made in master are more important than the
> old changes in testing ?

Those old changes were already merged, so they won't get merged again.
Git keeps track of which commits have been merged.
If master originally consists of commits A, B, C, then you branch and
make 'testing', then testing will start out with A, B, C.  Then you
add D to testing. Now master is A, B, C as before, testing is A, B, C,
D. Then you merge. Now master will be A, B, C, D too.  Then you add E
to master: A, B, C, D, E. If you try to merge testing to master again
Git sees that testing contains nothing that's not in master already.

(The letters stand for commits, i.e. changes you commited.)

-Tor
