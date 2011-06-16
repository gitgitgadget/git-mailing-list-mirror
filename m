From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Objects deleted before first commit
Date: Thu, 16 Jun 2011 22:38:17 +0200
Message-ID: <4DFA69B9.3020605@dbservice.com>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>	<BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>	<8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>	<BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com> <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Barr <davidbarr@google.com>,
	Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: PJ Weisberg <pjweisberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 22:38:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXJKh-0007DN-Ki
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab1FPUiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 16:38:25 -0400
Received: from static.133.192.47.78.clients.your-server.de ([78.47.192.133]:59928
	"EHLO office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063Ab1FPUiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 16:38:24 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 16 Jun 2011 22:38:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175931>

On 6/14/11 4:44 PM, PJ Weisberg wrote:
> On Tuesday, June 14, 2011, David Barr<davidbarr@google.com>  wrote:
>> On Tue, Jun 14, 2011 at 11:00 PM, Edmondo Porcu
>> <Edmondo.Porcu@gottexbrokers.com>  wrote:
>>> dangling blob 43cb00bb9f23b73afc874c4105b136f8c426e4a5
>>> dangling blob 48ef642adb1549ee1d4040ec9337d3a47c19d422
>> [...]
>>
>> Was it 'rm -rf' or 'git rm -rf'?
>> If just the non-git command, maybe 'git checkout --<missing paths>'?
> Not if it was never checked in, unfortunately.

You don't need to commit the file. If you add files with `git add` and 
then delete them with plain `rm`, you can recover them with a simple 
`git checkout`, just like David suggested. See this transcript:

$ git init tmp
Initialized empty Git repository in <snip>/tmp/.git/
$ cd tmp
$ touch file
$ git add file
$ rm file
$ ls file
ls: file: No such file or directory
$ git checkout -- file
$ ls file
file
$
