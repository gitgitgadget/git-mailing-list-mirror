From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 16:20:27 -0400
Message-ID: <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:32:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmE83-0005l0-8P
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbYDPUUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYDPUUa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:20:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:49918 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYDPUU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:20:29 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1764224mue.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Fzgf54haCHdRQEyQ4iqWbmt6DXRjqmQXxo1KepJVGB4=;
        b=Zet6oZfEqr9lbFYQic7s+IoKfxoTE5FwYvM4en8Xo/nwtj6SdyXH8JuooZ2AfuT+pznOjKzh9ShB6f2JEaJ6P39UT19saiMDczU2dqgEMzx9UHRbgZZ2Fztf017Z4MQ1x4XX7/wNUzVZDZOJ1zcVZxu3tR4c6G5j9ARxS94QjYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e9sh6Jzx9V9371NJFTorzYb2i+NNOuRix0Rl0P0CoOSJaa6QvZX+0reDxvXDbFvJMDulVOF3+9M/2/IznHFFT1O6LVD33XdCxxPOTDP8ASXpO5wR7BYu9yd8ovCXqCEwSPP3OwEf3v++mTxjSQ9isHyyNjE1221fkMk7prZ14lQ=
Received: by 10.82.177.5 with SMTP id z5mr647649bue.68.1208377227862;
        Wed, 16 Apr 2008 13:20:27 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 13:20:27 -0700 (PDT)
In-Reply-To: <20080416200107.GG3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79745>

On 4/16/08, Dmitry Potapov <dpotapov@gmail.com> wrote:
>  In this case, you already have a file with the wrong ending,
>  so file.txt will be shown as changed now, because if you commit
>  it again then it will be commited with <LF>, which should have
>  been done in the first place.
[...]
> If you do not want problems, you should use core.autocrlf=true
>  on Windows. Then all text files will be stored in the repository
>  with <LF>, but they will have <CR><LF> in your work tree.
>  Users on *nix should set core.autocrlf=input or false, so they
>  will have <LF> in their work tree.

Alas, the subject of this thread involves git-svn, and the typical
git-svn user is someone who has no way of rewriting the existing
history in their svn repositories.  Thus, files *will* be in the
repository that have the wrong line endings, and (as you noted) git
just gets totally confused in that case.

Nigel's example showed a few situations where git *thought* the file
had changed when it hadn't, and yet is incapable of checking in the
changes.

If all I had to do was checkout (thus converting everything to LF),
and then "git commit -a" to check in all the corrected files, then
git-svn would make one giant, very rude checkin to svn, and my
problems would be largely solved.  However, this does not seem to be
possible due to the problems you noted ("you are going to have
problems now").

Have fun,

Avery
