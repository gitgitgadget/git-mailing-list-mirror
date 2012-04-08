From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 09:36:21 -0500
Message-ID: <20120408143621.GA2631@burratino>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
 <20120408124652.GN2289@goldbirke>
 <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
 <20120408132704.GB4103@burratino>
 <CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 16:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGtEL-0007rf-40
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 16:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab2DHOga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 10:36:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57531 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab2DHOga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 10:36:30 -0400
Received: by iagz16 with SMTP id z16so4928618iag.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NqCREIENrbmoHYdz8Ue+2c+RVkQBZOVqAPIZ6ZqKRqM=;
        b=MpXDcqFrmulaStN7ArJnLKowvjbfnesqbNmXVSbm1DOoxABLvT8/nD16KDmPTr76XF
         PEq/6Dwg1xVx0to4HqG1IEaOWl8MvcYtyOQpp0h23A7/Gr0a/ZqyonOCr0RWusf8/nVC
         OfDl/7/DYB9WNP1jd6dB6WcEtgHBIAJM5nQFXHzgdflN2ZEoC10z4RbCLz+Qk6RvsrAv
         5jARRnKbvVPPOQr4LmOvQyonPNw3lgaE8LgmPdtLGlwKjpYM2A4xwxgJqY/luKDkHjzS
         QMNV060iaPlZX/Fc9ozdUOEkQ4Za5milfLJhb29t1O08eV+WTPbc4UEmPSZFEnTZn3q9
         QS0g==
Received: by 10.50.194.194 with SMTP id hy2mr2268203igc.52.1333895787755;
        Sun, 08 Apr 2012 07:36:27 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id a10sm11763687igj.10.2012.04.08.07.36.26
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Apr 2012 07:36:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195001>

(dropping Shawn from cc since I'm not under the impression he works
 on the completion script these days)
Felipe Contreras wrote:

> Whoa! Breaking their tab completion? Where? Can you show me some evidence?

If you weren't listening before, I'm not sure what I can add now[*].

Luckily, I already said what I needed to say.  Yes, cleanups can be
good when they don't break things, and no, cleanups that break things
are not good.  Sometimes it is not obvious which category each case
falls into.  As you well know, "tests pass" is not enough (e.g.,
sometimes there are no tests!).  If you want someone to argue with,
you can find someone else.

Sorry,
Jonathan

[*] To be extra, extra clear: I never said your patch breaks people's
custom tab completion scripts.  I said it might do so and that that is
not very comforting to apply the patch when no one seems to have
thought carefully about how to investigate that and mitigate the
damage if there is any.
