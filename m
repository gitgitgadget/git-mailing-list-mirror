From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 00:28:14 -0400
Message-ID: <4292AD5E.3000106@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <4292A1F2.7020606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 06:29:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaR1d-0003PZ-JJ
	for gcvg-git@gmane.org; Tue, 24 May 2005 06:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEXE3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 00:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEXE3s
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 00:29:48 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:65244 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261204AbVEXE3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 00:29:43 -0400
Received: from [192.168.0.103] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-03.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j4O4SnGi003529;
	Tue, 24 May 2005 00:28:49 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4292A1F2.7020606@zytor.com>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> David Mansfield wrote:
> 
>>
>> Ok.  I'll tell you.  It means that the committer uses bad practices in 
>> tagging ;-)  It generally means that force tag (cvs tag -F <file>) was 
>> used on a specific file.  Here's the scenario:
>>
>> cvsps is trying to associate a tag to a specific commit.  But in the 
>> cvs world this is not always at all possible.  If, for example, a 
>> commit made and  all files are tagged.  Now some random file is 
>> modified and committed.  Then, a bug is found in a file from the 
>> previously tagged set, say the file 'memdisk/init32.asm'.  The bug is 
>> fixed, committed and the tag is MOVED for _just that file_ forward to 
>> the new version.  Now there is no commit that can be associated with 
>> the tag.  In this case, cvsps believes this to be a 'FUNKY' tag.  
>> There is a more pathological case having to do with 'INVALID' tags...  
>> It's enough to make a grown man cry.
>>
> 
> This is only pathological if the tag now represents a state that never 
> actually existed in the history of the repository.  I don't believe 
> there are any such cases in the syslinux repository; I could be wrong, 
> but I am *highly* sceptical.
> 

I didn't mean that YOUR repository had more pathological stuff in it, 
just that SOME do.  'FUNKY' tags are not really that bad, it's just that 
there is not a single commit to assign them to (i.e. at no point were 
all of the objects in the repository at that state simultaneously), 
which makes the import of such a tag difficult into a more commit 
oriented system.

Another way to reach 'funky'ness is to modify a file, commit and tag, 
without having done a 'cvs update' first (and a colleague has done a 
commit since your last 'cvs update')

David



