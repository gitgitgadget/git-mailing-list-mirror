From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 11:46:28 -0500
Message-ID: <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes> <20101018073102.GA3979@burratino> <20101018163836.GI22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 18:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7srS-0005wJ-6R
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 18:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab0JRQqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 12:46:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45787 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0JRQqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 12:46:51 -0400
Received: by ywi6 with SMTP id 6so523010ywi.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=wBhuItnfMRIuH6uFfm4mrJa6fcyyMsp0YLF9CZOREgg=;
        b=mIRqD6EK1fLCXGPGBSRiEstV1KbUVcBrcykVPSYzf4q9ZjMKOvhmAvjNnGEvN6XSSm
         9qbNQyplnSLkjWu611M3u4Jh/mE6z2i0v60ciy2Wgk1njurVqeTmGnPwl38gTuleyOC+
         3xMXvHFD6qglh5u/EzQ8JR9/GGNIK0VltCtoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=StG7Xh9o6pGVg+6zpLhp4ZfXQnxuwnl46Afwui4aGQhzPPMnT/y0JbSkcit+8viNlp
         na7nXKGcJ6mTRL2gfvDsj12noDM/NZd/E+45gmVUbCrNU2VPuI2LL7AIuildM6s8mCLt
         1pA6X/VcOec/1DaeDf3N8vql3krKHB5jT1jgM=
Received: by 10.42.103.3 with SMTP id k3mr3136269ico.213.1287420409860; Mon,
 18 Oct 2010 09:46:49 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 09:46:28 -0700 (PDT)
In-Reply-To: <20101018163836.GI22376@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159264>

Heya,

On Mon, Oct 18, 2010 at 11:38, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Let me guess: you're targeting git-svn like functionality with all the
> dcommit/ rebase ugliness? I'm looking for a slightly nicer way, not
> too much more; (I) is just a sort of "ideal" target- it's just nice to
> think about it that way. It's needn't be entirely realistic.

I'm thinking we can just refuse to let through a commit that is
non-linear, as if there's a hook on the server side that rejects such
a history. Since we're representing the svn remote as a regular
remote, the user can just do 'git rebase @{u}" themselves if they end
up with a non-linear history.

-- 
Cheers,

Sverre Rabbelier
