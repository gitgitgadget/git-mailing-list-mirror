From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Sat, 29 Mar 2008 15:30:08 +0100
Organization: At home
Message-ID: <fsljpe$i9o$1@ger.gmane.org>
References: <1206707716.9819.15.camel@malory> <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com> <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com> <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com> <47ED204E.3020602@viscovery.net> <b2cdc9f30803290647n31bd6db5r4f346360989c2dcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 15:31:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfc5S-0007dY-Cg
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 15:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYC2OaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYC2OaS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 10:30:18 -0400
Received: from main.gmane.org ([80.91.229.2]:40314 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbYC2OaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 10:30:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jfc4T-0003pD-Jz
	for git@vger.kernel.org; Sat, 29 Mar 2008 14:30:13 +0000
Received: from abvq246.neoplus.adsl.tpnet.pl ([83.8.214.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 14:30:13 +0000
Received: from jnareb by abvq246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 14:30:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78470>

Alex Bennee wrote:

> On Fri, Mar 28, 2008 at 4:43 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Alex Bennee schrieb:
>>
>>  You really shouldn't do it this way, unless you do it on a ramdisk. Better
>>  use an --index-filter. This is modeled after the last example in the man
>>  page (and, of course, untested):
>>
>>  git filter-branch --index-filter \
>>         'git ls-files -s |
>>          grep -v "      big_dira" |
>>          grep -v "      big_dirb" |
>>                 GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>>                         git update-index --index-info &&
>>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
>>
>>  where the space before big_dir is actually a literal TAB!
> 
> Hmm thats odd. Despite having successfully run the filter my repo is
> still the same size. git-fsck --full shows loads of dangling commits
> but I'm guessing because the repo is packed they don't get dropped. Is
> it possible to repack the whole repo or do you have to manually unpack
> the packs and re-pack?

Did you pruned the repo ("git gc --prune" or "git prune")?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
