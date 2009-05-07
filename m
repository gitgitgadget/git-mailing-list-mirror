From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re:
Date: Thu, 7 May 2009 19:13:51 +0200
Message-ID: <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:14:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27Aw-0003WR-Ea
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760966AbZEGRNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 13:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757257AbZEGRNw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:13:52 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52289 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZEGRNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 13:13:52 -0400
Received: by fxm2 with SMTP id 2so922612fxm.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y6ErdGEYEnGRk3jtlYodtmDeMWL4UX94ZZmDljzWTGk=;
        b=mbkxyLJgfe+7ivZybkCSncpF0LpMJxuyrx8oP2ui885Ky79D++O7Xbn9mt6+YcGbh/
         15APZf4VWn9M0YYfjvqJQLjHRRYC/VNuwezfiXWh6up1EwTMmrMskSjYoWKbviJrZATn
         5eoEigNoJkUXuArb0hsP5jPuq4BFwpWUpAZB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FBJk7NsRNuC6vnI+47Vu3YCIb0iI1iu4wk8lReyHaji6ju7etMAgvePYoVQKV6/P2f
         lFEn8b252o5ri/Vm+jamUDS4+7yIlAC2oWkYNMiT8O+fK1LWpYJKIfOiUUgpzsoxuyt+
         j7hl6mDQ1oBkcHUwb2C2Ks+oCI7R6F75j7XLs=
Received: by 10.204.54.19 with SMTP id o19mr585553bkg.72.1241716431197; Thu, 
	07 May 2009 10:13:51 -0700 (PDT)
In-Reply-To: <454B76988CBF42F5BCACA5061125D263@caottdt504>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118494>

2009/5/7 Bevan Watkiss <bevan.watkiss@cloakware.com>:
> I am trying to create a working tree for people to read from and have=
 it
> update from a bare repository regularly.=C2=A0 Right now I am using g=
it-pull to
> fetch the changes, but it=E2=80=99s running slow due to the size of m=
y repo and the
> speed of the hardware as it seems to be checking the working tree for=
 any
> changes.
>
> Is there a way to make the pull ignore the local working tree and onl=
y look
> at files that are changed in the change sets being pulled?

Assuming you didn't modify that directory you pull into,
git pull will do almost exactly what you described. Almost,
because the operation (the merge) will involve looking for local
changes (committed and not).

It should be faster to do something like this:

  git fetch && git reset --hard origin/master

Again, assuming the directory supposed to be read-only.
Otherwise, you have to merge (i.e. git pull).
