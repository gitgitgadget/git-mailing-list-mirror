From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it for locating test files
Date: Thu, 04 Sep 2008 03:47:35 -0700 (PDT)
Message-ID: <m3prnkp4qq.fsf@localhost.localdomain>
References: <20080903091022.GC23406@diku.dk>
	<20080903170904.GB28315@spearce.org>
	<9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com>
	<20080904032118.GA3262@spearce.org> <20080904092311.GA25735@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Imran M Yousuf <imran@smartitengineering.com>,
	Imran M Yousuf <imyousuf@smartitengineering.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbCOL-0007no-T3
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYIDKrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYIDKrj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:47:39 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:22641 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYIDKri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:47:38 -0400
Received: by an-out-0708.google.com with SMTP id d40so584085and.103
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=lD84ncuMWH6RcmEEV6n4es03dzNEMKbNn3I69aVJAzU=;
        b=EMvxrLnl/QuCOYkfcwjgxz44fK1bUxmdFd1cvUJq77VXTKw6c7IXTWXe36Hwno8hxh
         t/f+R0x27GSY1m5qXDJryji5pjLvcmx0X0trt9TVett528wKuQkq1gGkF1SCsaRzQmNx
         8v77dYhqV2+mi2v+5iaN1ezVmGP8f88l2bnFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=L9rV+TavyzTgkzXSfOZuHGJkesLrtJ3iIV8f2/yZG7wLL8f92gkJxiiZZ6sreNbRF3
         oxrePQBt2d7jktrziOGW0iMYP/RLRWlB6GmbtiYDDQM+dXT1GE4riTIzSZSiuPf6IeeB
         83jzOgbFZMEAGb2u3npX86wBJgLqlgCnMc7tA=
Received: by 10.100.197.7 with SMTP id u7mr10596599anf.27.1220525256625;
        Thu, 04 Sep 2008 03:47:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.201.254])
        by mx.google.com with ESMTPS id c14sm19357400ana.4.2008.09.04.03.47.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 03:47:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m84AlSsY015777;
	Thu, 4 Sep 2008 12:47:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m84AlPX6015774;
	Thu, 4 Sep 2008 12:47:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080904092311.GA25735@diku.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94924>

Jonas Fonseca <fonseca@diku.dk> writes:

> Shawn O. Pearce <spearce@spearce.org> wrote Wed, Sep 03, 2008:
> > Imran M Yousuf <imran@smartitengineering.com> wrote:

> > > Almighty willing, I will submit my patches this weekend (on Saturday).
> > > I develop in NetBeans so that would make it easier for sure.
> 
> Perfect. You might be interested in the hopefully soon to be released
> jgit-based nbgit module:
> 
>  - http://nbgit.googlecode.com/
> 
> The feature set is limited but some of the basics features should be
> there.

Could you please add it to Git Wiki
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
when it is ready, at least for testing purposes?

TIA
-- 
Jakub Narebski
Poland
ShadeHawk on #git
