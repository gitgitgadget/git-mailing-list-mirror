From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 15:38:28 +0000
Message-ID: <b0943d9e0712190738o66005233v1ee908427ae619b8@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
	 <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J510Y-0003Ni-U2
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 16:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbXLSPib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 10:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbXLSPib
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 10:38:31 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:17759 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXLSPia convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 10:38:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2686453rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SVOC0ZsXwzcRkcwjerMj2jrdtx/qin67QumK+CNo88s=;
        b=ZR10eUShqXfBxZoYeZFD6X9OGRx6tBtjfmBL+x7jmMHIeAxvTln5LNmMlq7Os26/b0yPLKKLLWNUjRYpkRq1DlXNqGxNZBPbhBzxrGUdwNmgSvQ6Guz47+oVjROtPlkca1ISTpInYAeM8jdvgJgEEfarsLwIBGBWwtSmpKzxs88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UiNpF500ZXVm/QKkenjOP/b9SG5R1Gykvw5NvC07fs1Iq+qfuiwsew4AdNja4MlErqSz5FWI7SILaPo/qE+kVO2I5E2f5bDzdAxo4E4w/fYKME973UapiJEV0STNDJPa0uBCeuEV2c0e2WsBKxDsHGCMjYGWcWcS7EUUH8yuMyU=
Received: by 10.141.167.5 with SMTP id u5mr1894647rvo.220.1198078708502;
        Wed, 19 Dec 2007 07:38:28 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 07:38:28 -0800 (PST)
In-Reply-To: <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68915>

On 18/12/2007, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >       Fix "stg resolved" to work with new conflict representation
>
> For some reason, the interactive resolving keeps invoking the merger.
> I'll have a look.

I found the problem. git.ls_files() now returns all three stages if
there was a conflict and the file list got longer. I added a set to
remove the duplicates.

--=20
Catalin
