From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC - "git editlog" feature for fixing up local commit messages
Date: Tue, 30 Mar 2010 18:11:14 -0500
Message-ID: <20100330231114.GA11591@progeny.tock>
References: <20100329133132.GA12201@thyrsus.com>
 <32541b131003291314r2f5a77e8g28e79b5983821e41@mail.gmail.com>
 <4BB1BBDA.2050102@drmicha.warpmail.net>
 <32541b131003301136h4454f02cyd5a94d746e844a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, esr@thyrsus.com,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwkbq-0001JI-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab0C3XLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 19:11:04 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42186 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165Ab0C3XLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:11:00 -0400
Received: by ywh2 with SMTP id 2so5989244ywh.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zHd1eoQumKgf6EfXKTg8WrEiDqEnbpd780RirRcW1Gg=;
        b=Zvoh40npvhMbQkOR+EGvLQVvikOfCV/c7URJ5SA4gUK2n54qXLgiBhDoD+bdU8O/BM
         FsVOlG7TRqsXVFLvAX3qJ79MnwtBXgvSb1BKkuvfjALc5b0mY85F8OmlwC9Ogg+cNIu4
         Bn2mDcsCtf+pljlzOXUFAufAoPb/4fe1JoMX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QImbc3Slk7XFcHN36MyMCYfqz9obdITxVKqIqjcoGokE6wUIFclw7PNhKs/FhBZ38D
         rjkMULFLjoCbLH5cdSdxLKu3MjXTGKmWfVKG8yUxMKbAE5dznJW7wn8X/4JYvnkL4sdX
         IBKBQl2cA6+keUkDqjjx2ZwK2eLS+hn6GxJ2g=
Received: by 10.150.176.9 with SMTP id y9mr6871207ybe.242.1269990659019;
        Tue, 30 Mar 2010 16:10:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5436833iwn.15.2010.03.30.16.10.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 16:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b131003301136h4454f02cyd5a94d746e844a8d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143621>

Avery Pennarun wrote:
> On Tue, Mar 30, 2010 at 4:52 AM, Michael J Gruber

>> I think the OP's point was that filter-branch is better at keeping
>> merges in place; I'm not sure if this is true when rebase-i is used =
with
>> reword only.
>
> I've never actually tried the "--preserve-merges" option to git rebas=
e
> -i, but the description sounds as if it's supposed to not have this
> problem.  Can anyone confirm/deny?

preserve-merges is in bad shape.  I=E2=80=99d recommend not using it un=
less you=E2=80=99re
willing to hack on it.

Example issues: interacts poorly with merge.log, reordering commits
produces very confusing results.

Example of why it is not necessarily the tool for all seasons: requires=
 a
diff+apply cycle.  If you are tracking large or binary files or amendin=
g a
very old commit message, it makes more sense to avoid this overhead.  S=
ee
http://thread.gmane.org/gmane.comp.version-control.git/143426
for example.

Hope that helps,
Jonathan
