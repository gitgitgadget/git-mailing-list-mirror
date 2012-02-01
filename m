From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Wed, 01 Feb 2012 23:37:43 +0100
Message-ID: <4F29BEB7.1080901@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com> <4EE7BEF5.6050205@web.de> <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com> <4F28554D.9090107@web.de> <CABURp0pSGGT8eyzNad-dNNx49oioAxOPOf3dmqu7M3fnV+PzdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsioJ-0007ul-5m
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab2BAWhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:37:46 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48476 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab2BAWhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:37:45 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 449D21C07BDB0
	for <git@vger.kernel.org>; Wed,  1 Feb 2012 23:37:44 +0100 (CET)
Received: from [192.168.178.20] ([91.3.200.120]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MgOQQ-1SGPp3361O-00Nzio; Wed, 01 Feb 2012 23:37:44
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CABURp0pSGGT8eyzNad-dNNx49oioAxOPOf3dmqu7M3fnV+PzdA@mail.gmail.com>
X-Provags-ID: V02:K0:9bm5rysD+VwXOu9AA5ZZRBluCozhPobpaSAY6HCvjI8
 f4gUSYlhdyW1A9yK4NCXa1IaAsDPJgRL1To1axMtpswOHA/v0D
 GH2yvBZZetP3UPt8zUe6T+dPWZoW7iEhjYKiTiKTySRmqhZnI5
 PJnMHZi+nUzJmvNCqxB8FtADhSk7B/KtNvsQMSzo/D1WA2oR6z
 hrID+szlr5BI/kfz5AXOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189549>

Am 31.01.2012 23:50, schrieb Phil Hord:
> What I mean is that a developer may be completely focused on one
> particular submodule (his domain).  He does his work in this module,
> and when it's ready he commits and pushes to the server.  'git status'
> shows him that his directory is clean.  But this is only because he
> doesn't really know where the submodules top-directories are, so he
> doesn't realize that he has changes in another submodule that he has
> not committed.  He has to know to run 'git status' from somewhere in
> the superproject (ostensibly in the root directory of that
> superproject).  But he may forget since 'git status' already assured
> him he was done.
<snip>
> I guess what would help here is something like the opposite of 'git
> status' showing the status of descendant submodules;  it would help if
> it showed the status of sibling submodules and the superproject as
> well.

Hmm, I really think the fact that submodules are unaware that they
are part of a superproject is a feature. I'd prefer seeing that kind
of problem being tackled by the CI server and/or user education. Or
maybe a pre-commit hook which issues a warning in that case?
