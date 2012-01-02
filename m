From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: How to deal with historic tar-balls
Date: Mon, 02 Jan 2012 19:26:26 +0100
Message-ID: <4F01F6D2.8020005@dirk.my1.cc>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com> <B375E525C4704EA8807B5A59257B690B@PhilipOakley> <4C50794C7EED42A0B1A25ABD77CE7DB0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tom@dbservice.com>, nn6eumtr <nn6eumtr@gmail.com>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jan 02 19:26:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhmai-0005au-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 19:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385Ab2ABS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 13:26:31 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:44107 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab2ABS0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 13:26:30 -0500
Received: from [217.87.96.221] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1RhmaZ-0007Z9-D6; Mon, 02 Jan 2012 19:26:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4C50794C7EED42A0B1A25ABD77CE7DB0@PhilipOakley>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187840>

Am 02.01.2012 11:07 schrieb Philip Oakley:
> From: "Philip Oakley" <philipoakley@iee.org>: Sunday, January 01, 2012
> 6:30 PM
>> From: "Tomas Carnecky" <tom@dbservice.com> : Sunday, January 01, 2012
>> 12:27 AM
>>> On 12/31/11 8:04 PM, nn6eumtr wrote:
>>>> I have a number of older projects that I want to bring into a git
>>>> repository. They predate a lot of the popular scm systems, so they are
>>>> primarily a collection of tarballs today.
>>> There is a script which will import sources from multiple tarballs,
>>> creating a commit with the contents of each tarball. It's in the git
>>> repository under contrib/fast-import/import-tars.perl.
>> I wasn't aware of those scripts. I'll be having a look at the zip import
>> script for my needs.
>>
>>> tom
>> Philip
>>
> I had a look at the script but Python isn't part of the Msysgit install,
> so the example wouldn't run.
> 
> Also I couldn't see how the "fast_import.write(" method was being
> created - my ignorance of Python? Otherwise I could look at scripting it.
> 
> Philip

Philip,

I'm not a Python guy, but I think fast_import.write() writes sth. to
whatever the popen() call in line 24 returned:

  fast_import = popen('git fast-import --quiet', 'w')

I guess it returns a filehandle and 'git fast-import' reads its data
from stdin. My guess is, that -- instead of writing to that pipe -- you
could as well write everything to a temporary file and finally call

  git fast-import < $tempfile

But that's only a guess.

Dirk
