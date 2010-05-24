From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 16:42:18 +0400
Message-ID: <20100524124218.GC3005@dpotapov.dyndns.org>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <20100524121224.GB3005@dpotapov.dyndns.org>
 <AANLkTil83LQrMiAtAQwgfCtI6jeBHHq-P3DyjrIjcNtz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon May 24 14:42:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGWzG-00087p-OP
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 14:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab0EXMmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 08:42:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42600 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825Ab0EXMmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 08:42:23 -0400
Received: by bwz7 with SMTP id 7so946349bwz.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c3SJlkC7Glmn2KRqOhZQRLPwGUKbctayqSSYtV0lHkI=;
        b=n4nT+pbzW0VeTunj9Qf0fAIY04dYed3EtD7spjP13gd8IZRHi+ZNMQwFVumzjVuMPL
         fQ/+2fra4ccXLSvpDcZGfB10ulnh0fAgcQ6sRckxsDBr8TLQDMudGtUKujvVVnBiAuSD
         076yF8K2GqQIrd8inOIT7YKF2QnKGPtk82hUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kIDV6qgUZtAYIrcmXgcvMk1ugNZY0NZym8oFUBNt28qcgKCQZgoHYOdvLjzhaXBwW1
         MwkOPt3x6lDv1DpkAUHWKVaS71Ejm9DZ9JluuzEeTuXWdSkCI961JZ4V8PPJ2xcp0XoT
         gV5TfXwjNqYG/UVZxdvrhuxSHI1qmOnGuQ2rQ=
Received: by 10.204.4.135 with SMTP id 7mr2373843bkr.99.1274704941805;
        Mon, 24 May 2010 05:42:21 -0700 (PDT)
Received: from localhost (ppp85-140-126-0.pppoe.mtu-net.ru [85.140.126.0])
        by mx.google.com with ESMTPS id a11sm18953445bkc.21.2010.05.24.05.42.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 05:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil83LQrMiAtAQwgfCtI6jeBHHq-P3DyjrIjcNtz@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147629>

On Mon, May 24, 2010 at 02:22:13PM +0200, Erik Faye-Lund wrote:
> 
> I thought the original motivation behind this change was to make repos
> with CRLF-textfiles work without reporting diffs on all lines when
> autocrlf was enabled. Because checking in CRLF-files DOES happen, and
> for some of us the reality is that we have to deal with such repos.

Sure, but then CRLF files are treated as "binary" as far as autocrlf is
concerned. There is no conversion for such files even though automatic
text detection would detect them as. Thus, you do not have to worry that
enabling autocrlf may be incompatible with some repositories.

The situation is different when a file explicitly marked by attributes
to have some particular ending. It is a policy of that repository, and
if it is not followed, it means it is "corrupted".

It is similar to what you would have with SVN with eol-style=native for
some file while it being stored with CRLF inside of the SVN repository
(obviously, any standard SVN client should not allow this to happen).


Dmitry
