From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: convert to parse-options
Date: Tue, 19 Apr 2011 22:38:17 -0400
Message-ID: <20110420023817.GA14201@sigill.intra.peff.net>
References: <7v7hawiww7.fsf@alter.siamese.dyndns.org>
 <20110419123325.GA10814@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?PT9VVEYtOD9xP0Nhcmxvcz0yME1hcnQ9QzM9QURuPTIwTmlldG8/PQ==?= 
	<cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 04:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNJB-0005vW-QU
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab1DTCiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 22:38:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1DTCiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:38:20 -0400
Received: (qmail 15034 invoked by uid 107); 20 Apr 2011 02:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Apr 2011 22:39:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2011 22:38:17 -0400
Content-Disposition: inline
In-Reply-To: <20110419123325.GA10814@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171829>

On Tue, Apr 19, 2011 at 02:33:31PM +0200, =3D?UTF-8?q?Carlos=3D20Mart=3D=
C3=3DADn=3D20Nieto?=3D wrote:

> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

This is not about your patch at all, but rather that I notice in your
"From" header that your name is doubly rfc2047-encoded. It looks like
this:

  From: =3D?us-ascii?B?PT9VVEYtOD9xP0Nhcmxvcz0yME1hcnQ9QzM9QURuPTIwTmll=
dG8/?=3D
    =3D?us-ascii?Q?=3D3D?=3D <cmn@elego.de>

which decodes to the literal string:

  =3D?UTF-8?q?Carlos=3D20Mart=3DC3=3DADn=3D20Nieto?=3D

which in turn decodes again to your proper name.

We made some changes to format-patch's quoting recently, and I want to
make sure this is not a regression. Can you describe your workflow for
sending these patches? What I think probably happened is:

  1. format-patch encoded your name because of the non-ascii characters

  2. the result was fed literally into mutt via cut-and-paste or
     otherwise pulled into the editor, rather than "mutt -f patch-file"=
=2E

Which is not a regression, but just an annoying behavior that has been
there for a while[1]. But I wanted to double-check.

-Peff

[1] Probably the solution is to let people with a workflow like that
tell format-patch to give them the literal utf8 instead of encoding the
header.
