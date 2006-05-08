From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit bug: pulling file deletion patch leaves copy of file
Date: Mon, 8 May 2006 15:26:04 +0100
Message-ID: <b0943d9e0605080726n75fd1e9avc48b7b932774d9ea@mail.gmail.com>
References: <20060508124127.GA30662@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 16:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd6hF-0000WX-5Q
	for gcvg-git@gmane.org; Mon, 08 May 2006 16:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWEHO0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 May 2006 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWEHO0G
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 10:26:06 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:32115 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932088AbWEHO0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 10:26:05 -0400
Received: by wx-out-0102.google.com with SMTP id t16so852900wxc
        for <git@vger.kernel.org>; Mon, 08 May 2006 07:26:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pgz6th1cV6mUgnJ23+dEm24omUFiXAYNLbU/bBp/HWygnAy46pqwtnRUIxua+aoUZAVOl3IFMHynAo1AAgGz2Eqgj+AoP/6h0NzOfHQ8K2DDKagWvtCkAFdiF83kKmZyPsoaFi7QyxW4dn5iW1loYDZ27wm+Sm50+z5k5qvQQ6M=
Received: by 10.70.91.7 with SMTP id o7mr2341997wxb;
        Mon, 08 May 2006 07:26:04 -0700 (PDT)
Received: by 10.70.31.2 with HTTP; Mon, 8 May 2006 07:26:04 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20060508124127.GA30662@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19766>

On 08/05/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> When I pull (with -m) a branch that has accepted a patch of mine whic=
h
> deletes a file, stgit does the right thing wrt detecting the applied
> patch, etc. But it leaves an untracked copy of the deleted file in my
> working directory, which I get to delete.

Indeed, it should but it doesn't. The file is generated while
reverse-applying the patches but the git.reset() function (which calls
git.checkout()) doesn't remove the file. I'll fix it and push the
changes tonight.

Thanks.

--
Catalin
