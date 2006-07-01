From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 18:11:12 -0700 (PDT)
Message-ID: <20060701011112.892.qmail@web31813.mail.mud.yahoo.com>
References: <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 03:11:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwU0z-0005SM-Fx
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWGABLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWGABLO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:11:14 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:6303 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932417AbWGABLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 21:11:13 -0400
Received: (qmail 894 invoked by uid 60001); 1 Jul 2006 01:11:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l1G22SxiWoBFOKz53cae/kl8FIxQFOd4elByOyfjmvSnMws4gZ3WhVN0QtfHGqCtz6a/uT97vBV5f3kephoYAZ/ZASKvmkZIUwfI2X00r9Rlk/GlCFbxYJhtWKYjiF6flFEfLo8VuggvoCbnnoShQtyNWW6L2lGx0ITVUV7uNoM=  ;
Received: from [68.186.62.135] by web31813.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 18:11:12 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23026>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Speed up history generation as suggested by Linus.
> > @@ -2295,16 +2295,12 @@ sub git_history {
> >  	      "</div>\n";
> >  	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
> >  
> > -	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
> > \'$file_name\'";
> > -	my $commit;
> > +	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
> 
> This would speed things up but at the same time it changes the
> semantics because it involves merge simplification, no?
> 
> At least that should be noted in the commit log.

Ok, I guess this should be in the log.  Can you add it please when
commiting to the master git branch?

   Luben
