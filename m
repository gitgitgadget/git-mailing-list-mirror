From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn in 1.5.4~rc2 somewhat broken?
Date: Sun, 30 Dec 2007 11:07:58 -0500
Message-ID: <20071230160758.GA7520@dervierte>
References: <87wsqw49dj.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 17:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J90iF-0003MA-HU
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 17:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbXL3QIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 11:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbXL3QIG
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 11:08:06 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:18471 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755790AbXL3QID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 11:08:03 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2863173hsz.5
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 08:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Eg8S0EAHxwBK1wJuiLTVU/kGGmCFFiRSPsAvLvIj9y4=;
        b=CemCm642kHMvSkYvrd30XPliyukJUFq/e6L74K7fpp6euxKCb+YGjUacw1HOlm5JTE/H2UBsqPhKAsaq66ngk0q+xgYeUuZmQSm0UAigp/BcQq7Qt1GtxKe5BUxa3CP/o2jIIkTamhhdlBhvPiiWJCS7PrPxjfGdiIJ5ZwKqpJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pw2S+By4lakMAQNtuyL6MiOtNXZmhpgB9SYuzrdPG5G32tiTc4mdDqer61f96G5ElOA+94VU5JpuAFA8W63d4b/u5rnTff/R1H0Y1yvCv9U/DA5JpjXwQOJplEtcMmDoNc2KwolTDSw3YzFqMsgKqmf10DEA/ck4V7YSP8o/LfU=
Received: by 10.151.13.7 with SMTP id q7mr3079573ybi.82.1199030882249;
        Sun, 30 Dec 2007 08:08:02 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 7sm11002857wrh.22.2007.12.30.08.08.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2007 08:08:01 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 60243EFC9B; Sun, 30 Dec 2007 11:07:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <87wsqw49dj.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69371>

On Sun, Dec 30, 2007 at 02:09:28PM +0100, Florian Weimer wrote:
> I just tried to run "git svn fetch" on a clone of a Subversion
> repository that used to work fine with 1.5.3.  After trying to fix some
> things up (sorry, scrollback buffer is not deep enough), it now reports
> an index mismatch:
> 
> Index mismatch: efcc3165fb64519ff1784903112d725c8682d5d2 != b3e7f07b5e4b79f682718fe6a31107d74ca35ce6
> 
> And it finally bails out with:
> 
> Last fetched revision of refs/remotes/git-svn was r45313, but we are about to fetch: r851!

Messages like these usually mean you've changed refs/remotes/trunk,
which will confuse git-svn unless you know what you're doing.
Fortunately, you can usually "rm -rf .git/svn" and git-svn will sort
itself out on the next fetch.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
