From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 19:09:58 -0400
Message-ID: <20110928230958.GJ19250@thunk.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 29 02:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R94Az-0000gj-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 02:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab1I2AI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 20:08:29 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:48631 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab1I2AI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 20:08:28 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R94Al-0002H8-Ew; Thu, 29 Sep 2011 00:08:19 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R93GJ-0001VP-03; Wed, 28 Sep 2011 19:09:58 -0400
Content-Disposition: inline
In-Reply-To: <20110928222542.GA18120@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182375>

On Wed, Sep 28, 2011 at 06:25:43PM -0400, Jeff King wrote:
> [1] This is a minor nit, and probably not worth breaking away from the
> way the rest of the world does it, but it is somewhat silly to sign the
> compressed data. I couldn't care less about the exact bytes in the
> compressed version; what I care about is the actual tar file. The
> compression is just a transport.

The worry I have is that many users don't check the GPG checksum files
as it is.  If they have to decompress the file, and then run gpg to
check the checksum, they might never get around to doing it.

That being said, I'm not sure I have a good solution.  One is to ship
the file without using detached signatures, and ship a foo.tar.gz.gpg
file, and force them to use GPG to unwrap the file before it can be
unpacked.  But users would yell and scream if we did that...

	       	     	   	    	   - Ted
