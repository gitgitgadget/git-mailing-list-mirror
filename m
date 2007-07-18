From: Richard MUSIL <richard.musil@st.com>
Subject: Re: [PATCH] git-svn: Minimalistic patch which allows svn usernames
 with space(s).
Date: Wed, 18 Jul 2007 10:47:59 +0200
Message-ID: <469DD3BF.70709@st.com>
References: <469CF641.4020707@st.com> <20070717195559.GA20103@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 10:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB5Ce-00085o-IU
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 10:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbXGRIsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 04:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbXGRIsG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 04:48:06 -0400
Received: from s200aog12.obsmtp.com ([207.126.144.126]:36742 "EHLO
	s200aog12.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbXGRIsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 04:48:05 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob012.postini.com ([207.126.147.11]) with SMTP;
	Wed, 18 Jul 2007 08:48:01 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 413CEDAE2
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 08:48:01 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C3484BE13
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 08:48:00 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIH48400 (AUTH "richard musil");
	Wed, 18 Jul 2007 10:45:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070717195559.GA20103@muzzle>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52842>

Eric Wong wrote:
> Richard MUSIL <richard.musil@st.com> wrote:
>> Changed filter for username in svn-authors file, so even 'user name' is accepted.
>> ---
>>  git-svn.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 01c3904..975075e 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -740,7 +740,7 @@ sub load_authors {
>>         my $log = $cmd eq 'log';
>>         while (<$authors>) {
>>                 chomp;
>> -               next unless /^(\S+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
>> +               next unless /^(\.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> 
> Surely you mean the following:
> 
> +               next unless /^(.+?|\(no author\))\s*=\s*(.+?)\s*<(.+)>\s*$/;
> 
> (No "\" before the ".")   "\." matches a dot/period (.), while "."
> matches anything.
> 
Yes! I am sorry for a confusion, I have tested it on '.' version, but committed the wrong one :(.

Richard
