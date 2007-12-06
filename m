From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [RFC] Mirroring svn
Date: Wed, 05 Dec 2007 22:45:25 -0800
Message-ID: <1196923525.10408.103.camel@brick>
References: <1196922153.10408.101.camel@brick>
	 <20071206064317.GC18698@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AUV-0002pa-CL
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbXLFGp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbXLFGp0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:45:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:31443 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXLFGpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:45:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so134906rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 22:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=sElfjvmiogkndW546fpVXkMc53La4aNbiye6BC7hAMU=;
        b=l8mYlDvaiFom04s57XAlMr2EISXBgYytW/MgbzKuGjGl0jNkRNDtruUMAc9BgejP3qdOBIdVkt2NT7Tdz7BXVxQiwJmsa6uLUiW3ukgGbQ5RSOogscUgC9KLEGSopw0IV9N59ZRb04DJFMpz/2iC9chPesnQteKnvCzFrufwa64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=P9Iigqrn/DwHy2y3ks50eoNVRYPYNNRceK0QjgsIXud9KDyukzfR3aHKIINnmAHEfUIzhlOWGkws6yIi+VRJzG1CMs9J0Xiriasn+/VD/VHFZJlZJx2I8ALaH3dLr0LjjbX37ExeTzaazhCR/24S4hCLkMMx0Fe7MPjEHNKVsz8=
Received: by 10.140.180.13 with SMTP id c13mr1757332rvf.1196923524112;
        Wed, 05 Dec 2007 22:45:24 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id l17sm310621rvb.2007.12.05.22.45.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 22:45:22 -0800 (PST)
In-Reply-To: <20071206064317.GC18698@coredump.intra.peff.net>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67259>

On Thu, 2007-12-06 at 01:43 -0500, Jeff King wrote:
> On Wed, Dec 05, 2007 at 10:22:33PM -0800, Harvey Harrison wrote:
> 
> > // fetching someone else's remote branches is not a standard thing to do
> > // so we'll need to edit our .git/config file
> > // you should have a section that looks like:
> > [remote "gcc.gnu.org"]
> > 	url = git://git.infradead.org/gcc.git
> > 	fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> > // infradead's mirror puts the gcc svn branches in its own namespace
> > // refs/remotes/gcc.gnu.org/*
> > // change our fetch line accordingly
> > [remote "gcc.gnu.org"]
> > 	url = git://git.infradead.org/gcc.git
> > 	fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
> 
> FWIW, if you are writing a shell recipe for other people to cut and
> paste, you can say this as:
> 
>   git config remote.gcc.gnu.org.fetch \
>     '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'

I thought about that, but I like to encourage people to actually look at
the config file, it's pretty easy to understand.

Harvey
