From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 6 Feb 2009 23:10:23 +0100
Message-ID: <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVZ0p-00005b-Re
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZBFWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZBFWQA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:16:00 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39286 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZBFWP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:15:59 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2009 17:15:58 EST
Received: by bwz5 with SMTP id 5so146344bwz.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=O8QWfj09GqMiJTzA/OoS83FpAbqAq/Lmk88DgaH8yYc=;
        b=gMiNDKxsDNCyqjAAgF9KNDhq6NVviZgrLD5yG/HRmaDfruPUhmloxzHJnuL7sS9OGu
         wAwVMsztFbHHFYmPAiJA9DVKATYpAoBT98ptHBnYbHlJXVbJI0hJNGnkidb6ZYcDOijG
         8DICS418kjeD3Q2Ph5CIbYoDZkbLqQUus+/8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WMaKFZ7pRCOdpWmR9s3RiuJ/nYPOxi79+KVjn3itZuLcR9WPyfGBLMp1V8XxTGdJPl
         IEAlmP7HFAZ8OK0HjBiOqoPNhNDjYayC4tKeIeKVQ8Db2SKn5AgHBKFoP9KNFNHgDbiu
         rEHoTjFu8e9WK6eRf8tKko3Zk86TQl94PMfJc=
Received: by 10.181.219.15 with SMTP id w15mr738101bkq.90.1233958223358; Fri, 
	06 Feb 2009 14:10:23 -0800 (PST)
In-Reply-To: <20090206191511.GD19494@coredump.intra.peff.net>
X-Google-Sender-Auth: b25dd0e3ceca8048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108795>

On Fri, Feb 6, 2009 at 20:15, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 05, 2009 at 09:44:36PM +0100, Jonas Fonseca wrote:
>
>>  - Blame view: load blame for parent commit. For merge commits the parent
>>    is queried. Bound to ',' by default via the existing "parent" action.
>
> Thanks for this, btw. I've already used it at least half a dozen times
> in the past week or so.

Good to hear. I remember you posted a patch for this after 0.11 was
released last April.

> It looks like you just keep the view on the same line number when moving
> to the new blame output. In practice, this has very mixed results. Most
> of the time it does exactly what I want, but if the file changes
> significantly, you get dumped at a totally unrelated part of the file.
> I'm not sure if there is a more clever solution, though.

Yes, it is a bit easy to get lost. It should be possible to find the
original line number either by making git-blame also honor
--show-number for the --incremental output or by using the "porcelain"
version:

  git blame --show-number -L <line>,<line> <rev> <file>

-- 
Jonas Fonseca
