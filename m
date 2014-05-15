From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 12/44] refs.c: ref_transaction_delete to check for
 error and return status
Date: Thu, 15 May 2014 15:01:39 -0700
Message-ID: <CAL=YDWn8uFOAfyySRcdnVjS4KSifp2QS4vM6GOX_UAx4yz7VXA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-13-git-send-email-sahlberg@google.com>
	<20140515195152.GJ26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:01:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3ii-0004wv-JX
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaEOWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:01:41 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:40604 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaEOWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:01:40 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu19so5214411vcb.34
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AENZAaEIXGpH+7bgnsUHLXRToO/WKBV0wgR8rD3Ld8w=;
        b=TOISoemlv9TzRLTMcq110+6IAF4SxkpTOv4tOKqWQbIOBJo9gR9VnZ8a5kH8NwzVKm
         tCnuH9y+tkjsh72Xi4hGitvTNndAt/f61noyAa9coJDGshkuMFk10zdKs8vJjyqRhfyB
         OrPvkfqbhlPOOOmS4dSrznc5vZjAGThywXTIvO6mdtBi6aSUUYIxKFQlCfbTyvVVvEup
         LNqclaaMghZpesLruUrLpTPnIZmkRmJfKUrY972qf5/a1OQfuf15rlc9glv/hLke6YDD
         PjDPghwtBL+FNGDnBuZEGPKx5/2BBRKICfxmUh+h/WqBxDKpcXDKgD1J6BAuqXZCTgXo
         oirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AENZAaEIXGpH+7bgnsUHLXRToO/WKBV0wgR8rD3Ld8w=;
        b=Nxrzdba3mKzCD+O0NJkxJs8OTZ8PbRKOFvnNBBSkSnxyMRwyjGmesykH4PQ71WKYvI
         7U+smJavoKm/0vpQZVbjmKcuBAQvd9uPrbqw0SEZF2HhfmtMYHdmj/R6orLQksj1A3ap
         nThCbfRbR04fBNfSa15gRJMvr9Foj1kuTKL+UXGCVQn9VziBtjiugVjF7/W4sHIluhcp
         8sLnofEHYD2StaKJ7thZ40KBTCLwCexehaGRHTJyCQVHZrwfXl5dhoDdqDE3ELbWAvQI
         JPRfA+GenEx8ceWSUPtlv99R+MzMU+ROEFTeeSa4fyb1Kdo7MM+BVVfh8NwCKuYrBqZo
         7iaQ==
X-Gm-Message-State: ALoCoQnm66Zp2p1BOKGpPhLjVKo1z7aExlAfL9G8hTHzpmJGA2CBu3grdrLznQH/R/1VEfeMCGSR
X-Received: by 10.52.243.201 with SMTP id xa9mr8732028vdc.1.1400191299536;
 Thu, 15 May 2014 15:01:39 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:01:39 -0700 (PDT)
In-Reply-To: <20140515195152.GJ26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249207>

On Thu, May 15, 2014 at 12:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change ref_transaction_delete() to do basic error checking and return
>> non-zero of error.
>
> Likewise: a 'struct strbuf *err' would make nicer error messages
> possible.

Done.
