From: Scott Johnson <jaywir3@gmail.com>
Subject: Re: Feature Proposal: Track all branches from a given remote
Date: Sun, 26 Oct 2014 02:57:45 -0700
Message-ID: <CAEFop40qOPaq-6QrvNR0_MsgTv4K0jDNqb+m=BUZzFSXQ35YSQ@mail.gmail.com>
References: <CAEFop41rvXCAawW7zWGzT251zWyyoMhQbg=5vtHzQrbk4W6D_Q@mail.gmail.com>
	<20141026001610.GK312818@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net
X-From: git-owner@vger.kernel.org Sun Oct 26 11:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiKcG-0000VJ-To
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 11:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbaJZJ5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 05:57:47 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:64147 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaJZJ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 05:57:46 -0400
Received: by mail-yh0-f47.google.com with SMTP id i57so222637yha.6
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=W/zvUD3GiTNqRg0jGmZZ16iQ16EcffByONdC23YtlJY=;
        b=diemW7e2SkXNNLHB+FIGD5QXWj+vEbXh7mFUEIZkaCmT1otJzxP+nrskskrFlWgGIM
         Pq8ybqEW9T+x8eocwuqYKweLbTrfdm3teBOfmf7pdduj2bcexfFQHPsOEbJTXOu3sZG4
         lHZ6FkqU5an19hWIkuydxiod9LxXKweu/bfxJbMrh+Ic7VAL35UKElm4EeRIcCk7RcC9
         ohmCtx33kL8R7zAxA6TcvUcKlQMOyQzvSUZToFboPwB5fF2gYwrmflejpjnOPlzuHcFZ
         NXWrI5Oh69DC3yyqQaDAQvzjNp0cQ6N1yRjz6hsgpTTQfJFnFFMTY/8UCLkoVMpfb5/o
         VfmQ==
X-Received: by 10.236.206.42 with SMTP id k30mr15454061yho.58.1414317465565;
 Sun, 26 Oct 2014 02:57:45 -0700 (PDT)
Received: by 10.170.132.210 with HTTP; Sun, 26 Oct 2014 02:57:45 -0700 (PDT)
In-Reply-To: <20141026001610.GK312818@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian:

> [remote "origin"]
>   fetch = refs/heads/*:refs/heads/*

Yes, you're right, this works just fine as long as I move out from a
branch that's not in the remote in question, for example by doing:

git checkout -b nothing
git fetch

- OR -

git pull

Do you think there would be any interest in a patch that added this as
a simple command line option, though? I guess the idea of this patch
then would simply change this line in the .git/config file for the
length of the operation (and specified remote), execute the git pull
command, and then reset the configuration after the command finished.
(There really wouldn't be a need to affect the configuration on the
filesystem - simply the effective configuration used while git is
running for this operation).

Thanks,

~Scott
