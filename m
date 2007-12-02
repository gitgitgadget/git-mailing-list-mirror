From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-merge --no-commit commits
Date: Sun, 02 Dec 2007 09:10:51 -0800 (PST)
Message-ID: <m3bq99vx7t.fsf@roke.D-201>
References: <19f34abd0712020857m757c57cfr358a81e47f38fac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Vegard Nossum" <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysLc-0000jU-8f
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXLBRKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbXLBRKz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:10:55 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:44352 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbXLBRKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:10:54 -0500
Received: by mu-out-0910.google.com with SMTP id i10so409411mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=gWf6emljrEahTJiNm2U5GnkndPWn8hCO914IzsphSxQ=;
        b=XzAT1HLIfqR7/xZR2W0mo06sXxYsjNwosn5OO55f6d3e9tHnclDDoYhgnaKJcRc7Xc4GhNkEo6wputBINq4E6RUTBR3LXVY8WCcYf2r1CwNPxQ3rRDaXL/xlmsZXArli3r083424Tc0nUqppwIMOyk10rnw71jyc+tnSdfoHSPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=KQdpj1Y6yy9cuL69XKn+vQf3q3dGOjdygfMu/ffc+k8bYSP5eT52/abzHi24GFBMrBHsOoS7re2NZ7cKRGliIs/RPSKXbMgYFT3a2SfV70odBko5WHiLeSBkMPX4Ye2w372WXU6n/ZWtm8svXp4D3We/40rAJmot+7+WW/7Cbzo=
Received: by 10.86.65.11 with SMTP id n11mr9684757fga.1196615452715;
        Sun, 02 Dec 2007 09:10:52 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id 4sm5600116fgg.2007.12.02.09.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 09:10:51 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB2HAlD7029860;
	Sun, 2 Dec 2007 18:10:48 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB2HAlUl029856;
	Sun, 2 Dec 2007 18:10:47 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <19f34abd0712020857m757c57cfr358a81e47f38fac8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66797>

"Vegard Nossum" <vegard.nossum@gmail.com> writes:

> I am using git 1.5.3.4 and just did the following (v1 and v2 are
> branches; v1 is a parent of v2):
> 
> git checkout v1
> git merge --no-commit v2
> 
> It simply fast-forwarded AND committed even though I explicitly told
> it not to. What gives?

The --no-commit option doesn't prevent fast-forward because
fast-forward doesn't really _create_ a commit (and -no-commit is
really about commit creation). It just advanced ref (branch head).

You probably wanted to use

  $ git merge --no-commit --no-ff v2

HTH
-- 
Jakub Narebski
ShadeHawk on #git
Poland
