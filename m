From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 6/8] Support remote helpers implementing smart
 transports
Date: Wed, 9 Dec 2009 17:16:30 +0200
Message-ID: <20091209151630.GC15673@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vein5594u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOHP-0006Bn-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbZLIPQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZLIPQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:16:28 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:42734 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZLIPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:16:27 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 2700AEBC2A;
	Wed,  9 Dec 2009 17:16:33 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05E06E35D6; Wed, 09 Dec 2009 17:16:32 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 895B827D84;
	Wed,  9 Dec 2009 17:16:30 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vein5594u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134976>

On Tue, Dec 08, 2009 at 03:38:41PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> >  
> > +'connect' <service>::
> > +	Connects to given service. Stdin and stdout of helper are
> 
> A minor point, but in prose, unless it explains how to use "stdin" and
> "stdout" as a variable, keyword, etc. in code, I'd prefer to see these
> spelled out, like so:
> 
> 	The standard input and output of helpers are connected to ...

Changed.

> > -static int recvline(struct helper_data *helper, struct strbuf *buffer)
> > +static int _recvline(FILE *helper, struct strbuf *buffer)
> >  {
> 
> recvline_fh() vs revline() might be better as most of the interaction in
> this layer are done on helper_data, which makes the name recvline() pair
> nicely with sendline that also takes helper_data; and the oddball one that
> is _not_ an implementation detail (i.e. you have calls outside recvline()
> implementation that call _recvline()) hints that it takes filehandle
> instead.

- _recvline -> recvline_fh
- _process_connect -> process_connect_service

-Ilari
