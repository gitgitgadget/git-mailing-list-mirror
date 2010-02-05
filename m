From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 5 Feb 2010 14:07:58 +0200
Message-ID: <20100205120758.GA22943@Knoppix>
References: <20100205033748.GA19255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 13:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdMz3-0008SN-8X
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 13:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab0BEMII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 07:08:08 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:39317 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab0BEMIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 07:08:07 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id E2542EB979;
	Fri,  5 Feb 2010 14:08:03 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01BBBDA04D; Fri, 05 Feb 2010 14:08:03 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 697D31C639F;
	Fri,  5 Feb 2010 14:07:59 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100205033748.GA19255@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139045>

On Thu, Feb 04, 2010 at 07:37:48PM -0800, Shawn O. Pearce wrote:
> Rather than sending hook messages over stderr, and losing them
> entirely on git:// and smart HTTP transports, receive-pack now
> puts them onto a multiplexed sideband channel if the send-pack
> client asks for the side-band-64k capablity.  This ensures that
> hooks from the server can report their detailed error messages,
> if any, no matter what git-aware transport is being used.
> 
> When the side band channel is being used the push client will wind up
> prefixing all server messages with "remote: ", just like fetch does.

I tested this a bit with git-remote-gits / git-daemon2. Seems to
work.

-Ilari
