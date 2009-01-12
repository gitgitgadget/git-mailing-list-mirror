From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 10:57:42 +0100
Message-ID: <46d6db660901120157g49aa8f8eo957cf4a0f5d279f0@mail.gmail.com>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
	 <20090112095250.GB3079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJZd-00057V-3G
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbZALJ5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZALJ5q
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:57:46 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:5002 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZALJ5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:57:45 -0500
Received: by mu-out-0910.google.com with SMTP id g7so4214314muf.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GQflX+gUVWHddFyr4OmLgzQO/uxpj809hZpIcrpISn8=;
        b=N/7hyQQ2b9RBFjk5dWzOkdo/Y8NcgaIHggSqIwGUsYi6m8udi1sydAJeIxnqfUce6i
         bbn/xR4ujtk35csEzLpUFIWW921NbNumydEC7/r2pE/KYafRmgy9HumTkbXCVhY/ZzMw
         83WRR389Tjfk7bEdU3jiZFS87uT35wDUK6EPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rT1Q1uu1nGxdc5GcsW9iyH5LGgfjuhDMSEwpRJe0XestfMfXSZjSn4eYov0IcC7nMA
         2LIZ5AW5DcJsJFB6dWXO5dUbb3z8j/6Uo69Y3OCSZQX6H2B0ajgBBVfbSo1iv1x0YW4R
         VEpagR/oLtsd82GSlNZUaks9wk75YpwSbm8yg=
Received: by 10.103.243.9 with SMTP id v9mr10303035mur.5.1231754263347;
        Mon, 12 Jan 2009 01:57:43 -0800 (PST)
Received: by 10.103.118.7 with HTTP; Mon, 12 Jan 2009 01:57:42 -0800 (PST)
In-Reply-To: <20090112095250.GB3079@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105321>

On Mon, Jan 12, 2009 at 10:52 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 12, 2009 at 10:00:11AM +0100, Christian MICHON wrote:
>
>> The current solution I have is to use the original patch command,
>> stage modifications and add new files. I do not like this solution,
>> because I have to work out the commit messages out of the mbox and I
>> lose reproducibility. I'm basically maintaining a subset of shell
>> scripts, the original patches and an artificial way (ugly) to get
>> timestamps of modifications (for the commit dates).
>>
>> Instead of this complicated procedure, I'd like to use "git apply" or
>> "git am", provided I can get git to support "context output format" as
>> input for patches ?
>
> Maybe this is not the nicest solution if you are going to apply a lot of
> these patches, but you can pick up where git-am fails, run patch, and
> ask it to resume:
>
>  $ git am mbox-with-context-diff
>  Applying: a minor change
>  error: No changes
>  Patch failed at 0001.
>  When you have resolved this problem run "git am --resolved".
>  If you would prefer to skip this patch, instead run "git am --skip".
>  To restore the original branch and stop patching run "git am --abort".
>
>  $ patch <.git/rebase-apply/patch ;# or whatever
>  $ git add -u
>  $ git am -r
>  Applying: a minor change
>
> -Peff
>

vim patches are in hundredth... so I guess this is too manual.
Thanks for the suggestion!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
