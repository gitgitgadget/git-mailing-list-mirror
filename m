From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Fri, 10 Dec 2010 20:26:40 +0100
Message-ID: <201012102026.42363.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com> <20101210190332.GA6210@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:27:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8cM-0001sg-KC
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab0LJT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:26:52 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41090 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0LJT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:26:51 -0500
Received: by fxm18 with SMTP id 18so4142376fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C5122GvwkQU1a0dpSRewHDR4QSrdW7cvYDVz50t2QFM=;
        b=BD0QRbmNnsC1SMqdQzHtCYupeZgsRJpWlGcM06IYUU8+U7AeXCTVo2dRLpKCvEiP7N
         2KVVttD5vSNem5AG+9fCVESqOeZaGw/MHR5QnTAfH8VWyhkEClxf/IKqGpj4FadRSeyG
         wiTRtP86Otfctm/l32J37dbgqGgu9H/apEETw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NcYhViubVsbn3Qi+3GdSK0TxxzqnQcxY7+vO/QC/oiP1+Q6ArFfOCdN0jmIeTDgYou
         rweTLTFIebJpB4YXeCBKzjZ8wbQJqcV2rJIH3j8zglYpb426+IkpieWkV3lWDPIkQCn7
         vPWof+d3Zm3Pamek0qqU+hMpXGPUTHj2ByFXY=
Received: by 10.223.103.65 with SMTP id j1mr1283111fao.88.1292009210487;
        Fri, 10 Dec 2010 11:26:50 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id w12sm1023950fah.18.2010.12.10.11.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:26:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101210190332.GA6210@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163432>

On Fri, 10 Dec 2010 20:03, Jonathan Nieder wrote:
> Nguyen Thai Ngoc Duy wrote:
> 
> > Can we use ! modifier for other ^{} too? What I have in mind is how to
> > say ^{commit} that has two parents. Or even better, "search from the
> > given tip for a commit that has two parents and the commit message
> > matches 'foo'". Hmm.. too complex. Perhaps "^{grep: <grep arguments>}"
> > that pulls the whole git-grep functionality in.
> 
> My thoughts, in no particular order:
> 
>  - '!' can be a pain in the neck to supply on the bash command line.
>    Single quotes and backslash quoting work while double quotes do
>    not, unless 'set +H' has been run.  But that's not a huge deal and
>    arguably it's a bash misfeature.
> 
>  - What is the intended use for this family of modifiers?  I sort
>    of understand ^{:i/... } for people that forget what case they
>    have used, but why the :nth and others?

* :nth(N) and :g, to show nth match and all matches, respectively; might
  be not necessary as it impinges a bit on --grep=<regexp> domain
* :N / :notesRef to search also through attached notes

If we was possible, perhaps also

* :b / :basechar to ignore accents and other marks (according to commit
  encoding).


-- 
Jakub Narebski
Poland
