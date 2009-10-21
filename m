From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to general mechanism
Date: Wed, 21 Oct 2009 11:15:17 +0200
Message-ID: <200910211115.25017.trast@student.ethz.ch>
References: <op.uzv4dyuotdk399@sirnot.private> <4ADCCCA9.4000802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 11:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0XJ2-0001e1-J9
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 11:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZJUJQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZJUJQQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 05:16:16 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:5276 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbZJUJQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 05:16:16 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 11:16:20 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 11:15:58 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4ADCCCA9.4000802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130901>

Nick Edelen wrote:
> Adds support for graft commits in rev-cache (w/ test), and slightly alters
> graft mechanism.  Before, parse_commit() checked the graft list on every
> commit.  Now register_commit_graft() preemptively loads graft commits into
> memory, and sets a new 'graft' flag in the object.  This allows awareness of
> the commits' medical history without searching a (normally private) array upon
> each commit.

I felt adventurous and merged the topic into my local build, but I get
"error: duplicate graft data ..." in repositories with only a single
line in .git/info/grafts, which bisects to this commit (1c0a666 in
today's pu).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
