From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show project's git URL on summary page
Date: Tue, 15 Aug 2006 21:32:08 +0200
Message-ID: <8fe92b430608151232y3f0ecd8ei435337709557162e@mail.gmail.com>
References: <200608152003.05693.jnareb@gmail.com>
	 <Pine.LNX.4.63.0608151139280.29668@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 21:32:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD4eA-0005sC-Uo
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWHOTcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWHOTcM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 15:32:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:41151 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030477AbWHOTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 15:32:11 -0400
Received: by wr-out-0506.google.com with SMTP id i21so242237wra
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 12:32:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VkbeDFdqLBHRfeNLbLscfyLqFKK/Gib0sMOCEY6Ba0tQdywkIvC/DhPII3T1qLB/zaKQvnV2xlC+bq+KkXuu4qiXGl1iZGF8mgE16+NkY/1AWVy4pyBey8VeaYXKputpgDu7/nq5cE6T4roaRRfnrTV8aKMqqAI+CMQmzowwfI8=
Received: by 10.49.55.13 with SMTP id h13mr1727385nfk;
        Tue, 15 Aug 2006 12:32:08 -0700 (PDT)
Received: by 10.78.128.20 with HTTP; Tue, 15 Aug 2006 12:32:08 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608151139280.29668@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25475>

On 8/15/06, David Rientjes <rientjes@google.com> wrote:
> On Tue, 15 Aug 2006, Jakub Narebski wrote:

> > +     my $is_first_url = 1;
> > +     foreach my $git_base_url (@git_base_url_list) {
> > +             next unless $git_base_url; # skip empty/zerolength URLs
> > +             print "<tr><td>";
> > +             if ($is_first_url) {
> > +                     print "URL";
> > +                     $is_first_url = 0;
> > +             }
> > +             print "</td><td>$git_base_url/$project</td></tr>\n";
> > +     }
>
> Isn't it faster to do this (over 1.4.2):
> +       my $url_tag = "URL";
> +       foreach my $git_base_url (@git_base_url_list) {
> +               next unless $git_base_url;
> +               print "<tr><td>$url_tag</td><td>$git_base_url/$project</td></tr>\n";
> +               $url_tag = "";
> +       }

Yes, it is undobtedly better.

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
