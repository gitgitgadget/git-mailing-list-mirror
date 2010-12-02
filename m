From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Git.pm: discourage casual use
Date: Thu, 2 Dec 2010 13:45:36 -0600
Message-ID: <20101202194536.GB4806@burratino>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
 <20101202181425.GG3962@burratino>
 <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
 <20101202190546.GI3962@burratino>
 <7veia0q8fx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:46:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POF6p-0005Du-O9
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080Ab0LBTpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:45:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46068 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758078Ab0LBTpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:45:50 -0500
Received: by wwa36 with SMTP id 36so9121117wwa.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S09krVx+cz/9sduvrheK1+njN/m0U17axo3Ecdd0gpY=;
        b=BbSgySA4NVTCESCMRMcw6rA05ceZs6rtQN8TFkKqKyqow6XbMtmk1f8FLJdLBtG5tE
         1kdC3aDOvXKsj3j3apdNnzy1mjUzqHcGSOiybJJrddBHC22kc1nI5X9n9dW8VYLG+OKi
         ofGTEtAA6j+JIl9L7HlX4vMtNquLpz2TjBMuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EtcvclcnAJF+EptE/hLF5mo751zBUorrZ8yay0+wkLzP/1LKIqt21BJXt8mgisCtmt
         E83vhqXlRvPNmfQ8o4R3KDsAr7orvPcVRV5O4CUn2tQyhluHMjxb+jUlUSdnHnTwu53+
         zeJWpRM0PehUjjyoqkQmaHGxXJFkvA6+Fbxug=
Received: by 10.227.128.131 with SMTP id k3mr761233wbs.66.1291319148767;
        Thu, 02 Dec 2010 11:45:48 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id j58sm467415wes.21.2010.12.02.11.45.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 11:45:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7veia0q8fx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162742>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> So how about something like this patch, to start?
>
> Ok.  We may probably want to reduce the repetition of "easy", though.

Yes.
---
diff --git a/perl/Git.pm b/perl/Git.pm
index 69e92aa..4700dd7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -65,12 +65,12 @@ require Exporter;
 
 This module provides an easy way to interact with the Git version control
 system for Git's internal perl scripts.
-The modules have an easy and well-tested way to call arbitrary Git
-commands; in the future, the interface will also provide specialized methods
-for doing easily operations which are not totally trivial to do over
+The modules include a robust way to call arbitrary Git commands;
+in the future, the interface will also provide specialized methods
+to simplify operations which are not totally trivial to do over
 the generic command interface.
 
-Note: this module should not be used by code outside the Git package itself,
+The module should not be used by code outside the Git package itself,
 since the API is not stable yet.
 
 While some commands can be executed outside of any context (e.g. 'version'
