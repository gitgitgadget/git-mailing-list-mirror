From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 09:32:09 +0200
Organization: At home
Message-ID: <e7dh1c$61n$1@sea.gmane.org>
References: <20060622023546.28cb4291.froese@gmx.de> <11509591773212-git-send-email-jnareb@gmail.com> <7vejxhwts4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 09:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJfl-0000G2-O2
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbWFVHcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWFVHcP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:32:15 -0400
Received: from main.gmane.org ([80.91.229.2]:31897 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932821AbWFVHcO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 03:32:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtJfa-0000Ey-Jn
	for git@vger.kernel.org; Thu, 22 Jun 2006 09:32:06 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 09:32:06 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 09:32:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22306>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> @@ -326,7 +326,7 @@ EOF
>>              } elsif (defined $hash) {
>>                      $search_hash = $hash;
>>              } else {
>> -                    $search_hash  = "HEAD";
>> +                    $search_hash = "HEAD";
>>              }
>>              $cgi->param("a", "search");
>>              $cgi->param("h", $search_hash);
> 
> My copy from "next" has this part like the following:
> 
>               if (!defined $searchtext) {
>                       $searchtext = "";
>               }
>               my $search_hash;
>               if (defined $hash) {
>                       $search_hash = $hash;
>               } else {
>                       $search_hash  = "HEAD";
>               }
> 
> I thought we were both reasonably sure that we are now in
> sync...  I could apply it by hand but once I start doing that
> I'm afraid we will never converge.
> 
> It's quite frustrating.

I'm very sorry, I forgot that I applied Timo Hirvonen patch

  "[PATCH] gitweb: Start search from HEAD"
  (<20060620152515.23e59396.tihirvon@gmail.com>)
  http://permalink.gmane.org/gmane.comp.version-control.git/22197>

on top of 'next'.

This patch fixes search quite nicely, reducing significantly number of error
messages during search (e.g. starting search from blob or file view).

Any reason not to apply it?

>>              my $path = esc_html(chop_str($proj{'path'}, 25, 5));
>> -            my $rss =  "$my_url?p=$proj{'path'};a=rss";
>> -            my $html =  "$my_url?p=$proj{'path'};a=summary";
>> +            my $rss  = "$my_url?p=$proj{'path'};a=rss";
>> +            my $html = "$my_url?p=$proj{'path'};a=summary";
> 
> Are you sure you want to do "my $rss two-spaces equal space"?
> 
> I've fixed up the whitespace you missed and will be applying the
> following on top of what is in "next" tonight.
> 
> -- >8 --
> gitweb: do not align assignment = with extra whitespaces

My idea for coding style is to align assignment = with extra whitespaces,
but only where aligned assignments statements are one after another.

The above "my $rss" example was mistyped as " =  " instead of "  = ",
but I think it was meant to be aligned at '='. IMHO aligning at assign 
makes code more readable.

But that is just my opinion.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
