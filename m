From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 1/6] git-remote-helpers.txt: document invocation before input format
Date: Wed, 12 Dec 2012 23:58:54 +0100
Message-ID: <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de> <1354057407-83151-2-git-send-email-max@quendi.de> <CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivGq-0002xJ-8s
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2LLW7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:59:03 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:42930 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013Ab2LLW7B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:59:01 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TivGQ-0005YW-0f; Wed, 12 Dec 2012 23:58:54 +0100
In-Reply-To: <CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1355353141;d1ba251a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211407>


On 12.12.2012, at 23:14, Felipe Contreras wrote:

> On Tue, Nov 27, 2012 at 5:03 PM, Max Horn <max@quendi.de> wrote:
> 
>> index 5ce4cda..9a7e583 100644
>> --- a/Documentation/git-remote-helpers.txt
>> +++ b/Documentation/git-remote-helpers.txt
>> @@ -35,6 +35,37 @@ transport protocols, such as 'git-remote-http', 'git-remote-https',
>> 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
>> 'fetch', 'option', and 'push'.
>> 
>> +INVOCATION
>> +----------
>> +
>> +Remote helper programs are invoked with one or (optionally) two
>> +arguments. The first argument specifies a remote repository as in git;
>> +it is either the name of a configured remote or a URL. The second
>> +argument specifies a URL; it is usually of the form
>> +'<transport>://<address>', but any arbitrary string is possible.
>> +The 'GIT_DIR' environment variable is set up for the remote helper
>> +and can be used to determine where to store additional data or from
>> +which directory to invoke auxiliary git commands.
>> +
>> +When git encounters a URL of the form '<transport>://<address>', where
>> +'<transport>' is a protocol that it cannot handle natively, it
>> +automatically invokes 'git remote-<transport>' with the full URL as
>> +the second argument. If such a URL is encountered directly on the
>> +command line, the first argument is the same as the second, and if it
>> +is encountered in a configured remote, the first argument is the name
>> +of that remote.
> 
> Maybe it's worth mentioning that if the alias of the remote is not
> specified, the URL is used instead.

Worth a thought yeah -- but beyond the scope of this patch: I merely moved this text around, but did not touch it otherwise.

> 
>> +A URL of the form '<transport>::<address>' explicitly instructs git to
>> +invoke 'git remote-<transport>' with '<address>' as the second
>> +argument. If such a URL is encountered directly on the command line,
>> +the first argument is '<address>', and if it is encountered in a
>> +configured remote, the first argument is the name of that remote.
>> +
>> +Additionally, when a configured remote has 'remote.<name>.vcs' set to
>> +'<transport>', git explicitly invokes 'git remote-<transport>' with
>> +'<name>' as the first argument. If set, the second argument is
>> +'remote.<name>.url'; otherwise, the second argument is omitted.
> 
> I find all this text a bit confusing. First argument, second argument,
> etc. Personally, I would describe everything in the terms of alias
> (1st arg), and URL (2nd arg).

Yeah, I also thought about that, but as above, deliberately did not touch it here, but only moved it around. I'll be happy to revisit this on a future date, though.


Thanks for the feedback,
Max