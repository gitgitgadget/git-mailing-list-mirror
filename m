From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] commit-tree: free commit message before exiting
Date: Sat, 2 Oct 2010 15:50:44 -0500
Message-ID: <20101002205044.GA30541@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
 <20101002084100.GH29638@burratino>
 <AANLkTikZ5cn8biMvMPzXz6U2J=3yg1KJXayHD-7Cx8Me@mail.gmail.com>
 <20101002182600.GB24523@burratino>
 <AANLkTim6hA5ShAYWm63vyybyTqRxgKVjv3EFcQ5dZWCW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 22:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P295m-0003wq-2W
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 22:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab0JBUx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 16:53:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61734 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab0JBUx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 16:53:56 -0400
Received: by iwn5 with SMTP id 5so5247496iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=d7kKI2vZLz/ATE1PqY2Kyo85mnCINzJQ3Me28XV3lXA=;
        b=gQ5aHDpguFj1zVggE4Y9fDjauw0ACSJI0tnJ5SJTC/fQdPvzBnsbyhbm1+TRAfAIMS
         1++oacTT6hWZKES3tdYh2Z71yffOexGvxp+vkuyjhsdhMWiT0ryWsroAylIA2+a9SwUH
         rpzS+6SHETdT2kTMnDrT5R3JG0cIKn5XvGJmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RBGggtuFUfAiB6cCNlC9iT3a+ViBs288ZdQWFGmkgwtw8Oi5jDu1hYE58OOccS1YPj
         dG/jhWcs1cy44ywLSEAbPTP7PDNgcUioYRF7llx2ulfeOn63LQGdQy0OonTjkXUhpmmQ
         NTQ5LjsluUIvp9Z8mcG33Ra8fDUvqcfqQzAXo=
Received: by 10.231.193.11 with SMTP id ds11mr6154239ibb.192.1286052836317;
        Sat, 02 Oct 2010 13:53:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d13sm947967ibb.20.2010.10.02.13.53.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 13:53:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim6hA5ShAYWm63vyybyTqRxgKVjv3EFcQ5dZWCW@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157813>

Sverre Rabbelier wrote:

> The question of course is, is there anyone interested in cleaning up
> this mess? Do you mean to keep it up and get the test suite to the
> point where there are no leak warnings?

I was thinking more along the lines of maintaining a branch with
--valgrind set up to do leak checking, and collecting patches to deal
with leak warnings as people write them.

My current itch is sussing out cherry-pick leaks.  So at the moment I
only need to be able to run a small subset of the test suite.
