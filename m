From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] branch: suggest how to undo a --set-upstream when
 given one branch
Date: Tue, 10 Jul 2012 18:00:14 -0500
Message-ID: <20120710230014.GA20873@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-3-git-send-email-cmn@elego.de>
 <20120710192408.GF8439@burratino>
 <7vliirgrun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 01:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SojPx-00011h-5P
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 01:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab2GJXAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 19:00:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45058 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab2GJXAX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 19:00:23 -0400
Received: by yenl2 with SMTP id l2so624937yen.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bgO/fBJi/nAT4Aod1a5C4Vj6xkCgkSbi9xAEMmUQ0x8=;
        b=WUYfkeHmXCI6bgMFM84awQIPLsYUjE0QtiHM/HuTrInSb4fnfHBkWkKwafKE1IjatN
         9QoU4z0w8YHjqpwVujuuvmOe2k8qT2hN0Pe7+9ocMGBx/onG6B8FT/hYOtpQKwsrtI3c
         POoqX7H5Oo4TKwGsISqWC2vqQCpx/470fiQ83I7h+Vyn63HTghRo790d4UE17NZWF8lm
         /BPlHWD71FwvC7KaFv9gigCwBkxkQlQXlYU8Bx6W78nO1FPnuIFSsKL5DJLwmBEhOOqu
         sKIhrP+QQLcyoyuTZ5SHUeLog7ocncb13/5/nfpzRpjrz85jXM8y+ajbG4VsvxFNvqUi
         lo3w==
Received: by 10.50.217.163 with SMTP id oz3mr13033271igc.5.1341961222690;
        Tue, 10 Jul 2012 16:00:22 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id s4sm12849173igb.1.2012.07.10.16.00.21
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 16:00:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vliirgrun.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201284>

Junio C Hamano wrote:

>                                                           I think it
> is better to leave them emitted unconditionally to the standard
> error stream, in order to train users away from using the old option
> that has its arguments wrong (the option does not take an argument
> it should, and makes the command line to look as if it takes two
> branch arguments in the wrong order).

I thought we already discussed that that is a side-issue?

The option is a mode option for the command, like "-m", "-d", or
"--edit-description".  I genuinely don't think the order of options it
takes is counter-intuitive.  The second argument defaulting to HEAD
and the behavior of creating the branch named by the first argument
when it does not exist are quite counter-intuitive.

Transitioning to a different argument order seems like it would just
make the command more complicated.  After the transition, there are
two options to explain, and during the transition, it is easy to make
scripts with gratuitous incompatibilities that won't work on older
systems.

Where is my thinking going wrong?

Jonathan
