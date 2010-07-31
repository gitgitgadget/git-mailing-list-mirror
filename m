From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Sat, 31 Jul 2010 08:57:35 +0300
Message-ID: <20100731055735.GA19812@LK-Perkele-V2.elisa-laajakaista.fi>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
 <20100731053918.GA19688@LK-Perkele-V2.elisa-laajakaista.fi>
 <i30da5$84d$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 07:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of53Q-00052F-Se
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 07:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab0GaFz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 01:55:59 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:53705 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab0GaFz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 01:55:58 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 1C60FEF60B;
	Sat, 31 Jul 2010 08:55:57 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A07F5B1A8C9; Sat, 31 Jul 2010 08:55:57 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id B6982158A63;
	Sat, 31 Jul 2010 08:55:54 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <i30da5$84d$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152307>

On Fri, Jul 30, 2010 at 10:45:36PM -0700, Walter Bright wrote:

> >[1] But upon restore, the working copy cache will be wrong
> 
> Why? Is it someplace else?

It is inside .git directory and will be caught by full recursive
backup. Unfortunately, it contains i-node numbers, which aren't
preserved through backup and restore.

The wrong i-node numbers would then confuse git (false positives
in modification detection). Fortunately, this data can be rebuilt
with single command (see below).
 
> >and needs to be rebuilt (git update-index --refresh).

-Ilari
