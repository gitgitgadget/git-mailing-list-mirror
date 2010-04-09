From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: nd/setup
Date: Fri, 9 Apr 2010 00:57:01 -0500
Message-ID: <20100409055701.GA9554@progeny.tock>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
 <20100408073825.GA15153@coredump.intra.peff.net>
 <20100408214233.GA32441@progeny.tock>
 <q2pfcaeb9bf1004082246w3fb6e18bw21943150cbeeb5c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O07D9-0001dh-SC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab0DIF4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 01:56:47 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:54401 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab0DIF4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:56:46 -0400
Received: by gxk9 with SMTP id 9so1856653gxk.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DDrCjhNqor0gF4huySTjh1q/g7hRxhhtMi/j9VjOndQ=;
        b=patluUESzadoQ86o0MGLm3cxQa1cq0ZvH6tS2R0DVaXbjtIjOI40qYDpI3nTWjfqel
         +fJG1UgLcj0MpUL2LogsM4AcvbhnZEzJQ9hQySUheXDXk5Q0UdpEA5OfSVY9jdoepogu
         W0U7j0zzUuwcgzdcGev96/A2FKkZXjcVBZJGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=W2KnwfFbv+GYa/Mx2NUT1a9905LfdWYcuMRqSjZL/yqvSRCCYhDxOTvzG1w7UYpiek
         zILniuRD7EsBIGlpi2omdUB5nffRi5hIAduLCzMoc3qhnAQsQMtFKP3fZagxMYhMQlmG
         bEWePMR6kkr9uRvIbh7P5AItT6m9g7VSzZZlQ=
Received: by 10.91.39.4 with SMTP id r4mr451595agj.107.1270792605879;
        Thu, 08 Apr 2010 22:56:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm621006iwn.9.2010.04.08.22.56.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 22:56:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <q2pfcaeb9bf1004082246w3fb6e18bw21943150cbeeb5c7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144408>

Nguyen Thai Ngoc Duy wrote:
> 2010/4/8 Jonathan Nieder <jrnieder@gmail.com>:

>> A few of the earlier patches seem iffy, though they all start with a
>> correct idea. =C2=A0For example, one of them changes the semantics o=
f
>> rev-parse --show-prefix without documenting it. =C2=A0So I have been=
 looking
>
> You meant "rev-parse --git-dir"?

I meant --show-prefix.  ad36c84 (worktree setup: calculate prefix even
if no worktree is found, 2010-04-05) teaches rev-parse to produce a
nonempty prefix even when there is no workdir but didn=E2=80=99t update=
 the
documentation:

    --show-prefix
         When the command is invoked from a subdirectory, show the
         path of the current directory relative to the top-level
         directory.

I suspect it=E2=80=99s a good change.  Git ought to correctly honor rel=
ative
paths on the command line even when there is no work tree.  But the
semantics are not clear any more --- when there is no top-level
directory, what is the prefix relative to?

Probably my other words of warning were also too extreme.  I have been
using a copy of git with nd/setup included, and aside from the
ls-remote problem I mentioned, I haven=E2=80=99t run into any trouble.

Cheers,
Jonathan
