From: WOLfgang Schricker <news@wols.org>
Subject: Re: [RFC PATCH] gitweb.perl: tags snapshot link
Date: Tue, 14 Sep 2010 20:06:17 +0200
Message-ID: <i6odiq$ire$1@dough.gmane.org>
References: <i5qmuo$ice$1@dough.gmane.org> <i6jnhg$epf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 20:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvZuC-0004bI-5H
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 20:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab0INSGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 14:06:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:33402 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab0INSGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 14:06:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OvZtl-0004NW-Fi
	for git@vger.kernel.org; Tue, 14 Sep 2010 20:06:29 +0200
Received: from p4fd02d15.dip.t-dialin.net ([79.208.45.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 20:06:29 +0200
Received: from news by p4fd02d15.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 20:06:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd02d15.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100910 Gentoo/2.0.7 SeaMonkey/2.0.7
In-Reply-To: <i6jnhg$epf$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156202>

Giuseppe Bilotta wrote:
> WOLfgang Schricker wrote:
> 
>> Hello,
>>
>> I missed a snapshot link in my local repo:
>> ====
>> tags
>> ====
>> tag | commit | shortlog | log | *snapshot*
>>
>> I found this threads
>>
>> <http://kerneltrap.org/mailarchive/git/2009/11/8/15785/thread>
>> <http://thread.gmane.org/gmane.comp.version-control.git/132366>
>>
>> and the code for "Smarter snapshot names" in 'gitwep.perl'.
>>
>> My gitweb.perl-1.7.2.2.patch for "activating":
>>
>>
>> --- gitweb.perl.orig	2010-08-20 01:44:47.000000000 +0200
>> +++ gitweb.perl	2010-09-03 13:20:40.000000000 +0200
>> @@ -4909,6 +4909,10 @@
>>  } elsif ($tag{'reftype'} eq "blob") {
>>  print " | " . $cgi->a({-href => href(action=>"blob_plain",
>>  hash=>$tag{'refid'})}, "raw"); }
>> +        my $snapshot_links = format_snapshot_links($tag{'fullname'});
>> +        if (defined $snapshot_links) {
>> +            print " | " . $snapshot_links;
>> +        }
>>  print "</td>\n" .
>>  "</tr>";
>>  }
> 
> If I read the patch correctly, this would add a 'snapshot' link to the tag
> list view. Although the snapshot can already be obtained by clicking first
> on the commit or shortlog view, this would reduce the number of clicks
> necessary to obtain the snapshot. I believe it would be a good idea to have
> this. Wolfgang: wold you consider submitting it in a more appropriate form
> for inclusion?
> 
> If you do, you should probably also consider other places where such a link
> could be added, such as in tag view, where the nav bar currently reads
> 
> summary | shortlog | log | commit | commitdiff | tree
> 
> and "| snapshot" could be appended.
>

Yes. _Every_ available snapshot link looks <project>-<SHA1>.tgz.
A 'v0.1' tag brings in the tag list project-v0.1.tgz now.
I see eg. a relocatable 'latest' tag for project-latest.tgz.
-- 
Regards
*WOL* fgang *S* chricker
