From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config
 but not .gitmodules
Date: Thu, 12 Dec 2013 11:23:01 -0800
Message-ID: <20131212192301.GQ2311@google.com>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
 <20131209223506.GF9606@sandbox-ub>
 <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
 <52A8E689.80701@web.de>
 <20131211224424.GB25409@odin.tremily.us>
 <7vtxeeuaw7.fsf@alter.siamese.dyndns.org>
 <52AA072F.2000105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBqq-0006Ey-SW
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab3LLTXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:23:09 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:59294 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3LLTXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 14:23:07 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so698039yha.26
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=V3OPS1swR2UeMMlO2iu3LAi7VcATwQ2yCcXhub+K+F8=;
        b=IG3tL7hraNCXyR13lMBd+DbrtgwonF3ygci7aNQFXAjFZ8uDo4/lpfTczWRkdUnMmQ
         WBgyb1Xe1Yyr0fDKEiowMJMoglceKJPHvQmEQfdIayYt33BeRavra6tU6qOObrV2zNDN
         ztMZWwfDZW2fVXPHya/4DAFXgc4i/8drPQ/q8rZ1VTtUilDnp6OHWi9HjO19BGDnNuZc
         ksW2rVknMtaCTEOWFjerz/Huv+oWIo4K014dX/sB9eJvjrgR7C5lpd39uu/2F8IrQMIQ
         nBrGSGPvr/OzqNDaD9GlWfLc2Yx8AWTeOywGRdfCrLCP2cupAMnINR7Ai29+Ln7j/aYm
         RghQ==
X-Received: by 10.236.159.8 with SMTP id r8mr7464446yhk.63.1386876185235;
        Thu, 12 Dec 2013 11:23:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm35656362yhb.7.2013.12.12.11.23.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Dec 2013 11:23:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52AA072F.2000105@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239239>

Jens Lehmann wrote:
> Am 12.12.2013 02:16, schrieb Junio C Hamano:

>> I think the solution we want is to copy only minimum to the config
>> (and that "minimum" may turn out to be "nothing"), and to default
>> keys that are only absolutely safe to .gitmodules file.
>
> I agree and will prepare a patch for that.
>
> What about teaching "git submodule sync" the "--url", "--update",
> "--fetch", "--ignore", "--branch" and "--all" options to allow the
> user to copy the current settings he wants from .gitmodules to
> .git/config (but only safe values of course)?

Why would I want to copy settings to .git/config when they are safe
enough to already be used directly from .gitmodules and the value from
.gitmodules is the one chosen to make sense when working with the
current revision?

URLs are kind of special because generally the newest value is the
most meaningful one, even when looking back over old history.

Thanks,
Jonathan
