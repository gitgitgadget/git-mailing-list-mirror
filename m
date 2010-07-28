From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 01:06:46 -0500
Message-ID: <20100728060646.GA16400@dert.cs.uchicago.edu>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> <20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com> <52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com> <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com> <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 08:06:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odzn2-0007X3-S7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 08:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab0G1GGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 02:06:48 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:50574 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0G1GGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 02:06:48 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id EE85EA1BF;
	Wed, 28 Jul 2010 01:06:46 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id B5D806914; Wed, 28 Jul 2010 01:06:46 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152039>

Sverre Rabbelier wrote:

> Also, sqlite is known to scale, is exactly one file
> worth of dependency, what's not to love (other than having to support
> upgrading to 'index vSqlite').

The frequent fsync()-ing.  Though that seems to be a problem with
pretty much anything that does not involve rewriting the index
with each change.

Maybe filesystems will cope better soon. :)
