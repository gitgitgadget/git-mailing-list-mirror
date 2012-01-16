From: Jeff King <peff@peff.net>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 16:27:09 -0500
Message-ID: <20120116212709.GA21770@sigill.intra.peff.net>
References: <loom.20120112T193624-86@post.gmane.org>
 <4F1028AD.9080701@ira.uka.de>
 <4F106DDF.4040408@unclassified.de>
 <4F1085EC.9010708@ira.uka.de>
 <4F128AD0.5020101@unclassified.de>
 <4F1404E7.9040805@ira.uka.de>
 <4F14718B.80209@unclassified.de>
 <20120116190956.GA13802@sigill.intra.peff.net>
 <4F1494AA.1000004@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 22:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmu5G-0006zg-MX
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910Ab2APV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 16:27:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39470
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162Ab2APV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 16:27:12 -0500
Received: (qmail 18763 invoked by uid 107); 16 Jan 2012 21:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 16:34:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:27:09 -0500
Content-Disposition: inline
In-Reply-To: <4F1494AA.1000004@unclassified.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188657>

On Mon, Jan 16, 2012 at 10:20:42PM +0100, Yves Goergen wrote:

> On 16.01.2012 20:09 CE(S)T, Jeff King wrote:
> > What is the output of "git config core.ignorecase" in your repository?
> 
> None, i.e. an empty line.

That's odd. When the repository is first created, git will do a test to
see whether the filesystem supports case-sensitivity, and will set
core.ignorecase if it does not. Might this repository have been created
on a different filesystem, and then moved onto the case-insensitive
filesystem?

Or might it have been created by something other than core git? I don't
know whether one can create a repo in TortoiseGit, or if so how it does
so.

In any case, try doing:

  git config core.ignorecase true

and see if that clears up your problems.

-Peff
