From: Frans Pop <elendil@planet.nl>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 13:13:50 +0200
Message-ID: <200907281313.51304.elendil@planet.nl>
References: <200907280446.22890.elendil@planet.nl> <200907281127.44558.trast@student.ethz.ch> <20090728104423.GA12947@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 13:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkd7-0002Tb-8z
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZG1LNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 07:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbZG1LNx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:13:53 -0400
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:63093 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750824AbZG1LNw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 07:13:52 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML110.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 13:13:50 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090728104423.GA12947@vidovic>
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 11:13:50.0873 (UTC) FILETIME=[7C40E090:01CA0F74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124237>

On Tuesday 28 July 2009, you wrote:
> Erik Faye-Lund wrote:
> > On Tue, Jul 28, 2009 at 4:46 AM, Frans Pop<elendil@planet.nl> wrote:
> > > I assume that this is a configuration issue in the git setup of the
> > > sender, but shouldn't git-send-email refuse to send out messages
> > > with an invalid Message-Id?
>
> Stricly speacking, it is not an invalid Message-Id. RFC 2822 says that
> the Message-Id has to be unique. The right hand side may not contain a
> domain identifier. It is a RECOMMENDED practice (a good one, though).

It also says that (3.6.4):
   The message identifier (msg-id) is similar in syntax to an angle-addr
   construct without the internal CFWS.

And defines:
   message-id      =       "Message-ID:" msg-id CRLF
   msg-id          =       [CFWS] "<" id-left "@" id-right ">" [CFWS]

So, the domain part *is* required (or at least: there has to be a "@"; it 
maybe does not require id-right to be an actual domain, but that's not 
really relevant here).

So, IMO inn2's check is correct.
