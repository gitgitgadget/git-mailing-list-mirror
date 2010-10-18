From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Add support for subversion dump format v3
Date: Mon, 18 Oct 2010 04:54:08 -0500
Message-ID: <20101018095408.GA5641@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:57:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7mTa-0005pV-8B
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0JRJ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 05:57:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60925 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0JRJ5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 05:57:47 -0400
Received: by gyg13 with SMTP id 13so240487gyg.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uobs7NkHKEGBbiddyhZ5Sclx8BUZH/3fjygD37bcD4w=;
        b=ExyDq9nf+EIUPvTcUfCpTi04OdpfcibWJCRc8ySoLHB9pooj/DZtek/m6Fmgoo2SpC
         BAdx8JEvr2cqP3ainjn5onRfN+fSLP0YLyIE9QH/AsVXKRaq4X7kWv9sLpkTql8XH/9E
         rECTeqvrOFFjh4/lfXdgCW0WI1NsMMRg/Ai2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uvj2Xr4Iawr+LLF+dvo6nD/B72+sJCAXZU6jPOURSysnkWUvOHok2u8KpT7VdDaoJi
         GZiNiQneN8nNyct86gSa+zEDh//skYLK0U2jSQy89l++XgyNJhXPCbX4ONlXr5t4sH1m
         I/7ChDm49PBUYeac8wTS/tPA5mUiZibSIs91E=
Received: by 10.151.108.17 with SMTP id k17mr6381144ybm.87.1287395866300;
        Mon, 18 Oct 2010 02:57:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i70sm7214328yha.22.2010.10.18.02.57.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 02:57:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159245>

David Barr wrote:

> Patch 1 adds the required infrastructure to fast-import.
> This features the addition of the cat-blob command

Patch 1: maybe someone wants to pick this up and make the minor
changes it needs (a test or two to maintain sanity)?

> Patch 2 adds the basic parsing necessary to process the v3 format.

The log message doesn't give context but the patch is good
and safe.  Unknown keys are ignored so it is basically a
no-op except for using a little more memory.

> Patch 3 adds logic around decoding prop deltas.

It would be nice if someone who is not Junio cleans up the style.

Patch 4 (unmentioned for some reason): the log message doesn't give
context but the patch is good.  I think this could be picked up right
away.  There would be semantically unimportant merge conflicts if
cherry-picking without the patches introducing buffer_read_binary()
and changing buffer_copy_bytes() to take an off_t.

> Patch 5 integrates svn-fe with svn-da to decode text deltas.

I like it a lot but am interested in the follow-ups to Ram's comments.
Of course this requires the svn-da series so I'd prefer to give it
a few more days' cooking.

Summary:

 - patch 4 could be picked up right away imho
 - the rest need some work, but not much
 - the series is available from
   git://github.com/barrbrain/git.git svn-fe3

Regards,
Jonathan
