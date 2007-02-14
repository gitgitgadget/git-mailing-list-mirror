From: Jeff King <peff@peff.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 12:51:40 -0500
Message-ID: <20070214175140.GA24684@cc.gatech.edu>
References: <vpq64a4bzp1.fsf@olympe.imag.fr> <20070214142731.GA1478@moooo.ath.cx> <45D33485.5020906@webdrake.net> <17875.14305.910866.273778@lisa.zopyra.com> <17875.14859.177000.558634@lisa.zopyra.com> <45D33D53.6040209@webdrake.net> <vpqbqjw65kj.fsf@olympe.imag.fr> <45D3412B.9010200@webdrake.net> <Pine.LNX.4.64.0702141237400.1757@xanadu.home> <45D34B17.70602@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOe6-0006qQ-Hw
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXBNSOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbXBNSOT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:14:19 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:63620 "EHLO
	sark.cc.gatech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbXBNSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:14:19 -0500
X-Greylist: delayed 1318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Feb 2007 13:14:18 EST
Received: from lawn-199-77-206-200.lawn.gatech.edu (lawn-199-77-206-200.lawn.gatech.edu [199.77.206.200])
	by sark.cc.gatech.edu (8.13.6/8.12.8) with SMTP id l1EHq4Hq027685;
	Wed, 14 Feb 2007 12:52:04 -0500 (EST)
Received: by lawn-199-77-206-200.lawn.gatech.edu (sSMTP sendmail emulation); Wed, 14 Feb 2007 12:51:40 -0500
Content-Disposition: inline
In-Reply-To: <45D34B17.70602@webdrake.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39716>

On Wed, Feb 14, 2007 at 05:47:03PM +0000, Joseph Wakeling wrote:

> For one thing, I might be making small changes or have unversioned files
> in my local directory that I don't want to copy.  I only want to push
> across the latest code in the branch.

rsync will efficiently push small changes. Just feed it input from git's
list of versioned files:

git ls-files -z | rsync -a --files-from=- -0 . host:/path/to/dest

-Peff
