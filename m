From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Tue, 20 May 2014 17:45:59 -0700
Message-ID: <20140521004559.GB4927@hudson.localdomain>
References: <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
 <20140517085911.GA18862@hudson.localdomain>
 <20140517100013.GA18087@sigill.intra.peff.net>
 <20140517153943.GB31912@hudson.localdomain>
 <xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
 <20140520054621.GA28317@hudson.localdomain>
 <20140520062132.GA5222@sigill.intra.peff.net>
 <xmqqzjic1oc5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmufa-00062L-2r
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbaEUAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:46:06 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48161 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaEUAqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:46:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so823924pab.36
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4VADm0SSoYIT/lCD87ahpV3oYNDRvIDutkFBXSF0I9I=;
        b=jGRDKtDIXMRysJMuXm+xsb8YJ7uZFd4i9jl2KzOzz4uDXU+bp9oBQSj8N+uQZK5gdL
         BDm9EvCdFlO4LPfksemEsE/RMFizHu7HDTEqIEeDTUOBMK9jhHPYBrkMu5NBvgXJsa3N
         dWbgWS+fGJb07DwNTHBhzhffccfuDVV1REHFmw6+EDfhVt+xFAYbpKqBHgIP4QnhkEQ8
         1NEUuvQ1IgrMFpV44ZF0+nUzjreDFSCT6Fp8VDz2TjXejpun5BoBytfeSEimuYhprskN
         P/LEaVXESegGkaUfJBZZ97LGX004HpPlJD2pbiVbPXS9d0x8rqDFxPapTML7LD7+NQYo
         lSbA==
X-Received: by 10.66.251.233 with SMTP id zn9mr55187864pac.67.1400633163563;
        Tue, 20 May 2014 17:46:03 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id gz11sm5139158pbd.1.2014.05.20.17.46.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:46:02 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 20 May 2014 17:45:59 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqzjic1oc5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249766>

On Tue, May 20, 2014 at 08:06:50AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > You could do:
> >
> >   #define DEFAULT_SIGNATURE git_version_string
> >   static const char *signature = DEFAULT_SIGNATURE;
> >
> >   ...
> >
> >   if (signature == DEFAULT_SIGNATURE)
> >      ...
> >
> > but maybe that is getting a little unwieldy, considering the scope of
> > the original problem.
> 
> I agree.  It is an invitation for doing something like
> 
> 	#define DEFAULT_SIGNATURE "-- \nfoo bar\n"
> 
> which defeats the purpose.
> 
> I have an unrelated and larger design level suggestion, but it may
> be better for me to refrain from sending it during the -rc freeze.

I will take DEFAULT_SIGNATURE out of the next patch revision.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
