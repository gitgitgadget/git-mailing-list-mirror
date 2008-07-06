From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Mon, 7 Jul 2008 00:39:52 +0400
Message-ID: <20080706203951.GB1721@dpotapov.dyndns.org>
References: <20080620082034.GA24913@elte.hu> <m3d4mcmq20.fsf@localhost.localdomain> <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com> <7vprpqdbjx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 22:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFb2Y-00085f-5s
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbYGFUj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757051AbYGFUj7
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:39:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbYGFUj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:39:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so566383nfc.21
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qWPFXUZubHn7+BAwbVdsV4rOgdRlWkav6sulj1YVKFQ=;
        b=fwsw4cAblCu8Q1mQOFlpww2ClxrkbbZuQgJNWWgd1vFyCG52QZVKjOFgCbSaUO2nex
         /UoIuRNhnAzfJ+rsZ66GY+2fLO+29ErxVJ1GLWP/dGZ/TH9yQMOjE7XuRnjgdJ+OmpDu
         Cz5CxPjtV5wVSO8R0xbCvgVMQnIcJ0wySkvvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fDi88NeWxFwVEsCDyeFgE6Omn1cU3R9gblOY6Carka9mzdLX4fb2obcFRuey8QRVRW
         72n7fD5e2Jnal/rEiimh788+h1jNLflVaWe9TXLKbKOOw1bDR1oP9mjoYdOfBDrZtf7/
         bpLVYaycv3hVmw/W0C9aN56HJlntuSYW04iMQ=
Received: by 10.210.117.1 with SMTP id p1mr2458544ebc.4.1215376797393;
        Sun, 06 Jul 2008 13:39:57 -0700 (PDT)
Received: from localhost ( [85.141.151.81])
        by mx.google.com with ESMTPS id z37sm4997183ikz.6.2008.07.06.13.39.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 13:39:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vprpqdbjx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87552>

On Sun, Jul 06, 2008 at 01:04:18PM -0700, Junio C Hamano wrote:
>     Two other shorthands for naming a set that is formed by a commit
>     and its parent commits exists.  `r1{caret}@` notation means all
>     parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
>     its all parents.

So, I would say that rev^! is shorthand for rev^@..rev, but it does not
actually work:

git rev-list 7ac749c^@..7ac749c
fatal: ambiguous argument '7ac749c^@..7ac749c': unknown revision or path
not in the working tree.

yet "^rev^@ rev" syntax does:

git rev-list ^7ac749c^@ 7ac749c
7ac749c96d143ba4f76723959892cbaddbe8ed07

Is it a bug or feature?

Puzzled...

Dmitry
