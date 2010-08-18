From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Wed, 18 Aug 2010 05:44:32 -0500
Message-ID: <20100818104432.GF6263@burratino>
References: <20100817065147.GA18293@burratino>
 <20100817065459.GC22057@burratino>
 <AANLkTi=1Fz_wdf-grxFB17zUXpW+d26MudbbJP5K=fO_@mail.gmail.com>
 <20100818022931.GA19868@burratino>
 <AANLkTikBmYH1xC_7iiXQK8-vo0yavwX_ELR=z1kfVSLj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 12:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlgA0-0003Qt-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 12:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab0HRKqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 06:46:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58432 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0HRKqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 06:46:10 -0400
Received: by iwn7 with SMTP id 7so539263iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WHkbn7Y0aN9H72p/FC2OzIxb+7u3kxnT49DN7xlrnSs=;
        b=bnWDFiM1IsnR7cQKMw1NngSz5UDFdbGXGazVltJuKhF/MnL/hV79JxXQN7khDBINXm
         iQNqcIo9CFHNO6pc+RwRc9t0M989vAvxqVU2rjXtf6WSvjrKcDAe0RG4yaz9j30Jks4Q
         Q3TjRrSyKPTm1K+D5krV5KMFjXvUPrfeuTVwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BwxBVwtJSRn+oXfTCEhw3vc3cLiBXnktqiAEiygF4Oyq1FGYtv8XQ3ehGF6oTK0lRO
         JxFd+YUwT15MsSqBMDdWtX3Oi7BK5IRG31S3fmXKf/2fDjdS8z0hs3DA8GNRC7UL24X+
         cXkxyjPXAQuYB9yzJxQeH5iqwLBRPco10NkIE=
Received: by 10.231.30.130 with SMTP id u2mr8865210ibc.111.1282128369165;
        Wed, 18 Aug 2010 03:46:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm123774ibb.8.2010.08.18.03.46.08
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 03:46:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikBmYH1xC_7iiXQK8-vo0yavwX_ELR=z1kfVSLj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153829>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The main issue here is that --debug means two things. It runs
> test_debug() code AND instructs the test-lib not to remove the trash
> directory when it's done.

Most of the time I use --immediate, insert an explicit "exit", or hit
^C instead of waiting for the test to complete anyway.  --debug always
struck me as a theoretically useful thing (more useful output!) though
I never used it much.

> If we had a separate --keep-trash option most of this problem would g=
o
> away, no?

That might be useful for e.g. automatically re-running tests with
expected failures or unexpected successes and tarring up the test
repo.

> Aside from that it's better to use git log rather than gitk in
> test_debug, since it's in text form it can be easily sent along with =
a
> failing test, which is not the case for dozens of gitk invocations.

Right, the effect of this patch is good though I agree with Sverre
that its method is ugly.

Maybe unconditionally printing a log between tests would be good
behavior for --debug after all.  Not sure.
