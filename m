From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/8] trace: factor out "do we want to trace" logic
Date: Thu, 24 Feb 2011 16:07:44 +0100
Message-ID: <AANLkTinUa8kg9mZaqV2ZAz9fc==FSA+ja-5W3ydqqYOL@mail.gmail.com>
References: <20110224142308.GA15356@sigill.intra.peff.net>
	<20110224142859.GE15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscnH-00067Y-DB
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab1BXPHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 10:07:46 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40000 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1BXPHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 10:07:45 -0500
Received: by wyg36 with SMTP id 36so607529wyg.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Fr49JoXfcmH1KkWf3FQuFq9bFtN8Ae6wpSe+ZSX7Fqs=;
        b=p4xMLxxENt4KbLbcQ51TqRsGe0HDzMPoCiUQoKPD/bYUQFgnGVRs4fE4FB/lwb/gUh
         PfTyrZ9u/7L0NmVcnK4GyCCTdYwymBQ4cyuMti71CJTpyNW083IfUOK8eI87KAjMAdF4
         gBVdGiWZjcrx+x6kZda72ClONp6BrHf3Msl5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iazIIdZS2950qKCe+u3nkwLnFzUWPgjkNPu2qfe7cecR5LFeHLf6Wu8ZAHYDMoq+rJ
         okTozdWXQj0vRWEpEH70nNt1NWLxmL0hVF/Al9dUrozl8+04X7s3294dQ6u8WDwwzhw8
         +mGGKKE9av9qd/UQajMDSiYQwHYwo1z8Ji2WA=
Received: by 10.216.166.68 with SMTP id f46mr5918290wel.26.1298560064510; Thu,
 24 Feb 2011 07:07:44 -0800 (PST)
Received: by 10.216.241.78 with HTTP; Thu, 24 Feb 2011 07:07:44 -0800 (PST)
In-Reply-To: <20110224142859.GE15477@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167822>

On Thu, Feb 24, 2011 at 3:28 PM, Jeff King <peff@peff.net> wrote:

> +int trace_want(const char *key)
> +{
> + =A0 =A0 =A0 const char *trace =3D getenv(key);
> +
> + =A0 =A0 =A0 if (!trace || !strcmp(trace, "") ||
> + =A0 =A0 =A0 =A0 =A0 !strcmp(trace, "0") || !strcasecmp(trace, "fals=
e"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return 1;
> +}

Other minor nit: calling it "trace_wanted()" or "want_trace()" looks
better to me.

Thanks,
Christian.
