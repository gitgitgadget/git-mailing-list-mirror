From: Joseph Parmelee <jparmele@wildbear.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 19:29:11 -0600 (CST)
Message-ID: <alpine.LNX.2.00.1109281914510.29373@bruno>
References: <alpine.LNX.2.00.1109271742460.24832@bruno> <7vty7xttxh.fsf@alter.siamese.dyndns.org> <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com> <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk> <alpine.LNX.2.00.1109280555460.25187@bruno> <7v1uv01uqm.fsf@alter.siamese.dyndns.org> <20110928222542.GA18120@sigill.intra.peff.net> <20110928230958.GJ19250@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 03:29:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R95RB-0001h1-ND
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 03:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab1I2B3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 21:29:16 -0400
Received: from ip205-30-10-190.ct.co.cr ([190.10.30.205]:50522 "EHLO
	bruno.wildbear.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754186Ab1I2B3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 21:29:14 -0400
Received: by bruno.wildbear.com (Postfix, from userid 503)
	id C4CD61BE062E; Wed, 28 Sep 2011 19:29:11 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id 93E491BE062B;
	Wed, 28 Sep 2011 19:29:11 -0600 (CST)
X-X-Sender: jparmele@bruno
In-Reply-To: <20110928230958.GJ19250@thunk.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182379>




On Wed, 28 Sep 2011, Ted Ts'o wrote:

> On Wed, Sep 28, 2011 at 06:25:43PM -0400, Jeff King wrote:
>> [1] This is a minor nit, and probably not worth breaking away from the
>> way the rest of the world does it, but it is somewhat silly to sign the
>> compressed data. I couldn't care less about the exact bytes in the
>> compressed version; what I care about is the actual tar file. The
>> compression is just a transport.
>
> The worry I have is that many users don't check the GPG checksum files
> as it is.  If they have to decompress the file, and then run gpg to
> check the checksum, they might never get around to doing it.
>
> That being said, I'm not sure I have a good solution.  One is to ship
> the file without using detached signatures, and ship a foo.tar.gz.gpg
> file, and force them to use GPG to unwrap the file before it can be
> unpacked.  But users would yell and scream if we did that...
>
> 	       	     	   	    	   - Ted
>


Or you could just provide detached signatures for the compressed tarballs
like they have been doing for years at kernel.org (and many other sites). 
If tarball.tar.bz2 has a detached signature tarball.tar.bz2.sig, just
download them both and:

   gpg --verify tarball.tar.gz.sig

To argue that some people don't avail themselves of this feature is no
excuse for not providing it for those of us who consider it vital.  The
break in at k.o is no excuse for dropping this very sensible policy which
has protected us for years.  Just change the signing key and continue as
before.
