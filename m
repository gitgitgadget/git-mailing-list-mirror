From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 19 May 2012 01:32:09 -0500
Message-ID: <20120519063208.GA24556@burratino>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
 <20120519060031.GB23799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 08:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVdDl-0003MB-Gk
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 08:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab2ESGcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 02:32:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53449 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2ESGcT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 02:32:19 -0400
Received: by obbtb18 with SMTP id tb18so4968909obb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tAXWvKKTY89CthGwBU1IicXkMkMwaxrt9+oyMyRTvrQ=;
        b=zy84/wP5xukNQ7LXCNoX5ky4e1Qm4W3dlGK3jbGkWtFXq4+mpChV31wFdj7jNKeaBi
         ZCq9DOgRFvk/hub62uE7JZ4pHcs33VuPh4wXJyHb5mc+zg/jKzleM/PpxuJt91PVxVcb
         oTHMEo3CSprQKrVlkUd3v2kOg6GDPl2DdY2+ybnr6/4weOeA3sniA3KJ6cT945mvr9Bx
         zU9huuZNooic+GI9Ltz8gRx71qBak+5iRMfXCEsdzNNHXXqp7hicsuDl6w16gI2dZuQI
         aZ0VEXm5OPFWGuq966MeCpVdcfym1TOxuNKxN17yHJgnxf0ERKlZR+uGTqmyVWT9Wxfn
         LvyA==
Received: by 10.50.191.200 with SMTP id ha8mr2579049igc.45.1337409138980;
        Fri, 18 May 2012 23:32:18 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mk10sm2208902igc.11.2012.05.18.23.32.17
        (version=SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120519060031.GB23799@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198018>

Jonathan Nieder wrote:

> For the sake of having a proposal: :)

For the command-line interface:

Making the "git stage" command more prominent.  Unfortunately it is
currently a synonym for "git add", which makes "git rm" less
discoverable and generally isn't very helpful.  But if we discard that
property, it could become a nice way to make some operations more
discoverable:

	git stage --add <paths>; # stage an addition
	git stage --remove <paths>; # stage a removal
	git stage --edit <paths>; # edit the staged content
	git stage --apply <patch>; # stage the described change

These would be commands that modify the index without touching the
worktree.

If anyone claims this is the command for manipulating "the stage", we
can apologize for the confusing homonym and point them to a dictionary
and images of raised platforms and staging areas and hopefully that
will avoid any confusion.  The command is named after the verb.

Finding a better mnemonic than "also update the current directory cache"
and "trust the current directory cache" for operations like git apply
--index and git grep --cached.  Better concepts would be "search the
content staged for the next commit" and "also update the staged
content".

Maybe:

	git apply --index=(yes | no | only)
		# apply         	= apply --index=no
		# apply --index 	= apply --index=yes
		# apply --cached	= apply --index=only

	git grep --index; # (= git grep --cached)

I imagine others can come up with something better.
