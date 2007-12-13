From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 16:10:10 +0000
Message-ID: <b0943d9e0712130810p35b33e6aj7756b1af1922992b@mail.gmail.com>
References: <20071213133653.13925.89254.stgit@krank>
	 <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
	 <20071213160432.GA30693@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qeS-0003jL-58
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbXLMQKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 11:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbXLMQKN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:10:13 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:35029 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbXLMQKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 11:10:11 -0500
Received: by rv-out-0910.google.com with SMTP id k20so608574rvb.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uNgDE7+hKe7PHIzKdIQnPLzDTWu3VUN1NfutbDZawW0=;
        b=gs2k0NhDLyHi82pRQcXu3WnO9jlyi2vw+2+214pfKszGmdU1QF7Ssp8Jva6sHGi6UmG7VPHggnUM1HcWZIVNe0v17QA990oQg6h9pVF5iHDJVVShqieuFBA2Ix4VC3KkURne7e7X3E9bPoAdIwmCwuTRtsALu9kQIkaqfXPATWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbqh0kJ2xq2j6XSvkMpxj42eGli3vJU+r0jIgPueePZPap5ZzTKHUzi4rwod+V+RUixFf1AMlTAhUwSsykuCxABeRq/fmRxjPuHCE7TMuqAniArHSxkTYLE3fYP2ioCQQPgRvdO5bi3Hj1aR9xCXWzVsOuX7xxPHFK1lYvYI/7c=
Received: by 10.140.139.11 with SMTP id m11mr1193296rvd.211.1197562210286;
        Thu, 13 Dec 2007 08:10:10 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Thu, 13 Dec 2007 08:10:10 -0800 (PST)
In-Reply-To: <20071213160432.GA30693@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68168>

On 13/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-13 14:04:26 +0000, Catalin Marinas wrote:
>
> > On 13/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> >
> > > Maybe someone can help me find a quicker replacement for the
> > > get_protected call?
> >
> > We can have the standard --list command which ignores the protected
> > flag
>
> Exactly what is the p flag useful for anyway?

It was added so that you don't rebase the stack by mistake. Yann
suggested to have a specific policy for this and make the protected
flag freeze the stack completely.

--=20
Catalin
