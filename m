From: Remi Vanicat <remi.vanicat@laposte.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 12:47:42 +0200
Message-ID: <8764ygo181.dlv@vanicat.homelinux.org>
References: <20050417194818.GG1461@pasky.ji.cz> <20050420100824.GB25477@elte.hu>
 <20050421.034227.104037433.oandrieu@nerim.net>
 <20050421092120.GA20626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Apr 21 13:11:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOZaV-0004OG-24
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVDULPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Apr 2005 07:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVDULPe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 07:15:34 -0400
Received: from main.gmane.org ([80.91.229.2]:29326 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261284AbVDULP2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 07:15:28 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DOZZs-0004Jj-ON
	for git@vger.kernel.org; Thu, 21 Apr 2005 13:10:36 +0200
Received: from 252.58.97-84.rev.gaoland.net ([84.97.58.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 13:10:36 +0200
Received: from remi.vanicat by 252.58.97-84.rev.gaoland.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 13:10:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 252.58.97-84.rev.gaoland.net
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:RltQxT3pDCQYNs7X6WZ6NcvgFqk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Olivier Andrieu <oandrieu@nerim.net> wrote:
>
>> There, here's a tarball :
>>   http://oandrieu.nerim.net/monotone-viz/git-viz-0.1.tar.gz
>
> i'm trying to build it under Fedora Core 4 (devel), and there are two=
=20
> problems:
>
>  - the build scripts seem to assume that "." is in PATH (or that the=20
>    needed viz_style.ml/etc. scripts are in the PATH).
>
> adding "." to the PATH worked around this issue, a number of files bu=
ilt=20
> fine, but then it hit the next problem:
>
>  ocamlopt.opt  -I /usr/lib/ocaml/lablgtk2 -I glib -I crypto -pp  -c  =
viz_style.ml

There should be the command name of the preprocessor after the -pp
option. ocamlopt assume that it should use a preprocessor whose name
is -c, and fail. The problem must be in the configure script or the
makefile. A kick hack may be to launch make with the option
CAMLP4O=3Dcamlp4o (well, as it work here, I'm not sure of the exact
problem).=20

--=20
R=E9mi Vanicat

