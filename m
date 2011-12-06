From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Query on git commit amend
Date: Tue, 06 Dec 2011 20:09:50 +0100
Message-ID: <4EDE687E.7020604@dirk.my1.cc>
References: <4EDDD0E4.6040003@st.com> <20111206130138.119db519.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar@st.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 20:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0VK-0007LU-9g
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 20:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab1LFTQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 14:16:29 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:44883 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab1LFTQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 14:16:25 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Dec 2011 14:16:25 EST
Received: from [217.87.120.134] (helo=[192.168.2.100])
	by smtprelay04.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RY0On-00081A-3M; Tue, 06 Dec 2011 20:09:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111206130138.119db519.kostix@domain007.com>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186373>

Am 06.12.2011 10:01 schrieb Konstantin Khomoutov:
> On Tue, 6 Dec 2011 13:53:00 +0530
> Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> Suppose i want to add few new changes to my last commit (HEAD).
>> The way i do it is
>> $ git add all_changed_files
>> $ git commit --amend
>>
>> OR
>> $ git commit --amend -a
>>
>> With both these ways, i get a screen to edit the message too.
>>
>> I want to know if there is a way to skip this screen.
>>
>> i.e.
>> $ git commit --amend -a -some_other_option
>>
>> which simply adds new changes to existing commit, without asking to
>> change message.
>>
>> If there is no such way, then can we add a patch for this, if it
>> looks a valid case.
> git commit --amend -C HEAD

$ git commit --amend -C HEAD

works fine but will keep the authorship (name _and_ date). To change the
date to the current timestamp, use

$ git commit --amend -C HEAD --reset-author

Note that this will also change the author's name to yours, so it
depends on your case. The commiter's name and timestamp are always
updated to "you/now", independently of that option. To change only the
author's date, use --date=<date>.

Cheers,
    Dirk
