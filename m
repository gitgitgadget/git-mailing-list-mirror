From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH] Allow git-repack to optionally run git-prune-packed.
Date: Thu, 9 Mar 2006 13:24:19 +0300
Message-ID: <20060309102419.GA9961@igloo.ds.co.ug>
References: <11417445722524-git-send-email-matlads@dsmagic.com> <20060307212918.GA9474@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 11:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHIKq-0001GI-Fn
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWCIKYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWCIKYp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:24:45 -0500
Received: from mail1.imul.com ([217.113.72.31]:43268 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S1751784AbWCIKYo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 05:24:44 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Thu, 09 Mar 2006 13:24:28 +0300
  id 000F1B06.4410025D.00007382
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 3D6CC526A; Thu,  9 Mar 2006 13:26:29 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1FHIJf-0002g2-Il; Thu, 09 Mar 2006 13:24:19 +0300
To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060307212918.GA9474@steel.home>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17403>

Your suggestion has merit, though it's different from the behaviour I
desired. I _sometimes_ need the pruning, and it felt appropriate to make
it an option as opposed to default behaviour.

What do you think?

- Martin -

On Tue, Mar 07, 2006 at 10:29:18PM +0100, Alex Riesen wrote:
> Martin Atukunda, Tue, Mar 07, 2006 16:16:12 +0100:
> > +-p::
> > +	Run `git-prune-packed` after packing, see
> > +	gitlink:git-prune-packed[1]
> > +
> 
> Maybe just make "-d" work? I.e. "git repack -a -d" repacks and prunes
> everything, and "git repack -d" prunes just what was packed
> incrementally.
> Something like this:
> 
> diff --git a/git-repack.sh b/git-repack.sh
> index 3d6fec1..be6c7ab 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -74,6 +74,8 @@ then
>  			esac
>  		  done
>  		)
> +	else
> +		git-prune-packed
>  	fi
>  fi
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Girl on cell: Can you hear me when I roll my eyes?
	-- www.overheardinnewyourk.com
