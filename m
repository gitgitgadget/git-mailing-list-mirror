From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Is git over http (git-http-push) ready for production ?
Date: Fri, 19 Feb 2010 16:04:19 +0200
Message-ID: <20100219140419.GB31796@Knoppix>
References: <hllp07$o78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fabien <fabien.ubuntu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 15:04:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiTT2-0006tJ-T3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 15:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab0BSOEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 09:04:24 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:59983 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0BSOEX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 09:04:23 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id C5DEEC7E61;
	Fri, 19 Feb 2010 16:04:21 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A079ACBFEA6; Fri, 19 Feb 2010 16:04:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id ACBFE1C63A8;
	Fri, 19 Feb 2010 16:04:19 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <hllp07$o78$1@ger.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140453>

On Fri, Feb 19, 2010 at 11:26:16AM +0100, Fabien wrote:
> Hi,
> 
> Following my last email about locks problem with reiserfs (see
> git-http-push (git v1.5) problems with DAVLockDB on reiserfs FS), I was
> wondering how reliable is git-http-push.

> Another problem I see is the password in clear text in ~/.netrc to avoid
>   to type passwords all the time.
> 
> Finally, hooks don't work when using git over http (yep, I know, it's a
> "dumb" protocol)...

1.6.6 introduced Smart HTTP. It is much more efficient, can run hooks and
has same kind of atomicity guarantees as ssh://, but it has few shorcomings:

- Requires server support (CGI script & Git 1.6.6+)
- Hook messages don't work (at least with 1.6.6.X/1.7.0.X)
- Requires 1.6.6+ on client side
- Authentication still sucks (no surprise, auth with HTTP just plain sucks).

But I regard HTTP fetch/push as backup for cases where git:// and ssh://
are not possible.

-Ilari
