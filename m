From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/3] Handle branch names with slashes
Date: Mon, 15 May 2006 11:22:08 +0100
Message-ID: <b0943d9e0605150322w684785d5n9b17dccda6b29ac1@mail.gmail.com>
References: <20060510060040.GA3034@diana.vm.bytemark.co.uk>
	 <20060515095440.GA11412@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Wartan Hachaturow" <wartan.hachaturow@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 12:22:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfaDP-0007sX-2A
	for gcvg-git@gmane.org; Mon, 15 May 2006 12:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWEOKWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 May 2006 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWEOKWM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 06:22:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:116 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964864AbWEOKWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 06:22:10 -0400
Received: by wx-out-0102.google.com with SMTP id i29so93037wxd
        for <git@vger.kernel.org>; Mon, 15 May 2006 03:22:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JJztKvpmRK4OKoqEv/jXyzbqMBwfoCXR/YsjsO645djbIVfhNFQLGgPxeKM9Y+muryWG1jCfbziILXf1fP+qSMmpj62HUM+hJgnHrjj/6iVZQAFXvMTx8VK+6yWfKoluo4Ac/O+Lb2iGnGWcCl7s5g70O9BXzrQ80VeIPtbWpDg=
Received: by 10.70.74.11 with SMTP id w11mr6730350wxa;
        Mon, 15 May 2006 03:22:08 -0700 (PDT)
Received: by 10.70.31.2 with HTTP; Mon, 15 May 2006 03:22:08 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
In-Reply-To: <20060515095440.GA11412@backpacker.hemma.treskal.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20045>

Karl,

On 15/05/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Teach stgit to handle branch names with slashes in them; that is,
> branches living in a subdirectory of .git/refs/heads.

Thanks for the patches. I'll add them, probably tomorrow evening as
I'm busy today.

> I had to change the patch@branch/top command-line syntax to
> patch@branch#top, in order to get sane parsing. The /top variant is
> still available for repositories that have no slashy branches; it is
> disabled as soon as there exists at least one subdirectory of
> refs/heads. Preferably, this compatibility hack can be killed some
> time in the future.

There is one problem with killing "/" entirely (or maybe we could use
other character than "#"). I tend to write quite often "stg diff -r
/bottom" to see how the whole patch looks like before refreshing. With
"#", the shell ignores "#bottom" as being a comment.

Otherwise, I'm OK with changing "/" with something else or just
keeping both (though I prefer to have a singe way of specifying it).
It looks like ^ and ~ are already used by GIT. It leaves us with % and
!. Do you have any preference? The exclamation mark looks OK to me.

--=20
Catalin
