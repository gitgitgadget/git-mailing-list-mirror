From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 23:40:04 +0000
Message-ID: <b0943d9e0803241640h500e43ffgee55bb9e1b2b04e2@mail.gmail.com>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
	 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
	 <47E81037.5030808@keyaccess.nl>
	 <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
	 <47E82BDD.9060507@keyaccess.nl>
	 <b0943d9e0803241550k3ef0dbe8nae3b00bac34fa20@mail.gmail.com>
	 <47E837E8.7000606@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Josef Sipek" <jsipek@fsl.cs.sunysb.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Rene Herman" <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwHd-0000y7-Qg
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbYCXXkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbYCXXkH
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:40:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:61597 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbYCXXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:40:05 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3235632wxd.4
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=583aWPyzbYpsrW2Pu5X74STA8acB1I+POkpCVopNbXc=;
        b=YT26IexU3KazGFVnqmV6SWQB7svhfMMzQn5q+ZpC82G6nt5tRCkrInFh/TeZGIB5+BPiVcPFwKvLQFg71bgjlSeZCq9yxAhxwWWrI0IJnJUIPmVNdj+4XFkLS+jwVHUDVauC1rkF23qwZ6nyBx+AM62R7UjyyAjA8k5RDeH6N1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DF18G7oBreAe6d8vdW5rZlvLyW4Svpo+Deepn8KjaFZubsPJbZMFJpBT+HWA1a/GnMwAaweBdKTETtuxSKzlgsrs3UrwcecdK6yJI71bhTCKPiXHMwkLtApygnyJIQpfEMWc/BM9rRoy0eKJVDaLkJTDzWrfNqj9Ed0Whbn3Muc=
Received: by 10.141.145.11 with SMTP id x11mr2712349rvn.215.1206402004466;
        Mon, 24 Mar 2008 16:40:04 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 16:40:04 -0700 (PDT)
In-Reply-To: <47E837E8.7000606@keyaccess.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78127>

On 24/03/2008, Rene Herman <rene.herman@keyaccess.nl> wrote:
> used to use quilt and although I
>  didn't much care for its linear nature when managing an entire tree, it
>  probably works out well for private topic branches. Not overly sure of added
>  practical value over git rebase, but I did like the simple nature of
>  shuffling things around by just editing a series file back when I was using
>  quilt. Keeps one on top of things, so to speak (<-- amusing play on words).

Git rebasing is useful but using a patch management tool is much
easier, especially when you need to post a series of patches multiple
times while implementing others' comments. And this is not only for
private branches but public ones that are meant for upstream merging.
The problem with these tools is that they rewrite the history of the
repository but they are OK if you aren't in a position where people
need to base their work on your tree.

I would much prefer to simply commit the additional comments at the
top of a branch without changing the history but this makes patch
posting and reviewing more difficult. Because of this requirement to
keep clean patches (which I think is fair), people using maintainers'
branches can only use rebasing (or some patch management tool).

>  Moreover not too keen on using many tools do do one thing, so getting this
>  inside git itself sounded like a possibly nice notion.

I don't like using many tools either, hence I use mostly StGIT :-).

-- 
Catalin
