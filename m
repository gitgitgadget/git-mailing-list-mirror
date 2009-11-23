From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git describe oddity: ignoring recent tags...
Date: Mon, 23 Nov 2009 13:38:46 +0100
Message-ID: <46a038f90911230438m2c147b34nbd95cd74777f6be9@mail.gmail.com>
References: <46a038f90911230401sb2b1dd7u21b5d7edefe510eb@mail.gmail.com>
	 <20091123123048.GA10172@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 13:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCYC7-0000n6-Gv
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 13:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbZKWMim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2009 07:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbZKWMim
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 07:38:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:33825 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbZKWMil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 07:38:41 -0500
Received: by ey-out-2122.google.com with SMTP id 4so970782eyf.19
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W7E/oR0zx7nQ5aR/LSabRCHBJQRWG6p3Y1sxF6LcTts=;
        b=IwBb8lIeCIUYvsmbka+rIU4/Z00VddTwcsj8SpwR+OJrjmGWBSzl7NufnDI2p+LBQS
         tqmCfOSjDGkk75Sv/K4UsmZQ52N3FVm6qRL4f0t2h9ofNdIlaBYkkUwDGBM42oJAgoHH
         x6+JUnPtKAxIWp4ugvH9dNjKtGnNH2o35kS00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M+LTLY81g+HEwuHtV10I5tbz22HG11xRpFMZpIvLvSoEAs/TnnajII2niK0bNTsded
         tJF2UYr5yN0hRp5uD8Q3Myz8s2EdpBx93XxfmmhtI2BP8G/2RiVStB492o0ySGuW2Roq
         ghE8fK84Xx/iFy2YqSfNMnlni0T9/YS8uRG8E=
Received: by 10.213.0.197 with SMTP id 5mr3545821ebc.93.1258979926952; Mon, 23 
	Nov 2009 04:38:46 -0800 (PST)
In-Reply-To: <20091123123048.GA10172@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133501>

2009/11/23 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> They are lightweight:
> $ git cat-file -t olpc-update-2.19
> commit

Hmmm. I thought a tag with a _message_ was not lightweight.

$ git tag -ln
=2E..
olpc-update-2.16 Release 2.16
olpc-update-2.17 Release 2.17.
olpc-update-2.18 Rlease 2.18.
olpc-update-2.19 Release 2.19.

Argh... I see now - git tag is being helpful and showing the first
line of the commit msg instead of the tag msg, so I thought they were
full tags.

DWIM bites again! ;-(

> And using --tags "helps" here:
> $ git describe
> olpc-update-2.16-20-g2d4e4b8
>
> $ git describe --tags
> olpc-update-2.19-3-g2d4e4b8

Right. Doesn't make a difference with 1.6.0.6 but it does with
1.6.3.1.26.gf5b223



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
