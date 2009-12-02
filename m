From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
 transports
Date: Wed, 2 Dec 2009 07:55:43 +0200
Message-ID: <20091202055543.GC31244@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091201192233.GL21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFiBt-0006QJ-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbZLBFzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZLBFzm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:55:42 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:60346 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZLBFzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 00:55:41 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 7D68FEBC34;
	Wed,  2 Dec 2009 07:55:47 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0610F6F874; Wed, 02 Dec 2009 07:55:47 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 66A5E4033;
	Wed,  2 Dec 2009 07:55:44 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091201192233.GL21299@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134301>

On Tue, Dec 01, 2009 at 11:22:33AM -0800, Shawn O. Pearce wrote:
> 
> This flies against every other convention we have.  git:// uses the
> string 'git-upload-pack' and 'git-receive-pack', and so does the
> smart-http code.  We should continue to use the git- prefix here,
> to be consistent, even though by context its clearly implied.

Changed for next round (put the git- -prefixes into names).
 
> Why 'OK'?  Currently remote-helpers return an empty blank line
> to any successful command, not 'OK'.

Changed to "" (i.e. blank line) for next round.
 
> FALLBACK almost makes sense, but ERROR we don't do in the
> the existing helper protocol.  Instead the helper simply
> prints its error message(s) to stderr and does exit(128).
> aka what die() does.

ERROR case changed to exit(128) of helper for next round.

> Why both connect-r and invoke-r?  Why isn't connect-r sufficient
> here?  Isn't it sufficient for any service that runs over git:// ?

Invoke supports those --upload-pack &co (a'la ssh://). connect
doesn't (a'la to git://).

-Ilari
