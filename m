From: "Adam Brewster" <adam@adambrewster.com>
Subject: Re: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Tue, 24 Jun 2008 11:30:38 -0400
Message-ID: <c376da900806240830p2a48aff0uaf6f22372fead5ef@mail.gmail.com>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com>
	 <1214273297-8257-2-git-send-email-adambrewster@gmail.com>
	 <c376da900806231921y2d822been9cd573d509fbf78a@mail.gmail.com>
	 <m3iqvzl091.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBAUd-0003NP-Jz
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbYFXPao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbYFXPao
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:30:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:33125 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbYFXPam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:30:42 -0400
Received: by yx-out-2324.google.com with SMTP id 31so539259yxl.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=IMIESM2mM0H9FwiOG96FuPiLeiHQJC+ixERla999BPo=;
        b=RsKUERqZMApbWR6tr41f80toOxuG4wxDu042nayrZkygy5SXoj8POjcsW2i+EUMk0G
         8res2pg6yFSOslsPhQy9ghK4V4V++p4l1bKqx7TJST8P4TuDpIR1ASfBixKq1LV6V+xy
         c+k3DedjCoOE+/I7n4zI/swwhUYqPiPjFKaPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Eb0G11sgG/vPZuF0qKQNLsoo0PnAYoOfvTucuwpNNp7Rckcs6siCpPO3W1GpdgtCBK
         JV8hDsSv7Gis7DHQCkcd02+fA1Bx/bL53V3AvLv8xOLq9xxeAXe28j++G4m8ULpsB6Z0
         kIZGEORMXfBoAp82LQBizNeQ8SK2+nYscp3B0=
Received: by 10.125.136.9 with SMTP id o9mr1310444mkn.38.1214321438056;
        Tue, 24 Jun 2008 08:30:38 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Tue, 24 Jun 2008 08:30:38 -0700 (PDT)
In-Reply-To: <m3iqvzl091.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: aef4028baf62177b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86073>

>> Git-basis is a perl script that remembers bases for use by git-bundle.
>> Code from rev-parse was borrowed to allow git-bundle to handle --stdin.
>
> I'd rather you follow git-pack-objects, and use `--revs` for the name
> of this option (or even '--not --revs').  The name `--stdin` might
> imply that you are providing objects names on stdin of git-bundle.
>
> But perhaps I am worrying over nothing.
>

This seems like a fine idea.

> [...]
>> Then you can add the objects in the bundle to the basis, so they won't
>> get included in the next pack like this:
>>
>>  $ git-basis --update my-basis < my-bundle
>
> Why not use "$(git ls-remote my-bundle)" somewhere in the invocation
> creating new bundle instead?
>

You could use "git ls-remote my-bundle | git-basis --update my-basis"
to do the same thing as the command I gave above.

>> I'm sure that my implementation is crap, but I think this is a useful
>> idea.  Anybody agree?  Disagree?
>
> Documentation, please?  Especially that it looks like '--stdin' option
> is a bit tricky...
>

I wanted to test the waters and make sure that someone was at least
vaguely interested in this (no need to document code that is never
going to leave my machine).

I'll prepare another patch with documentation and changing --stdin to
--revs when I get a chance.

Thank you,
Adam Brewster
