From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 08:27:04 -0500
Message-ID: <20120408132704.GB4103@burratino>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
 <20120408124652.GN2289@goldbirke>
 <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 15:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGs9F-0007wv-67
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 15:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab2DHN1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 09:27:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51065 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab2DHN1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 09:27:09 -0400
Received: by iagz16 with SMTP id z16so4887030iag.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZzaFXNzKnsbIBfYYhwZivmqMdsTPdQOwdl/01HdgAts=;
        b=zKRjKYmNY7KJspPpKOlY+zjyA5bf++zToROuShsCaKg4txG7l8ERuVK72cnAgZBPaY
         8Fm+myYgqGCuLYn6kJaf8or/eHOtPoQDPR5hFHYlcP6Eo3URSnsq8fo7phs7o9Kc9fnY
         Pkh+X7uKFhAkb2e71HM0muBte3CSrrq3uCZI9E6gv9rMev9EWVTBm/a5OpY9K4kMlxcP
         4CQV3i86Lkh65JqLvdVd4t80xRRc16WuJ6e+gXyLIjtbrp2+cFBqpTm1Qv/GIds/KD/K
         /7paOpbZrRz5+gwtV70PrljJvxjMe9DZmehXspznJogM5sjtUoMv4sozXD8Sl80Oy6qb
         JnPA==
Received: by 10.50.163.69 with SMTP id yg5mr2794020igb.56.1333891628931;
        Sun, 08 Apr 2012 06:27:08 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gr1sm11579137igc.1.2012.04.08.06.27.07
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Apr 2012 06:27:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194998>

Felipe Contreras wrote:

> So we should never make any cleanups because some custom completion
> functions might theoretically break?

No, tasteful cleanups that don't break custom completion functions are
very welcome.

Also if you have evidence that this is definitely (not just possibly)
only a theoretical problem, then it would not be a regression.  But I
actually find it likely that custom completion code would have
imitated the old completion code in git that used the suffix argument,
so...

Can you remind me what the benefit that the user is getting from this
patch in exchange for us breaking their tab completion?  The title
("simplify __gitcomp") tells me exactly nothing about its impact
except that it is perhaps supposed to result in no behavior change.

Sorry for the fuss and hope that helps,
Jonathan
