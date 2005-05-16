From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFD] Ignore rules
Date: Mon, 16 May 2005 11:35:22 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.16.09.35.22.73817@smurf.noris.de>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net> <20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com> <20050514153027.GN3905@pasky.ji.cz> <7vsm0py8vz.fsf@assigned-by-dhcp.cox.net> <2cfc4032050514181127c02e43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon May 16 11:44:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXc9A-0005W4-9x
	for gcvg-git@gmane.org; Mon, 16 May 2005 11:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVEPJoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVEPJmE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 05:42:04 -0400
Received: from main.gmane.org ([80.91.229.2]:8107 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261523AbVEPJlW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 05:41:22 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DXc5e-00054b-7b
	for git@vger.kernel.org; Mon, 16 May 2005 11:40:46 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 May 2005 11:40:46 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 May 2005 11:40:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Jon Seymour wrote:

> a. pushing the ignore logic into the core git tools such as git-ls-files
> 
> b. including the current ignore .* rule as a default ignore rule that
> can be overridden by a .gitignore file

I'd say YES to both.

My preferred ignore file logic would be:

- stop at first match (that's more efficient)
- !pattern prevents exclusion of matching files
- bash-style shell globs, except that ...
  - a pattern that starts with / is a regexp
  - * doesn't cross directory boundaries, but ** does
- I don't need a per-repository (i.e. non-checked-in/propagated)
  ignore file.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


