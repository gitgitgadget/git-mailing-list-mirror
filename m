From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 18:31:53 -0300
Message-ID: <46a038f90804171431q51215be8od41792293712ca9@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
	 <1208317795.26863.91.camel@goose.sun.com>
	 <87lk3c4ali.fsf@jeremyms.com>
	 <1208461808.26863.129.camel@goose.sun.com>
	 <46a038f90804171306t22491685p87d7445d44f00879@mail.gmail.com>
	 <7vabjsnrda.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0804171400x515b3c8br3cb1501cca8a6d0a@mail.gmail.com>
	 <46a038f90804171425q1cc4cff4m6b783252040a3b26@mail.gmail.com>
	 <bd6139dc0804171427i6bf2813at719c8dec13bc225c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Roman V. Shaposhnik" <rvs@sun.com>,
	"Jeremy Maitin-Shepard" <jbms@cmu.edu>,
	"Ping Yin" <pkufranky@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Apr 17 23:45:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmbii-0002r7-Si
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYDQVb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYDQVbz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:31:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:29601 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYDQVbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:31:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1249272ugc.16
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0QniL30er/3wm8pOWMZek4TPlKWBzcG1oeO1ggGKBcc=;
        b=sjfE91T3eUXYIHISaO6fhOEbz8GQ2XCpHmSQIdeCJycqU6DwKPYVJRyzFAALK3R+vgYA/MOvcJFrmyIFGc8/nDKENm5dfnQCdYPSUxWa2p2O2+zGbCuwkk59NqsMGMrjaIyHA7GnpVUNLwPleyqksBFUzQjrVOomOJhhL7BSiCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFrAWE6TzB61zebnhFb8akBfDQ2QFrWGJ7+qot38Sr6KdptVlqaVF0zfh+5zIx2bbzv2yct1UnI3fo1z9WVmD3tGOXXRoj0gysVOHrJZxesf96KC4rhB39ZNfqVxQNqXLXUkme44yT+nIczQc0Lq7H/irSAsIz2zuHQqbQvCfzk=
Received: by 10.67.115.9 with SMTP id s9mr8952678ugm.81.1208467913306;
        Thu, 17 Apr 2008 14:31:53 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Thu, 17 Apr 2008 14:31:53 -0700 (PDT)
In-Reply-To: <bd6139dc0804171427i6bf2813at719c8dec13bc225c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79837>

On Thu, Apr 17, 2008 at 6:27 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>  >  >  Because of that an in-tree '.gitconfig' would have no security risks
>  >  >  as long as it is not 'used' until after the clone.
>  >
>  >  This is not true. A pre-commit hook or pre-checkout hook could be destructive.
>
>  But, those won't be executed till after the review, so everything
>  would be good still, wouldn't it?

No. A local review can be quite "active", involving changing branches,
moving patches around, and fixing sh*t up. The hooks available offer
plenty of danger if the repo can set them and make them active:

$ ls .git/hooks/
applypatch-msg  post-commit   post-update     pre-commit  update
commit-msg      post-receive  pre-applypatch  pre-rebase

cheers,




m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
