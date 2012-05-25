From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 13:25:58 -0500
Message-ID: <20120525182558.GC4491@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzDG-0003pc-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758335Ab2EYS0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:26:04 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53947 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2EYS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:26:03 -0400
Received: by gglu4 with SMTP id u4so1055080ggl.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qeyHkt7PNxJ00nj92l9pKWHsyoLBuv69eUyiW4/U/g0=;
        b=ThLt8o2bB9W2Pzumrm3ypiXiQXzzXjRWkKBor/344cF5uYKvkm7jnLmZCQ94DcZOrQ
         v6JrBRbQ6vi1PkY/cb3gWEtMwZDQVYmWzHwPqW7dtpJA3PeCmZKQJgFOWd07ea5UJ4B3
         6Hs2f2zYAHLCd9ZxPRWA0pNWk2pYdOIo5LrZJpSPdJmMMtDNbamICk3FdnGIuWz8X8M/
         5StcRVidwcX+4o93xyvXa9iUdoov8M+vliQPvIKY0WcBMHnaNNIJlujcdn4m8pbubiA/
         VX5wbTsspfAu7WLJx2qSHgMabl/YxuJ562jWQ6Cz1ct/qt7jcoSYyxLHMH2/NetGoWEZ
         tfVw==
Received: by 10.50.187.135 with SMTP id fs7mr3333099igc.63.1337970361996;
        Fri, 25 May 2012 11:26:01 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nh8sm46401709igc.1.2012.05.25.11.26.00
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 11:26:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198503>

Junio C Hamano wrote:

>                     We already have ETC_GITCONFIG, so the only thing it
> might be nicer to add is the build configurability of ~/.gitconfig file,
> no?

If we were trying to solve a different problem ("my filesystem does
not support filenames starting with '.' with more than three
characters afterward") then I would agree, but in this case no.  HOME
directories are often shared between multiple machines, even machines
with different operating systems.

If I understand correctly, the proposal that started this thread was
to give people a chance to tidy their HOME directory by moving
personal git configuration under ~/.config/git/.  Git would detect it
automatically.  I think the main complication would be phasing in the
change slowly and carefully so people helping each other with git
problems do not get confused:

  "Why is this setting not taking effect?  It's in ~/.config/gitconfig
   just like it should be.  Oh, what git version do you have?"

and

  "Is there no .gitconfig?  Okay, we can assume all the default
   settings are in use.  Now let's..."

That's why I'd be happy to see how an initial patch approaches the
transition, to see how it can be improved to happen smoothly.

Jonathan
