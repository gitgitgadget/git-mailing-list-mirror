From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] git push --track
Date: Wed, 13 Jan 2010 18:27:36 +0200
Message-ID: <20100113162736.GA7505@Knoppix>
References: <op.u6g8jnixg402ra@nb-04>
 <20100113154310.GA7348@Knoppix>
 <op.u6haiiiog402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:27:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV64P-0000LF-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 17:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0AMQ1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150Ab0AMQ1m
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 11:27:42 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36834 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab0AMQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 11:27:41 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 5BE67C7AE9;
	Wed, 13 Jan 2010 18:27:40 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0567A303D1; Wed, 13 Jan 2010 18:27:40 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1AD3E41BEF;
	Wed, 13 Jan 2010 18:27:37 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <op.u6haiiiog402ra@nb-04>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136838>

On Wed, Jan 13, 2010 at 04:55:20PM +0100, Rudolf Polzer wrote:
> On Wed, 13 Jan 2010 16:43:10 +0100, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> 
> >On Wed, Jan 13, 2010 at 04:12:49PM +0100, Rudolf Polzer wrote:
> >>Hi,
> >>
> 
> Of course, but I assume the sign-off would not be by me, but by some
> of the git developers, and would depend on whether they actually
> want this feature.

It would need sign-off by you. Even if you took the code from somewhere
(and then it would need theirs as well) and passed it along.
 
> >- Should the tracking be set up even if only part of ref update suceeded
> >(for those that succeeded), not requiring all to succeed?
> 
> Good point, but I simply see no clean way to set it up for the
> succeeded refs. Would be a nice idea for improvement of this.

Ah, that is only known in transport_push and what it calls (and transport_push
is last point to insert common functionality)...
 
> @@ -218,6 +249,8 @@ int cmd_push(int argc, const char **argv, const
> char *prefix)
>  		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
>  		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack",
> "receive pack program"),
>  		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive
> pack program"),
> +		OPT_BIT('t', "track",  &flags, "set up tracking mode (see git-pull(1))",
> +			TRANSPORT_PUSH_TRACK),
>  		OPT_END()
>  	};

Linewrap damage.

-Ilari
