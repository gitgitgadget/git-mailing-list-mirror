From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 1/4] Add xmallocz()
Date: Tue, 26 Jan 2010 23:13:48 +0200
Message-ID: <20100126211347.GA9194@Knoppix>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1264530255-4682-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <19295.21148.182245.516321@blake.zopyra.com>
 <7v1vhczj95.fsf@alter.siamese.dyndns.org>
 <7vwrz4y4gf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZsjV-0005fv-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 22:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab0AZVNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 16:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680Ab0AZVNx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 16:13:53 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:54768 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0AZVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 16:13:52 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 886D38C987;
	Tue, 26 Jan 2010 23:13:51 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A038B183BD6; Tue, 26 Jan 2010 23:13:51 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7B1A3158A64;
	Tue, 26 Jan 2010 23:13:48 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vwrz4y4gf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138077>

On Tue, Jan 26, 2010 at 12:52:00PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I'd rather see the function lose the NUL termination; if that makes the
> > behaviour inconsistent with its name, perhaps it is better to rename the
> > function; perhaps xmalloc1() to denote that it overallocates by one?
> 
> Actually I take that back---all the callers do benefit from the allocator
> giving a buffer that is pre-terminated with NUL.
> 
> We can also lose "buf[size] = 0" from unpack_sha1_rest() patch.

If that line would be next to xmalloc() line, I would have removed it, but
because it was beyound loop, I was worried that something might be done
to it (and was not in right mood to analyze the logic properly).

And yeah, that nul-termination in xmemdupz is not needed. Oops, missed
that.

-Ilari
