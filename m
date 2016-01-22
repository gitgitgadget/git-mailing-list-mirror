From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] resolve_gitlink_ref: ignore non-repository paths
Date: Fri, 22 Jan 2016 14:36:54 -0800
Message-ID: <CAGZ79kYU_=w0VWFRNGamP_nnnjyF6AcOj+A8r8GfhyrJMQzi9w@mail.gmail.com>
References: <20160122222650.GA14772@sigill.intra.peff.net>
	<20160122222930.GB15560@sigill.intra.peff.net>
	<20160122223154.GA15635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:37:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkKC-0004Dc-0w
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbcAVWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:36:57 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:36723 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbcAVWgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:36:55 -0500
Received: by mail-io0-f169.google.com with SMTP id g73so104889674ioe.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zYy9v43fzmX6D4TqYNehcO3tKUVEpC6te7SoEue7dfs=;
        b=HIVY31a+5zjLa2Y9Uk+BHpzeZTSa0uvDLlneMpJtqGBE5XCA5uupjcGiIF63V/hwhA
         YavaVrk2wCtJ3M1uvPAjC5fBzsritl8vCdB8fI5yCLrxWKcLQ/qc4YVeLCzknVYVMbHR
         Nd2cyDo/1Wq5wltNZEwsRXHY0vF2j3EsZ0IEmRdO6AD12gbvKiPGiDptqw9x75BqmHkw
         irSu0RcHbr2qP25K9lvy9RKVcMJgcfMrgpyxywW1oTnDmJHeQjyojDg2j++OD35b78LM
         dSX73uVcr6sXXiDFoIDsExjCFZuQXHdlFe7LXcNk5L6oIs49FdcGfpbd3eiaqqB8/p/U
         Cb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zYy9v43fzmX6D4TqYNehcO3tKUVEpC6te7SoEue7dfs=;
        b=fZv1mIByhzllvvtlM+xlDnKys7EaYPZj8GmmcI+ch7mHB68VCqM0aab7IFVwtB1kTU
         y3tIEAdrxwiJK+8L7zVIsvuOPS8GQ1CrC6DrDkYNX8WvPsSz9N9ySOcXK+xmQSvHVUl0
         1DLXFu4fSqIH1pjbEQ3BnmHKJUuIssu13Kf3YWWWeS58oqAD89OdY86BCCKxR9HTa7v5
         crdaXfBtDUuw9Fx1KILrpmArroYXTZBFYKXy3wAtCx5NEkpBET4hEfxN/2+6fMPXj/mD
         Xbl1XgesdR/4ju8kdeOt3mv+ofz7AkA7ksLs0zM5QBzPLKP+76PTEbpRacUGhlRPNr9t
         iJDQ==
X-Gm-Message-State: AG10YOTG2n/GLrMJGErjDHZnE3vLPndHDTsYDhVc+RhLpUHU8ZE46EhPZTT9/kY2h5/GbAiELcyI0DInv1YZNM+9
X-Received: by 10.107.137.68 with SMTP id l65mr6909540iod.110.1453502214877;
 Fri, 22 Jan 2016 14:36:54 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 22 Jan 2016 14:36:54 -0800 (PST)
In-Reply-To: <20160122223154.GA15635@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284601>

Impressive performance improvements. :)

On Fri, Jan 22, 2016 at 2:31 PM, Jeff King <peff@peff.net> wrote:


> BTW, what if you have
> precious content in a ".git" file?

I'd kindly ask to use a different version control in that case.

Q: What can you use Git for?
A: Everything including version control, backup, deploying software,
    except when there is a file named .git with precious content.

;)
