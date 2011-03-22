From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 09:50:27 +0100
Message-ID: <20110322085027.GF14520@neumann>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1103212302000.1561@bonsai2>
	<7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xId-0003Wh-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 09:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1CVIum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 04:50:42 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58033 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab1CVIul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 04:50:41 -0400
Received: from localhost6.localdomain6 (p5B130955.dip0.t-ipconnect.de [91.19.9.85])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MQM5U-1QRAC02E16-00Txtb; Tue, 22 Mar 2011 09:50:29 +0100
Content-Disposition: inline
In-Reply-To: <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:fw9fmqlfxmzbbx45rRAdqwdZ2s/31kJm4Jt0U34kSNQ
 kvGlAuegvQ1oA+2Vtk82gkqYHBBht/Mr411RjSLA0OfZaS1TQL
 Zo5XPQSOBZ00NCzu3M67pDWcAD7HHDdw4YgBp7n3Yd6kn41SPU
 lGZsbE+uGsMNGcvtWlCxZGSHLU6G6BHLtV6O5+dxYL4066UU1b
 Pt8SFq78HiWOvGuPi545g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169710>

On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
> This is a constructive tangent but if we are going to run $(__git_ali=
ases)
> every time we run _git_help, perhaps it would want a hack similar to =
the
> way the value for $__git_all_commands is generated just once?

I think this is not necessary.  We already run __git_aliases() every
time after 'git <TAB>', and it was not an issue so far.  And indeed, I
just created 50 aliases, and the time required for __git_aliases()
seems to be negligible:

  $ time __git_aliases
  <bunch of aliases>

  real    0m0.028s
  user    0m0.016s
  sys     0m0.004s

Besides, invoking __git_aliases() every time has the benefit that
newly added aliases will appear immediately in completion suggestions.


Best,
G=E1bor
