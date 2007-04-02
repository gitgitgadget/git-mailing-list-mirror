From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH] git-svn: avoid respewing similar error messages for missing paths
Date: Mon, 02 Apr 2007 03:30:37 -0700
Message-ID: <m2lkhb6pbm.fsf@gmail.com>
References: <m28xdkvsxx.fsf@ziti.fhcrc.org>
	<20070327190004.GD16591@localdomain> <m23b3qts11.fsf@ziti.fhcrc.org>
	<20070331005448.GA6948@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 12:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYJoF-0005Uz-UN
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 12:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397AbXDBKan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 06:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbXDBKan
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 06:30:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:26696 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965397AbXDBKam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 06:30:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1498625uga
        for <git@vger.kernel.org>; Mon, 02 Apr 2007 03:30:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=ti9z7TjEOM8UtEO3RTjFy71V+bijjCX2BLjH3OMKlzqRWXnin2fEH0d57MXsgKhtfge/YC/GDM5a1rO1R5X48BYqnNWoIPgLEs0x8wLTQviJsnEqePJd263+jWR+baHdi7z1wcieWEYshSZXYyaASQ3PAZ+9WnfhIYJsGmYqPqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=nDrc5MUYzPxoIuM19YePSGaLK3Dy745YzcXEE4XdPccJ1ODNaEA176uEiMmTXomsGdgIGtn5defOm2JFjYB4Ug0nOnkm3/9HQqUjl5UpYVIbKQgMIJ3UpJcSQ97r0Az6yhA/S3YKC1T3QQOpBEStrKskZmAVJfB9lljFCpuRvjI=
Received: by 10.67.97.7 with SMTP id z7mr4366628ugl.1175509841008;
        Mon, 02 Apr 2007 03:30:41 -0700 (PDT)
Received: from ziti ( [193.62.205.247])
        by mx.google.com with ESMTP id 59sm6793067ugf.2007.04.02.03.30.39;
        Mon, 02 Apr 2007 03:30:40 -0700 (PDT)
In-Reply-To: <20070331005448.GA6948@muzzle> (Eric Wong's message of "Fri, 30 Mar 2007 17:54:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43599>

Hi Eric,

Eric Wong <normalperson@yhbt.net> writes:

> We ignore errors if the path we're tracking did not exist for
> a particular revision range, but we still print out warnings
> telling the user about that.
>
> As pointed out by Seth Falcon, this amounts to a lot of warnings
> that could confuse and worry users.  I'm not entirely comfortable
> completely silencing the warnings, but showing one warning per
> path that we track should be reasonable.

Thanks, this is much quieter.

I have the impression that the initial fetch phase is taking longer
than it used to.  This could easily be due to network and server load
related issues, but I wonder if something in the parent following /
path searching is different.  The first git svn fetch seems to do
nothing for a very long time (except emit a few of the warnings) and
then once it starts actually adding commits it goes quite fast.  This
isn't really a problem as the initial fetch is a fairly rare
operation, but I wondered if this made sense based on recent git-svn
changes...


+ seth
