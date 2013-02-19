From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is this a bug?
Date: Tue, 19 Feb 2013 10:42:59 +0100
Message-ID: <51234923.7090807@op5.se>
References: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Wade <DAWAD@statoil.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:43:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jjb-0001Cg-7v
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab3BSJnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:43:08 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:46890 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab3BSJnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:43:06 -0500
Received: by mail-la0-f48.google.com with SMTP id fq13so6201136lab.7
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=3R6UKvVjWGUJUAmMELVHEgfseH2J0gryJZ0uuStseBI=;
        b=Z1szvNvv16OFdv7V9JpPa1+ekPrV0VPkVBclJlgH+KzoGe0+mQIrDYuII0ypjbDrAY
         GHaEKmOMqY8LURZf5JbOuJArpdDk5fEGUhfxuCXniFXwNef9THPn6wySy6WHLvTYu+7p
         yPCVvtstbCzWEL6xxOb50mGRtEANYSXXbKVZ26zsvGBnsDBXlh+yPSRwtkHUkx9FrBRB
         6ZHarMWggqLhIfKuHm1N2w0+jyC9unPeBqjAfT5fJa3ouY+r1Gc7MYh420+2XLnYAgPu
         6IfF5tq/5v0tSPaZADAgireC+7PAZOYFwegepif4niM9LcPIDEuOy207FoPGw9I9ccL1
         n9ig==
X-Received: by 10.112.38.98 with SMTP id f2mr6886643lbk.61.1361266982442;
        Tue, 19 Feb 2013 01:43:02 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id mq7sm19188927lab.1.2013.02.19.01.43.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 01:43:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
X-Gm-Message-State: ALoCoQnO1oQcbYsB4BXlshTS5WJSzCSs1bcUgumEO+C8uKT5VMtVNUyCJt1n3o1kRk2ivOFTh0dX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216585>

On 02/19/2013 10:32 AM, David Wade wrote:
> Hi,
> 
> I wrote a commit message beginning with a hash (#) character, like
> this: 'git commit -m "#ifdef ...." '
> 
> Everything went okay when committing, but then I tried 'git commit
> -amend' and without editing the commit message I was told I had an
> empty commit message.
> 
> Is this a problem with my text editor (vim 7.2) or git itself? (git
> version 1.7.2.2 under RedHat 5.8) Or something I'm not supposed to do
> ;-) ?
> 

Lines starting with a hash sign are considered comments by git commit.
If you fire it up without '-m' you'll see that git puts all its own
notes about the commit in commented-out lines.

While empty commit messages aren't really unacceptable by git's model,
they're considered "almost certainly user errors". I expect the -m
flag being present when running 'git commit' causes the check for empty
message to be skipped, which isn't the case when amending the commit.


Btw, when I write messages probably similar to the one you just did, I
tend to write:
  Use compat-layer __builtin_clz() #ifndef __GNUC__
precisely to avoid this issue. It also puts the imperative first,
which I find makes for smoother reading. Putting the condition first
screams for a comma and a slight stagger in reading flow, like so:
  Unless built with gcc, use compat-layer __builtin_clz()

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
