From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: make isatty() recognize MSYS2's pseudo terminals
 (/dev/pty*)
Date: Fri, 27 May 2016 15:33:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605271529540.4449@virtualbox>
References: <f1408371e14ff10539990ad710681ef17f29fea1.1461770158.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1605261525400.4449@virtualbox> <xmqqvb20wy5x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 15:34:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Hu9-00038d-6q
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 15:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbcE0NeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 09:34:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:53241 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbcE0NeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 09:34:10 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTfZc-1axSC00Rf6-00QReL; Fri, 27 May 2016 15:33:52
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqvb20wy5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1RsSjW2BceqmScsec18cx+WtCvpA/gO+OLKIsSIehAy//hRFDNj
 CGI7a/Y29Y82CO3aaldmEYdLgUMHTRrocQNfYJJDgXUlJ2nDAYOoZQVKbq4Os8kI3DtTsSI
 x2j6RbxBGyqK7F+2jy9MUEgFTXVDByxdixGb1YB2pqEhhfD4ASuRm4GDhall+x+iaOUpQxW
 yfpnYBTMbqoD/AYc0bzhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X2UcfcznFMQ=:r1nQdJjUm2EsIYaTNoNgPB
 pUfwgveP1+GPDe0oEvQiHjLY4UnYjjmHSt7EJJiPMDBH+gYWewYcmog+mxNEbJHCe6z8UFd0J
 mtQE8lbJ5l37oarlqp1Fk0QV7go0cDLVkFXXhu0Kvk1W3P0yt9PAJHKRU6/ZecUT4JmNMdUzV
 AikIqyBtlbhP7OmFAitwVKJUhE7YN5sSpnTcIKoR7d8IxNjdGlNcYOe/roLPcFmxpQZ+kHriE
 mpw4EPTpjH9Dnq6qCKQX/2+Kaw8oZUjADnCAZ6CayEFuece67KesqQEA50qm9/gu1uunlHtAJ
 Y/YLlzZUvAL3FM+uHpE21uVp9rI0WhpHOxRNm3ruzi3f6fFUaekRxdH6oVwPCE4GCrqBxbfqF
 9oDNS+dW8820PmMRA6A8zuoedrBdrJo9yuHNT0gQ2Pv7iBk5aY/zEGgPQEHPhVTBp5j7ryzOL
 NIV3Ikpb7d3CJkpQ5LmX5p8MB5iD41OjuRC5XtXU5JK+xqHHvXRxYWCPsZsJxZFhIOuxavnzV
 cXxIwTBgQrxiJrANeRo2o5VrPj3hQwKwTUmc011uR/GSgCgQfdPdaT3L2tM/NsG0Fc9VV5uvb
 ryaMjXr5c3X2f1MCZ+60zZZEolrNFcRS46m6K7EDvFYDVAjoRArsy6E2NCWF804R7zpfhQImS
 BqHWFgltfyOGtL5YSNPfrVwPMQOMl4KTCvpn3fXhJ7wEWbJ3x7Y+PkaJGjiXVpOv31GY1pcAF
 7LF4n1yUimzJi5ig+fQa/FMIvmkpQGeMkLToHAapksvSRlkBwu8TWCdSa8LTkgEzSCzeElow 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295750>

Hi Junio,

On Thu, 26 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I do not see this patch in 'pu'... Anything I can do to get this into
> > 'master' eventually?
> 
> The reason why I left it in my inbox was because I couldn't tell if
> this was a final submission with concensus among Git developers on
> Windows, or I should be giving a chance to comment to some folks who
> work on Windows port but are not necessarily closely communicating
> with you.
> 
> If the message were Cc'ed to J6t, I would probably have queued it on
> 'pu' and marked it as "Will merge after waiting for a few days" in
> What's cooking.

Hannes does not use Git for Windows' SDK, but instead uses an old
MSys-based development environment that predates even msysGit (which was
the SDK used to develop Git for Windows 1.x). His environment most
notably does *not* use MinTTY, and therefore is unaffected by the bug that
this patch fixes.

That was the entire reasoning why I did not ask Hannes to review this
patch: it is unlikely that he knows about the issue, let alone about the
correctness of the implementation of this patch.

The implementation relies on some really low-level knowledge of the
Windows internals, which Karsten reverse-engineered and I verified.

Thanks,
Dscho
