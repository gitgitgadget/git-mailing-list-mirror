From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Is there have development library or API for git ?
Date: Tue, 26 Aug 2008 11:48:53 -0700
Message-ID: <d411cc4a0808261148g792c01ax325aff343e7c3333@mail.gmail.com>
References: <976e6d070808242025n24b282dei5c79b4c9bf2e390e@mail.gmail.com>
	 <976e6d070808242109s53af2624td45dbb936ca25896@mail.gmail.com>
	 <20080825041217.GA19127@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sky Patrick" <patricksky852@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3cB-0006AL-QS
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbYHZSs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757902AbYHZSs5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:48:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:58346 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692AbYHZSs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:48:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so164155ywe.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OoQYLqjGXXJ3WuQ9GhZIl/1OXO36w/KmvJ2vcdV2dvk=;
        b=EeNsW/zSjH0H3IyTny5chcSDt7SslyH5T4Hcs7bsKpTHZYlxHNgV9h7zAarjzbLB/t
         RYCk5/i54LfhW8zehQdaAxhRIv2ze/m+3Z+4o+6COIoituVv55Z9yhZr+MgJ4yTQPJOW
         R5yaavXppizAyaB0AB4lvrENNN/GsRgP7Ijes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oLs9jYsJi/mc/f2MVYX9h0juROLHKtG/nc6gyycdpSHi2URa+636kGOXmz1qrTHepS
         nN2Fbt0IYLaxClAdSLjKmPteqhsJxb7/F3esYNE4Mdy/enXqUED0aLeu3uyQWsPTPX3V
         L9BLKtXB5/7zwHKRmOhjBx1nHoC4K0iufWfKw=
Received: by 10.114.200.2 with SMTP id x2mr5101757waf.79.1219776533798;
        Tue, 26 Aug 2008 11:48:53 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 26 Aug 2008 11:48:53 -0700 (PDT)
In-Reply-To: <20080825041217.GA19127@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93797>

The Ruby library Grit actually does a lot of stuff in pure ruby rather
than forking, but you also might want to take a look at libgitcore:

http://git.codethink.co.uk/?p=git;a=shortlog;h=libgitcore

The codethink guys have stripped and rewritten a bunch of git to
behave more like a linkable library, and I think they have a python
binding as an example.

Scott

On Sun, Aug 24, 2008 at 9:12 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Sky Patrick <patricksky852@gmail.com> wrote:
>> Is there have development library or API for git ? Thank ~
>
> No.  However you can look at jgit if you are programming in Java.
> In Ruby look up Grit (a wrapper around the plumbing commands), or
> the pure-Ruby implementation of Git (I forget its name).
>
> Anything else, use the plumbing commands and just fork+exec what
> you need.  Many of them have a -z flag to use null termination
> on records, making it easier (and safer) to slurp data that may
> contain LFs.
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
