From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 14:27:59 +0200
Message-ID: <20100216122759.GA30898@Knoppix>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
 <20100216063959.GC2169@coredump.intra.peff.net>
 <20100216151821.994ace31.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Kevin Menard <nirvdrum@gmail.com>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 13:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhMXG-0000zC-6U
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 13:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab0BPM2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 07:28:09 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:59142 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0BPM2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 07:28:07 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 24CE1EBBC1;
	Tue, 16 Feb 2010 14:28:04 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0303721C85; Tue, 16 Feb 2010 14:28:04 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id DAC3741BFA;
	Tue, 16 Feb 2010 14:27:59 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100216151821.994ace31.rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140099>

On Tue, Feb 16, 2010 at 03:18:21PM +0800, Tay Ray Chuan wrote:
> NAK. This will only work if the given transport is git://. (My take
> below.)
> 
> 
> -- >8 --
> Subject: [PATCH] transport: add got_remote_refs flag
> 
> tranport.c::transport_get_remote_refs() used to check
> transport->remote_refs to determine whether transport->get_refs_list()
> should be invoked.
> 
> However, transport->remote_refs could evaluate to false (eg. if it is
> NULL), causingo transport->get_refs_list() to be invoked unnecessarily.
> 
> Introduce a flag, transport->got_remote_refs, and make
> tranport.c::transport_get_remote_refs() check this flag rather than
> evaluating transport->remote_refs.

<snip patch>

Seems to work even in external transport case (not suprising, as at this
level, there's no difference between git://, ssh://, file:// and external
transports).

-Ilari
