From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Thu, 28 Oct 2010 00:53:18 +0200
Message-ID: <20101027225318.GB1877@neumann>
References: <20101027131506.4da06c6d@MonteCarlo>
	<20101027173132.GA15657@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEs7-0003Vy-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab0J0Wx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 18:53:27 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:56845 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0J0WxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:53:25 -0400
Received: from localhost6.localdomain6 (p5B130C1E.dip0.t-ipconnect.de [91.19.12.30])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Mgrky-1Oy7pP3AkS-00MfvS; Thu, 28 Oct 2010 00:53:20 +0200
Content-Disposition: inline
In-Reply-To: <20101027173132.GA15657@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:dO4NpYzgtH6S2FZBf+d1k1UwwTs/5iMWrC3j4vUv8qW
 ZHglHZ4cIVVhOfX2xE1nBj5XxX9C4wPH/70XpA3rpaW5k1goQw
 mYzlkfg/nhXP+/2bTRae8CINTY337pTdaQ1xnyE5Uh9qDMzDnB
 RJCbQkuWLupVMpOwrB3wMyRrfvR9ZwiJAHbyYZJtv3AXFQuqsB
 Yn1heIYPdS5G11SuncqJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160135>

Hi Jonathan,


On Wed, Oct 27, 2010 at 12:31:32PM -0500, Jonathan Nieder wrote:
> Could some zsh user perhaps test that the new zsh support is not
> broken?

I'm afraid it is.

The commit message of 06f44c3 (completion: make compatible with zsh,
2010-09-06) says:

    ${var:2}
        Zsh does not implement ${var:2} to skip the first 2 characters,=
 but
        ${var#??} works in both shells to replace the first 2 character=
s
        with nothing.  Thanks to Jonathan Nieder for the suggestion.

    for (( n=3D1; "$n" ... ))
        Zsh does not allow "$var" in arithmetic loops.  Instead, pre-co=
mpute
        the endpoint and use the variables without $'s or quotes.

However, the functions taken over from the bash-completion code
contain constructs like:

    ${cur:0:$index}
    # ok, this is not exactly the same as ${var:2}, so it might even
    # work...

and

    for (( i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do

But I haven't actually tried it.


Best,
G=E1bor
