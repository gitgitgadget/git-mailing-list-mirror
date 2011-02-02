From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Wed, 2 Feb 2011 20:47:54 +0100
Message-ID: <201102022047.55152.trast@student.ethz.ch>
References: <20110202045826.GC15285@elie> <20110202050735.GE15285@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 20:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkigM-0001Ve-6T
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 20:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab1BBTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 14:47:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7747 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab1BBTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 14:47:56 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 20:47:47 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 2 Feb
 2011 20:47:55 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110202050735.GE15285@elie>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165929>

Jonathan Nieder wrote:
> 
> Support for importing notes was added to git fast-import quite a while
> ago (v1.6.6-rc0~21^2~8, 2009-10-09), before the 'feature' facility was
> introduced (v1.7.0-rc0~95^2~4, fast-import: add feature command,
> 2009-12-04) so for compatibility with older git versions, authors
> of existing frontends should not start using the "feature notes"
> command.  Most git versions in wide use support notemodify already.
> 
> The purpose of the "feature notes" declaration is instead to
> distinguish between git and fast-import backends that do not support
> notemodify.  In git "feature notes" will be a no-op while in other
> current fast-import backends it will error out with a clear error
> message.

So in summary, don't use "feature notes" because it would fail with
old gits, but do use "feature notes" because it will fail for non-git?

Isn't that a bit backwards?  I mean, a tool author would either just
use it and say "if it doesn't read this, upgrade your git" or run

  echo feature notes | scm fast-import

to test, and use notes depending on success.  In both cases old gits
will be regarded as incompatible.  Or am I missing something?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
