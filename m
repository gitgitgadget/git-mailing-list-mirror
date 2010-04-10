From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 23:21:58 +0200
Message-ID: <201004102321.59263.jnareb@gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com> <m3k4sfgmjc.fsf@localhost.localdomain> <20100410194154.GB28768@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Simon <turner25@gmail.com>, Eric Raymond <esr@snark.thyrsus.com>,
	git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 10 23:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0i8P-0001dz-DA
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 23:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab0DJVWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 17:22:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47727 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0DJVWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 17:22:10 -0400
Received: by fg-out-1718.google.com with SMTP id 22so35815fge.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f1B6vsb7E0dh1maI5GNHt/19H+0TVTSP7AaWzF1bKs4=;
        b=xcvHMUqmk5Sz9KkJ+hmff3QeqvMQ7BKT6Kstvq5AMh79kREWLE1efHLX1rs+SLLw4Y
         i/JlHeGpVFBYf4NdC8wHQkjnWL2S5YB01vZLGU4MQg6VTfE/ZcEYKJsKN4U3s8UbCV4+
         ZrqwhbEnLtq4DnwycZAoxxXv5S9MeK52t4Dck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BiQ9lGOOfNH4KiaqOmvNfKS9KaX7zEv3K0RUSL0ZYOePY5eY04WyCjCSyuJelRb59d
         ZpBSFCDmgf/Gl8FNl3fdgWITR36xE2xZh61ppj5Tq4d4sSSSks9T6dTS7laFzXTRZOlC
         m34DE4v3lujdtJfV41rNNpGm1+GZ+eerQ4oIA=
Received: by 10.103.7.30 with SMTP id k30mr938513mui.24.1270934528029;
        Sat, 10 Apr 2010 14:22:08 -0700 (PDT)
Received: from [192.168.1.13] (abvp94.neoplus.adsl.tpnet.pl [83.8.213.94])
        by mx.google.com with ESMTPS id w5sm10883522mue.54.2010.04.10.14.22.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 14:22:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100410194154.GB28768@thyrsus.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144595>

On Sat, 10 Apr 2010, Eric Raymond wrote:
> Jakub Narebski <jnareb@gmail.com>:
>  
> > I could understand providing JSON format, specified using --json
> > option.
> 
> You know, that's actually an interesting idea.  I mentioned it
> previously as the not-XML if we want to build on a metaprotocol;
> I wasn't considering it seriously then.  But I am now, and it is
> not without attractions.  JSON would certainly solve all the delimiter
> and empty-object edge cases, and it has excellent extensibility.

It is a bit chatty, but is to some extent self documenting.

The question is whether it should output well formed array of objects,
or just list of objects not wrapped in array...

> >    I think there is some GPLv2 compatibile JSON generating code
> > in C (MIT licensed code is GPLv2 compatibilie, isn't it?); we can
> > always borrow compact JSON generation code from GPSD project (if
> > license allows it) from ESR.
> 
> My license would allow it, but there's not really a lot of win in 
> trying to reuse JSON generator code - writing your own printfs for
> it by hand is easy and fast.

What I am worrying about is correct handling of escaping, quoting,
and non-ASCII characters in strings (the JSON-quoting and JSON-escapes
are different than C escape codes, IIRC).  JSON rules are simple,
but are different than C.

-- 
Jakub Narebski
Poland
