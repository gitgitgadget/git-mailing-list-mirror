From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options
 early
Date: Sat, 2 Jul 2011 06:30:08 -0500
Message-ID: <20110702113008.GA21526@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com>
 <20110621170416.GN15461@elie>
 <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
 <20110702095334.GA19090@elie>
 <20110702100436.GB19090@elie>
 <BANLkTik2t=qPfJe7JUsoeka79ZYYRmU_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 13:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcyP1-0000Va-7c
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 13:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1GBLaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 07:30:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34103 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1GBLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 07:30:15 -0400
Received: by iwn6 with SMTP id 6so3406594iwn.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OMs1CX7vBPTahJE/9nZJJvgndQWONMkgiCt3Cqrodkk=;
        b=hcluMDKHsoXoa9gZDP/IqZf8Vun+DvsK2nP4RV5/1IVDstlPzcdQ8LZ3FLDj76MNQT
         mS9DiHy5ysrU5hPZoAopCudIijoRuLKhYp+NP7DC+ahUmtWqQ6AdXm2dT3vV2L6XFKUY
         HYPoMtBBboCxFlFfM9QtvbD/faO2UIby19+sA=
Received: by 10.43.133.196 with SMTP id hz4mr4243720icc.331.1309606215364;
        Sat, 02 Jul 2011 04:30:15 -0700 (PDT)
Received: from elie (adsl-69-209-57-66.dsl.chcgil.sbcglobal.net [69.209.57.66])
        by mx.google.com with ESMTPS id ly7sm4353868icb.0.2011.07.02.04.30.13
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 04:30:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTik2t=qPfJe7JUsoeka79ZYYRmU_MA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176557>

Ramkumar Ramachandra wrote:

> Although pick_commits checks the validity of the
>     replay_opts strucutre before before starting its operation, this is
>     fragile design because the validity of the replay_opts structure
>     depends on pick_commits being called before anything else.

Thanks, that's a bit more concrete.  But it's not fragile, is it?
pick_commits() is the entry point to the cherry-pick machinery ---
anything that uses a struct replay_opts is called indirectly by
pick_commits(), no?

So (genuinely, even when I'm not pretending to be naive) I still don't
see the point.  I'm not even convinced it's a bad idea, since it's
still not clear to me what the idea is.
