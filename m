From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: nd/setup
Date: Fri, 9 Apr 2010 07:46:53 +0200
Message-ID: <q2pfcaeb9bf1004082246w3fb6e18bw21943150cbeeb5c7@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
	 <20100408073825.GA15153@coredump.intra.peff.net>
	 <20100408214233.GA32441@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O073V-00079d-4n
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab0DIFqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 01:46:55 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55058 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0DIFqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 01:46:54 -0400
Received: by ewy20 with SMTP id 20so1219761ewy.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6De4o/HI7Ga0wG2IYu3A7sTe62VwQDqn+5/u2tjwxUo=;
        b=kkp5AlccB/RKyPPifFtClKwdVxNxVvK4iKVe+ZP9bVIZiKfNxNCa+QE078wk0zaK8g
         YSnfVCN198u7yVlHO6stynTPNJAseQ6cw9FqUCdnHB37IsC3G6ed4g7fTAXhUKVTzHmg
         L/Cl//MSMK59mXitPa6PHsLrq+/nigu4Y6BFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xNr0tNpMWQU5jVXEPamWYqk7UpH8cVrrh8I9NQ4lEv6c+KazDaCLd6Fsbbsf3KGNXd
         TjRlKhPywoWt9Ov1ryQYmFBgibGdxm5DRogOnBpf5cmadnvfiQQE2Cpa/cOqtkzAxJ79
         K5YIZyUqg4NFXBKZrdtDVlNFMatFeGaKsYqpw=
Received: by 10.213.105.130 with HTTP; Thu, 8 Apr 2010 22:46:53 -0700 (PDT)
In-Reply-To: <20100408214233.GA32441@progeny.tock>
Received: by 10.213.57.140 with SMTP id c12mr648668ebh.3.1270792013117; Thu, 
	08 Apr 2010 22:46:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144405>

2010/4/8 Jonathan Nieder <jrnieder@gmail.com>:
> When lockdep finds a locking problem, it quietly prints a message to
> the kernel log and the kernel is able to keep going without worrying
> about it. =C2=A0Unfortunately, the repository access checker from nd/=
setup
> is not so graceful: it makes git die even though it should be able to
> carry on just fine. =C2=A0Example: with nd/setup, ls-remote currently=
 fails
> when run outside any repository. =C2=A0Probably the checker should be
> configured by an environment variable that indicates where to print
> its messages and whether to bail out when a problem is detected (for
> tests).

The intention was to let that patch stay on next/pu for very long time
(or ever), while the rest of fixes can be merged up to master. That's
why it was the last patch (now close to the last).

I did use an env variable to control whether it die() when unallowed
access is found in early versions. Perhaps I should resurrect that env
variable.

> A few of the earlier patches seem iffy, though they all start with a
> correct idea. =C2=A0For example, one of them changes the semantics of
> rev-parse --show-prefix without documenting it. =C2=A0So I have been =
looking

You meant "rev-parse --git-dir"?
--=20
Duy
