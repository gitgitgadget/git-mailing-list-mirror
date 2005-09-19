From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 16:42:47 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.19.14.42.44.111271@smurf.noris.de>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org> <u5tmzm9bbrb.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 19 16:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHN1R-0006Sw-DJ
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVISOxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVISOxb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:53:31 -0400
Received: from main.gmane.org ([80.91.229.2]:24198 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932442AbVISOxa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:53:30 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EHMyn-0005bv-RD
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:50:49 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:50:49 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:50:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8873>

Hi, David K=C3=A5gedal wrote:
> +        case "$1" in
> +        -e)	[...]
> +        *)	cmd=3D"$1"
> +                shift
> +                case "$cmd" in
> +                -v|--v|--ve|--ver|--vers|--versi|--versio|--version)

Umm, can we please not have two case statements nested like that?

Better written as:
> +        case "$1" in
> +        -e)	[...]
> +        -v|--v|--ve|--ver|--vers|--versi|--versio|--version)
> +             [print and die]
> +        *)	cmd=3D"$1"
> +             shift
> +             test -x $path/git-$cmd && exec $path/git-$cmd "$@"

Thanks.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.nor=
is.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.nor=
is.de
 - -
It is a sad commentary on today's society that this fortune has to be
classified as "offensive" simply because it contains the word "fuck".
