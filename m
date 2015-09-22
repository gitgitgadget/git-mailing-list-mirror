From: Julian Andres Klode <jak@debian.org>
Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Tue, 22 Sep 2015 20:42:21 +0200
Message-ID: <20150922204203.GA6573@debian.org>
References: <1442054253-15780-1-git-send-email-jak@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bdwalton@gmail.com, davvid@gmail.com, hvoigt@hvoigt.net,
	johnflux@gmail.com, gitster@pobox.com, madcoder@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 20:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSWN-0008T8-TU
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbbIVSm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:42:26 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32806 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbbIVSmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:42:24 -0400
Received: by wiclk2 with SMTP id lk2so206972651wic.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rpPk1HXZqgnSMFjPrtXGnQu6GvGRLUHU/WmRki3/VPs=;
        b=Iz6RvDhMtVJb+IYcOHt7vDKfXcIi1ftbSsm41IcXBJ9+miEmpbrZYFLJR4rcfR1Ja3
         Dk2ObA7Z62afhuzbVCpGpcnxFV1nILUQWIYfyalnkzRj1f9d0NlWGtrS62TvBuL7d2c2
         hEn0SI1p9fS5G+6CFzhduYGp2Zhiaa3hITw1kNKJZ5TzwkhbVwvxFG+U1FyYlqg5T9K/
         1InBAfpfuChHnpk+8NgIQOzDfJuSdmfPNTvQYSTp7QMUQFCXZmBmcLnmnaXUeQ3yaPl7
         U/k7lNHKH63GtnyThbdjo654LCoSv21zIsbdSKS1Zr8jJnJGh7d9jL4ZCPaYZDBzhVaB
         /k2w==
X-Received: by 10.180.37.76 with SMTP id w12mr22546627wij.0.1442947343397;
        Tue, 22 Sep 2015 11:42:23 -0700 (PDT)
Received: from jak-x230 (p54B907B3.dip0.t-ipconnect.de. [84.185.7.179])
        by smtp.gmail.com with ESMTPSA id cm6sm4493785wib.22.2015.09.22.11.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2015 11:42:22 -0700 (PDT)
Mail-Followup-To: Julian Andres Klode <jak@debian.org>, git@vger.kernel.org,
	bdwalton@gmail.com, davvid@gmail.com, hvoigt@hvoigt.net,
	johnflux@gmail.com, gitster@pobox.com, madcoder@debian.org
Content-Disposition: inline
In-Reply-To: <1442054253-15780-1-git-send-email-jak@debian.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278415>

On Sat, Sep 12, 2015 at 12:37:33PM +0200, Julian Andres Klode wrote:
> Introduce an option to deny unsigned tags from entering
> a repository. This is useful in teams where members forget
> to sign their release tags.
> 
> It does not actually check whether the signature is actually
> complete or valid, it just checks for the beginning of a
> signature, as further checks would be too involved.
> 
> This effectively also denies un-annotated tags, as those
> are unsigned by definition.

No comments?

-- 
Julian Andres Klode  - Debian Developer, Ubuntu Member

See http://wiki.debian.org/JulianAndresKlode and http://jak-linux.org/.

Be friendly, do not top-post, and follow RFC 1855 "Netiquette".
    - If you don't I might ignore you.
