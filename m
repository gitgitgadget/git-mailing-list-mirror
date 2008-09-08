From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 15:04:54 +0200
Message-ID: <48C522F6.7090308@gnu.org>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcgRW-00055a-8t
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 15:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYIHNFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 09:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbYIHNFA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 09:05:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:55438 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbYIHNE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 09:04:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1475283fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=MTaLCDCgzQxmpLSibp9M39xRDSztR/INGHmA4v9jDFI=;
        b=Q8LW1BkwBpw86QDOJjQDaJXIP+TXQdzVuOUasBNrW3q7cpPYm4kIRWQUlEAijZ1VR9
         zvYssixj8JBMPpVCSoROAahsMoZXvegt+sUkIkc/GZmXikYTBy4mvr1+gfFdK3DC3GPz
         Rf00cMLCG6vqHS7bitM8I3fh43jA3ByUlqLXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=XgHSi6fd2/7E90Npkv+QKyjCqMEy16XZjS4L8R92o0L3O3wv/gp1wOWqzjnL5sMNeV
         /huY5jHDk2Mx0VZiL9ggX7j7sWxcdRfeyW4AvPsi2GcdKjVlijdqx2A9gVUbCaK6Cj56
         1mWs9aRZrQzv1L1868n70wVJVHC5QqVaQwHJs=
Received: by 10.86.54.3 with SMTP id c3mr3648496fga.70.1220879096713;
        Mon, 08 Sep 2008 06:04:56 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id l12sm5164408fgb.6.2008.09.08.06.04.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 06:04:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080908115129.GA19031@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95246>


> commit 7df437e56b5a2c5ec7140dd097b517563db4972c
> tree a006f20b481d811ccb4846534ef6394be5bc78a8
> parent ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
> parent bbb896d8e10f736bfda8f587c0009c358c9a8599
> cousin 6ffaecc7d8b2c3c188a2efa5977a6e6605d878d9
> cousin a1184d85e8752658f02746982822f43f32316803
> author Junio C Hamano <gitster@pobox.com> 1220153499 -0700
> committer Junio C Hamano <gitster@pobox.com> 1220153499 -0700

What about "origin", and making it propagated through cherry-picks?  In
other words, if I "cherry-pick -x" A generating B, and do the same on B
generating C, C should have A as origin.  Also, "git cherry-pick -n -x"
should add the commit to a list of origins somewhere so that "git
commit" can reuse it.

Furthermore, "git cherry" should use origins if available.

Paolo
