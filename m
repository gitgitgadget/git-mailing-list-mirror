From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 18:42:48 -0400
Message-ID: <017901d11108$ceb2cd10$6c186730$@com>
References: <87a8r4ary9.fsf@kyleam.com> <CAGZ79ka0XvmvVpX5WrpeEBXBWKA41RTZm4p7q=QtUTFy18hkoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Stefan Beller'" <sbeller@google.com>,
	"'Kyle Meyer'" <kyle@kyleam.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrD2b-0007cz-3V
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbbJ0WsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:48:24 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53282 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbbJ0WsY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 18:48:24 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2015 18:48:23 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gojira (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t9RMgtct068282
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Oct 2015 18:42:56 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CAGZ79ka0XvmvVpX5WrpeEBXBWKA41RTZm4p7q=QtUTFy18hkoA@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdERBhkoZIguiuP8QJK9skbxPWa1SQAAfmgQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280311>

-----Original Message-----
On Tue, October-27-15 6:23 PM, Stefan Beller wrote:
>On Tue, Oct 27, 2015 at 3:04 PM, Kyle Meyer <kyle@kyleam.com> wrote:
>> When a ".git" file points to another repo, a ".git/gitdir" file is 
>> created in that repo.
>>
>> For example, running
>>
>>     $ mkdir repo-a repo-b
>>     $ cd repo-a
>>     $ git init
>>     $ cd ../repo-b
>>     $ echo "gitdir: ../repo-a/.git" > .git
>>     $ git status
>>
>> results in a file "repo-a/.git/gitdir" that contains
>>
>>     $ cat repo-a/.git/gitdir
>>     .git
>>
>> I don't see this file mentioned in the gitrepository-layout manpage, 
>> and my searches haven't turned up any information on it.  What's the 
>> purpose of ".git/gitdir"?  Are there cases where it will contain 
>> something other than ".git"?
>
>It's designed for submodules to work IIUC.
>
>Back in the day each git submodule had its own .git directory keeping its local >objects.

>Nowadays the repository of submodule <name> is kept in the superprojects >.git/modules/<name> directory.

Slightly OT: Is there any way of avoiding having that file in the first place? I'm hoping to have a git repository in a normal file system (Posix) and a working area in a rather less-than-normal one where dots in file names are bad (actually a dot is a separator).

Cheers,
Randall
