From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 13:41:35 +0100
Message-ID: <201002071341.36440.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002070248.03855.johan@herland.net> <cb7bb73a1002070314t4f382d31k91423eac00a68715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 13:41:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne6SW-0001CP-3J
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 13:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681Ab0BGMlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 07:41:47 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:45698 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297Ab0BGMlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 07:41:45 -0500
Received: by fxm3 with SMTP id 3so6250769fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WNmma7ewZagVpGnSK3unjInDd20nTYhw+M4KuLM7Avg=;
        b=IPC851z794ayOyRBosbsnffPFmRKcq/4hQAofE4jz3AOsmQIDfgc0l3N7upOhumMby
         MHPfTZ2SEJFF9Rx/PZ3fr04qEHgN/Nry+nwW6w5wiIbgqdPd9mmOi1nsQoVADgIT08Yv
         ITWQmtJ9tMI7Y0bu88eN0pWnZX0NscTCV/yoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cz0Wb9Tc2sRF1xkf7sieV20raI9OjvOHvNpeme3yeS/BUbPUqFcr3ECnGnzCdEvyvM
         My6GsiUnw8iEznUSfFFKES4hjRG6+yAnv5P+pOBpNkJLyMALmgns+Lkw3KqWmyMk7PVT
         wJKYYBGzssy1MKTs/mPLqJsaEGT1/c9Qev0K4=
Received: by 10.223.82.14 with SMTP id z14mr2412319fak.1.1265546504225;
        Sun, 07 Feb 2010 04:41:44 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 21sm4963181fkx.55.2010.02.07.04.41.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 04:41:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002070314t4f382d31k91423eac00a68715@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139237>

On Sun, 7 Feb 2010, Giuseppe Bilotta wrote:
> On Sun, Feb 7, 2010 at 2:48 AM, Johan Herland <johan@herland.net> wrote:
> > On Sunday 07 February 2010, Jakub Narebski wrote:
> >
> > > Also, perhaps "git notes show" should acquire --batch / --batch-check
> > > options, similar to git-cat-file's options of the same name?
> >
> > I'd much rather have support for ^{notes} (or similar) in the rev-parse
> > machinery, so that you could look up deadbeef's notes by passing
> > "deadbeef^{notes}" to 'git cat-file --batch'.
> 
> Maybe something like deadbeef@{notes[:namespace]}? The ability to
> embed the notes namespace to use in the call is very useful to be able
> to access all the notes with a single git call.

That is just bikeshedding, but I'd rather not use '@', which currently
is used only for _reflog_ based revision specifiers: [<ref>]@{<date>},
[<ref>]@{<n>}, @{-<n>}, for notes which are not reflog based.

We can use

  echo <commit>^{notes} | git --notes-ref=<namespace> cat-file --batch

or perhaps

  echo <commit>^{notes:<namespace>} | git cat-file --batch

-- 
Jakub Narebski
Poland
