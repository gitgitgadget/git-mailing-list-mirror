From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/1] fixup! Documentation: start to explain what git
 replace is for
Date: Fri, 14 Jan 2011 13:30:23 -0600
Message-ID: <20110114193023.GA14294@burratino>
References: <746745466.20110111134101@mail.ru>
 <m3lj2rbmq5.fsf@localhost.localdomain>
 <20110112000812.GA31950@burratino>
 <loom.20110112T232501-316@post.gmane.org>
 <20110114084903.GD11343@burratino>
 <4D308B69.1050003@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aleksey Shumkin <zapped@mail.ru>
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jan 14 20:31:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdpMP-0008VL-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 20:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab1ANTau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 14:30:50 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64959 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1ANTat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 14:30:49 -0500
Received: by qyk12 with SMTP id 12so3718233qyk.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 11:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Pxh3TS8+LhqsQAspvFM7Mze3Ryop7GvxP6kYJ6kgM/U=;
        b=cDMXDvUVm27dhH8IXViMyLGkdTEtaPZXB+Nn1NS7YHpVwAE+WVcRfv3mLZV2QF+sqe
         Rol8HoOptVZiM4AR4FJ7QZOm4PvYXkE2JE6PgfU3USQynSAOzNr7Q3qkSuBhZ2+xozqA
         TkqRCTKBxZwA8YkBlqQd9tQXqhYrKPzi8ac6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lCLEDE80f7LeDZiNxmxMvVSrKlfQ5bKK3PwonPaz3eZuY9mJrHBTjals/5wV6sJNpv
         UEjOTcLY/+1gdNdfWHLHY+bSEdIV0irnwnxd087kOT0WeN/RgFTtRXvbTdlZibdUtRRo
         AToCxuhI/lkPRTupqKq9v2sycepMmL81u4/+0=
Received: by 10.224.67.195 with SMTP id s3mr981870qai.256.1295033447178;
        Fri, 14 Jan 2011 11:30:47 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id g28sm1007471qck.25.2011.01.14.11.30.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 11:30:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D308B69.1050003@seznam.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165118>

Maaartin wrote:
> On 11-01-14 09:49, Jonathan Nieder wrote:

>> [side note: please do not prune the cc list; I only stumbled on this
>> message in the online archive by luck]
>
> What could I have done about it?

See [1].

> Maybe just something like "Let's assume there's only one and let's call
> it FIRST". For the example, this is enough.

True enough.  Even better would be to give a reference to the "coolest merge
ever" (is that documented anywhere?) so the interested reader can discover
how there could be more than one.

> I'd go the other way round and use "-i" so I'd need only one file.

"sed -i" is not portable (not sure how important that is for documentation).
But perl -i is. :)

> $ first_commit = $($ echo $first_commit |
> perl -p
> "s/^tree .*/$&\nparent $(git rev-parse v2.4)/")      <4>

So:

	perl -pi -e "s/^tree .*$/\$&\nparent $(git rev-parse v2.4)/" new

Unfortunately "echo" and process substitution destroy some formatting
in the commit message --- in particular, trailing whitespace.

Thanks for the suggestions.  Please feel free to pick up the patch and
run with it (I trust you for this more than I would trust myself).

Regards,
Jonathan

[1] My current method: [2]  Yes, I agree that this is cumbersome.

I'm also told that Thunderbird when used as a newsreader can reply-to-all
easily, though I haven't tried it.

[2] http://thread.gmane.org/gmane.comp.version-control.git/154490
