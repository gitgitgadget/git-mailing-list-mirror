From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] revert: Catch incompatible command-line options
 early
Date: Sat, 2 Jul 2011 15:02:09 -0500
Message-ID: <20110702200209.GA16818@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-10-git-send-email-artagnon@gmail.com>
 <20110621170416.GN15461@elie>
 <BANLkTinN6KdPnuMWbrdE4jf4ijKDC=35Aw@mail.gmail.com>
 <20110702095334.GA19090@elie>
 <20110702100436.GB19090@elie>
 <BANLkTik2t=qPfJe7JUsoeka79ZYYRmU_MA@mail.gmail.com>
 <20110702113008.GA21526@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 22:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd6OV-0000Fb-31
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 22:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab1GBUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 16:02:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52439 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab1GBUCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 16:02:18 -0400
Received: by iwn6 with SMTP id 6so3595407iwn.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WlR7pdqCBlkj7CM2/YgNGRgtbOLLdoAJ92bU/23AXH4=;
        b=w324RGpfFyRJ0MUmUl9D5ughG3Mv8TRiy/MUecdpRGF55s8AfNWe1VjxmjD2MX9RMV
         wtedf9wU8B/BvgR/NkTspUPU9gUzrkS8AZlHLqFc67VyErzZ6BsCiUWplDWk5izO607Q
         ynlPT8d/ogHcOYHqbvW+VGjB4v5Bwt0yxtXnU=
Received: by 10.42.146.133 with SMTP id j5mr4645051icv.180.1309636937545;
        Sat, 02 Jul 2011 13:02:17 -0700 (PDT)
Received: from elie (adsl-68-255-111-183.dsl.chcgil.ameritech.net [68.255.111.183])
        by mx.google.com with ESMTPS id a9sm2108068icy.6.2011.07.02.13.02.14
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 13:02:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110702113008.GA21526@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176567>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:

>> Although pick_commits checks the validity of the
>>     replay_opts strucutre before before starting its operation, this is
>>     fragile design because the validity of the replay_opts structure
>>     depends on pick_commits being called before anything else.
>
> Thanks, that's a bit more concrete.  But it's not fragile, is it?
> pick_commits() is the entry point to the cherry-pick machinery ---
> anything that uses a struct replay_opts is called indirectly by
> pick_commits(), no?

Perhaps the idea is that in the future, there will be multiple entry
points?

Again, the questions the reader will have are:

 - what is wrong with the code? (i.e., assume I'm a total stick in
   the mud and convince me there needs to be *some* change)
 - why does the current code work at all?
 - what is the proposed fix?
 - how will it work better?
 - what are the downsides, and how does the patch mitigate them?

Exact wording does not matter, as long as those questions are
answered.
