From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib/test-hg*.sh: Do not use PYTHON_PATH
Date: Wed, 17 Apr 2013 13:36:28 -0500
Message-ID: <CAMP44s2RTKLO3nhBJcm_KAwq9iHt8ZSXeFuYksYv_JebK-eqrg@mail.gmail.com>
References: <201304171610.49384.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 20:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXDh-0001pz-MR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966370Ab3DQSgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 14:36:32 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:53491 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966121Ab3DQSga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 14:36:30 -0400
Received: by mail-lb0-f181.google.com with SMTP id r11so1892595lbv.26
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=QL+esjNeBl+pBClGOejM1N338WNPmjkf0SBMBwsFafQ=;
        b=ZJMjwThZrKNKL+fuzSBNLiZ1gr5Z4guOxcCDggTybq5q9yNIVrwg/gSl//oCKc2wjZ
         90xj36T1E3FdmvBcCbXQpbCT+luk4E8Z/A3ja8nqyqIVfDuR0fDZn11KiesrMmPZVkMu
         BhMwQHrkRk5TM4QAjOYPwn6hCrMeBjDgdTGAOVBbOJR9reS95hI/WIiW6tcxC3HRtt25
         9Xm+9uoxGlDEijFH39G2Z06/piDakAkM9J+LJD5K73ErTGzQpbZpnWce4ywAycwSYXle
         2b1zA3RwItVifHRU1c6StDxXmxLsG1TCzm5JwFw1rFvuuvzEt6UggSQ8+0pc1Qent5ny
         gSfw==
X-Received: by 10.152.27.229 with SMTP id w5mr1570232lag.46.1366223788999;
 Wed, 17 Apr 2013 11:36:28 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 11:36:28 -0700 (PDT)
In-Reply-To: <201304171610.49384.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221562>

On Wed, Apr 17, 2013 at 9:10 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> The test cases in contrib/remote-helpers use mercurial and python.
> Before the tests are run, we check if python can import
> "mercurial" and "hggit".
> To run this check, python pointed out by PYTHON_PATH is used.
> This may not work when different python binaries exist,
> and PYTHON_PATH is not set:
>  Makefile sets it to the default /usr/bin/python
>  The PATH may point out e.g. /sw/bin/python.
> When /sw/bin/python has the mercurial module installed,
> but /usr/bin/python has not, the test will not be run.
>
> Git respects PYTHON_PATH, hg does not.
> Use python instead of $PYTHON_PATH to check for installed modules.

And this would fail if the distribution doesn't have a 'python'
binary, and instead has python2, python3, etc.

> While at it, split exportX=3DY into 2 lines

Do it in a separate patch.

Cheers.

--=20
=46elipe Contreras
