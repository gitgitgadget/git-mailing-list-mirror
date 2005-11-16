From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: stgit truncates binary files to zero length when applying patches
Date: Wed, 16 Nov 2005 12:31:27 +0000
Message-ID: <b0943d9e0511160431r6c852e5fn@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	 <b0943d9e0511160311k725526d8v@mail.gmail.com>
	 <20051116115449.GA5933@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 13:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcMRx-0002cx-EW
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 13:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVKPMb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 07:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVKPMb3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 07:31:29 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:27846 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030305AbVKPMb2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 07:31:28 -0500
Received: by xproxy.gmail.com with SMTP id i30so1652749wxd
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 04:31:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iasj6bdjkYjYI9F7t0qSlwal8yKLwtRQ2+9KMhWC5cWXBMKLcOEV9EUTvPNsIQDvZnXmrfjlIbLdTCYRakKcB/KlovBGx8Thlp+OuyqQyao1uiHhW/ANreFKKsMoHp9h0c0OUu1mBwB5KVW+WkNAoNDB9FpM28qHp1dTLEMufeY=
Received: by 10.70.77.6 with SMTP id z6mr3903021wxa;
        Wed, 16 Nov 2005 04:31:27 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 16 Nov 2005 04:31:27 -0800 (PST)
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20051116115449.GA5933@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12023>

On 16/11/05, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2005-11-16 11:11:56 +0000, Catalin Marinas wrote:
> > Unfortunately, git-apply doesn't fail for patches including binary
> > files and simply creates an empty file. I think git-apply should be
> > changed to fail to apply this kind of patches.
>
> Yes, at least if stgit is going to continue to use it like this.
> Refusing to handle binary files is somewhat disappointing, but still
> OK; agreeing to handle them and then silently wiping them is a bit
> less OK.

A workaround for this would be to add a config option for StGIT to
always use the three-way merge for pushing patches. The problem with
this is speed since git-diff-tree | git-apply is much faster (and
pretty safe since fuzzy patching is not allowed) and most of the
patches would apply cleanly with only this.

--
Catalin
