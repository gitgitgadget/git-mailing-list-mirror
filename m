From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Support working directory located at root
Date: Tue, 9 Feb 2010 19:27:15 +0700
Message-ID: <fcaeb9bf1002090427g51754d16tb89b0ae5ba6cada8@mail.gmail.com>
References: <mtranet.20100209081652.392409790@telekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 13:27:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NepBd-0005Dl-SE
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab0BIM1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:27:17 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:47783 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab0BIM1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:27:16 -0500
Received: by pxi29 with SMTP id 29so4569867pxi.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=uHGX4feux9ejokQhXjBGj14/HPXPykj/MDe/YilwbMM=;
        b=taqn1u7dTFtB84MQajqffMoxt3siwcneB1MiZ2iLb2zSJu6NmZCZYeFyMQlY24bzTy
         RUFy20kaNYsOmUMDFEtIEREvF8GySCqD4YIiWWSrcFEcb7ivTgFlCx6pW4T0vskEQoNE
         QraXL3FhItuRci5ob+uVk2SqyQ6RVhldzBbbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Cyn3P7Rje7799KTSHCOFHfGYqhl/7IQk0rOIm0jk9p5frbRT9wQg37TR8Pkg26tsvv
         ClA15H9p6ieaQj3PVM3ug+DcXuBkH24EpJg4M3NH9Ws4YHQg12XKW+Npr3DaF9eubBtp
         swhJ/w73kaoa25LnMcYmMvhDuqOQY6u2UrM6s=
Received: by 10.114.215.2 with SMTP id n2mr119818wag.141.1265718435110; Tue, 
	09 Feb 2010 04:27:15 -0800 (PST)
In-Reply-To: <mtranet.20100209081652.392409790@telekom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139401>

On 2/9/10, Johannes Sixt <j6t@kdbg.org> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > But I suspect my change in this code is not enough and caused
>  > the problem (on msys?) for Hannes.
>
>
> My test was on Linux, btw, roughly:
>
>  cd /
>  git init
>  cd etc
>  git add resolv.conf

OK. Just a wild guess since you're mingw port guy :-)

I changed offset near the end of setup_git_*_gently, and in turn
screwed up prefix calculation. I probably forgot to unset
GIT_WORK_TREE while testing. Will work on a test script first before
getting back to the patch. I think I can solve the DOS drive case too.
Just checking, UNC path is not affected, right?
-- 
Duy
