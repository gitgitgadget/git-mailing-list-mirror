From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 17:00:47 +0100
Message-ID: <200701151700.48159.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVc-0000Hj-Hu
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:36 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAl-0003eK-8Z
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbXAOQAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 11:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbXAOQAc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 11:00:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:56591 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbXAOQAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 11:00:31 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1386907uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 08:00:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uYAPQrdorMohtjvFtNeOlNN2wmpJxEBytEUPD7CaN5r4ge/Q1O7SquG48oMgpq3dCkXyIRtY4r3tezKRGbe+YRZanL2hOTC+XKRVsKl3rOMlQnwj8L+A8nV5bvMC0UWSvLZUenQ1Cd+UQnJQ/o9ZWCtyCVrmUfIyGuHBEYxW878=
Received: by 10.67.103.7 with SMTP id f7mr5612205ugm.1168876829800;
        Mon, 15 Jan 2007 08:00:29 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id j1sm7006940ugf.2007.01.15.08.00.29;
        Mon, 15 Jan 2007 08:00:29 -0800 (PST)
To: "Nikolai Weibull" <now@bitwi.se>
User-Agent: KMail/1.9.3
In-Reply-To: <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36846>

Nikolai Weibull wrote:
> On 1/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Mon, 15 Jan 2007, Eric Wong wrote:
> 
>>>> Would you write "git repo-config --perl", then? ;-)
> 
>>> The below patch should be a start (only tested on my fairly standard
>>> .git/config).  A --python option should be easy, too :)
> 
>> A bit shorter (and gets the booleans right, plus being even easier
>> towards --python extension):
> 
> If we're going down this slippery slope, why not just give up and add
> a --xml switch instead?  Readable by all and a lot more flexible than
> --perl, --python, --ruby, --tcl, --sh, --c++, --fortran, --lisp,
> --html, --that-next-silver-bullet-language [...].
> 
> That said, parsing the config file as-is can't be so difficult that we
> need to export it to separate files with a different syntax, now can
> it?

Parsing the config file is not _that_ difficult (the first post in this 
thread had config reader in Perl), but it is not that easy: case 
(in)setiviness, quoting, escaping, comments, removing leading and 
trailing whitespace when not quoted...

P.S. I'd rather have an additional implementation (in Perl) conforming 
to yet to be written git ini-like config file specs, to find places 
where canonic parser, git-repo-config, doesn't conform to the specs.
-- 
Jakub Narebski
Poland
