From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git access using SSL certificates
Date: Tue, 29 Jun 2010 03:46:31 +0300
Message-ID: <20100629004631.GA14854@LK-Perkele-V2.elisa-laajakaista.fi>
References: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu>
 <16FCDB06-9C82-4CBF-BD25-A10BD3E829DE@uab.edu>
 <20100628204425.GA13640@LK-Perkele-V2.elisa-laajakaista.fi>
 <6E28EE29-0FFA-4467-AE10-76ED2AEF79A5@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Tue Jun 29 02:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTOxK-0007FR-C1
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 02:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0F2Apd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 20:45:33 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:60454 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0F2ApV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 20:45:21 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 793C3EF3EE;
	Tue, 29 Jun 2010 03:45:19 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A074746B5D3; Tue, 29 Jun 2010 03:45:19 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3A302E51A2;
	Tue, 29 Jun 2010 03:45:16 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <6E28EE29-0FFA-4467-AE10-76ED2AEF79A5@uab.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149872>

On Mon, Jun 28, 2010 at 05:39:03PM -0500, Shantanu Pavgi wrote:
> 
> Tried with Git 1.7.1 on Mac: Doesn't work, same error. 
> Tried from another CentOS box with Git 1.7.1 and it worked fine. 
> 
> In all failed cases apache logs indicate: <timestamp> [error] Re-negotiation
> request failed. 
 
Renegotiation failed? There has been TLS security hole regarding to
renegotiation, and many patched TLS implementations do not allow renegotiation
unless the other side is patched too.

Maybe only one of the sides is patched? Both should be patched. One way to
find out if server is patched is to connect with client (e.g. Gnutls 2.10)
that supports safe renegotiation and disallow connecting to unpatched servers
and see if it connects or not.

-Ilari
