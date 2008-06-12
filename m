From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 08:56:10 -0700
Message-ID: <4851471A.3030400@gnu.org>
References: <20080612002258.GC7200@leksak.fem-net> <48507C70.8010402@gnu.org> <20080612152928.GB6848@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 17:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6pAn-0006ev-Vz
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 17:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYFLP4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 11:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYFLP4O
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 11:56:14 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:51593 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbYFLP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 11:56:13 -0400
Received: by py-out-1112.google.com with SMTP id p76so1671490pyb.10
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=GkLbLov8cf3sDJ/x65MOID5jgETSdf9975wD46O/gQ4=;
        b=gN3L9mG8tdc8X+84/+bk4jxSdE2CtQDdGJPBr6VUAbL/uFY7v5k3nCY2zuHz7k9SH6
         5SFYrKxJpPHYO1GTriQ+bNgIZBnKfgOmU2wRGaYV9xLIdp7X4kOwXr+h5JVv/yMJ3UpF
         7iERCHcCY5P0vd9KZblz24yln8AJ6tPhf5LZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=A9bxnwRqw/6VU4nycA1emkWvLDQRvApl8QijT6a1j1tegrrA7p8+D/Hgol1yok5l5S
         x5cwUkvUUV1jb10vjXGVExI8ubQdN3wWA77Hpu0TFYJgksSvvFE/whrUSY7SdyVLoRE7
         FN9jtO/kBfZ0Bb5R9s5GHOgDE0UDi0ZDvlmW8=
Received: by 10.115.19.16 with SMTP id w16mr1718186wai.102.1213286172345;
        Thu, 12 Jun 2008 08:56:12 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id n20sm2487795pof.0.2008.06.12.08.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 08:56:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080612152928.GB6848@leksak.fem-net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84763>


> The reason why I didn't want `-C' to be `--reuse-message' is:
>  1. it is a misleading long option name, and
>  2. some days ago the long option was not really documented,
>     so everyone and everything is using -C.
>     (See
> 	git show bc47c29
>      and/or
> 	git grep -e reuse-message
>      in git.git)

Yes, I agree (though I still maintain that --reuse-message is better if 
only because it is more consistent).

>>> -M <commit-ish>
>>> --reuse-message=<commit-ish>::
>>> 	Reuse message from specified commit.
>>> 	Note, that only the commit message is reused
>>> 	and not the authorship information.
> 
> This is something I'd like to keep.

Do you have a use case?

> Later you speak of using the -e option to force edit of the message.
> I think that "-c" is not needed if you can use "-C f00babe -e".

Well, so is for git-commit but...

> Currently you can pass --author as a general option.
> Perhaps this is not as easy to handle for the user, but if we
> really really really want the -A/--author-override, we can add it later.

The idea is that -M = "-A -C ba123"...

Paolo
