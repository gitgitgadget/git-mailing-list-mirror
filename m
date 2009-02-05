From: Harry Vangberg <ichverstehe@gmail.com>
Subject: Re: git-svn doesn't fetch anything
Date: Thu, 5 Feb 2009 09:54:53 +0100
Message-ID: <941ff7dd0902050054v51853a4bgad1dca9211bcd75a@mail.gmail.com>
References: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>
	 <20090205033638.GD28280@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV02J-0006AE-FJ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZBEIy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 03:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZBEIy5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:54:57 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48354 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZBEIy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 03:54:57 -0500
Received: by fxm13 with SMTP id 13so177725fxm.13
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 00:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Id0DlGT2W2NSpT7xn+Gs07eMwtJQSI/UHfKo66XMO9g=;
        b=Zdv2jpGyy/QXamFr/TiN3tYGGBk1IDpe+kCqqivVJu2ZbHl/8+NIDpMNoV4WpUEoBh
         Mw04DahEh/gqRea+tHHJ+a6DTMGH/DMYa8f4MF7eALGk6y2uYZ7t8BoFwhc0h6mD63nn
         MylzNC6TfhogjNfJA8dTtNc4RV8ZuIUye9zSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=k/gpYfhSAU5dL1euE9wWtVYCF13oImETEzzA0LmBTvcPDkBYsxcOu8cigAnCAas1eJ
         Hd30Y5u/g7MlDdPlTsnr8S4f1IkiPQytO3uwjzWc5l4X6j8X2Cjec5Sg4TrlyQlqubxa
         AJfuXs239aY+tXYcS8vQqshz1YoLLAy1UnFmk=
Received: by 10.181.135.12 with SMTP id m12mr91425bkn.88.1233824093614; Thu, 
	05 Feb 2009 00:54:53 -0800 (PST)
In-Reply-To: <20090205033638.GD28280@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108541>

2009/2/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> Hm, the branches and tags config looks weird to me. Is the path to th=
em
> really ".../turntool/plantool/plantool/branches"?

I tried doing this:

$ git svn init https://svn.turntool.com/svn/turntool/plantool -s
--username=3Dharry
Initialized empty Git repository in /Users/h/work/projsvn/.git/
$

Then I changed .git/config to look like this:

$ cat .git/config
[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true
        ignorecase =3D true
[svn-remote "svn"]
        url =3D https://svn.turntool.com/svn/turntool/plantool
        fetch =3D trunk:refs/remotes/trunk
        branches =3D branches/*:refs/remotes/*
        tags =3D tags/*:refs/remotes/tags/*
$

And finally tried to fetch it all

$ git svn fetch --all
$

It simply exists quietly, still without fetching *anything* and
leaving me in no branch, in an empty dir. :/
