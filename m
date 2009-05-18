From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 17:35:46 +0930
Message-ID: <93c3eada0905180105n641614eodb0469dceca20bc9@mail.gmail.com>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
	 <4A10FDC6.2040706@viscovery.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 18 10:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5xrA-0004F5-C2
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 10:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbZERIFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 04:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZERIFr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 04:05:47 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:34675 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZERIFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 04:05:46 -0400
Received: by qyk10 with SMTP id 10so1004971qyk.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ig0va4LPQ/dVhIer8ZEFpGSM9W+jymqdWvh6JaJL04A=;
        b=l2liMu/VXpU2hSTRvvrLKgQdEVegJRReYQW0rwhulofYoUtf94OxAHi4DE+hk/cfM2
         iCwdDs1jzqb9wd6QsyQYgVvvqs2OHHmbESOU2Fd2T+Fw7HT3ghT7c/lHxjFLtUroA9lS
         FMiOzK+5krlzKNdac+5CN05W3o/0Ln+n6Agpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=YOHfugDgH3vMBn+W/kVBWIfgTbPRIUcX6RozLiQKRqUIIbQYSr9mnKtMxdvNq03lKE
         4j/BQlqofQ8Fl4iZmx4lGR2K42aqk/+23rq0mCB9gdWR3Wq0Ybu0I74yTGndqxz9WmLR
         KWYIt4aLo3zByIVq/+zMV44d1ZRTxprR8p/QA=
Received: by 10.220.77.79 with SMTP id f15mr6365749vck.2.1242633946207; Mon, 
	18 May 2009 01:05:46 -0700 (PDT)
In-Reply-To: <4A10FDC6.2040706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119424>

On 5/18/09, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Geoff Russell schrieb:
>
> > How do I merge a branch X into my master and tell git that whenever there
>  > is a conflict, the file on X should prevail?  This is for a scripted
>  > application.
>
>
> I assume you talk about file-level (content) merges.

Yes.

>
>  There is no such tool, and the reason is that what you try to do here does
>  not make sense *in general*. It must be a very special kind of project
>  where you can blindly trust one side over the other if there are
>  conflicts, and that you can additionally trust non-conflicting content merges.

The file is data coming out of an interactive program which reads
the entire file, edits and then writes the entire file at which point
this file is correct
and all previous versions are obsolete.  I don't really want a merge
at all, but just
want to replace the file in the master with the version on the branch.

Thanks anyway.

Cheers,
Geoff.

>
>  The best you can do is perhaps to pipe conflicting files through
>
>     sed -e '/^<<<<<<</,/^=======/d' -e '/^>>>>>>>/d'
>
>  -- Hannes
>
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
