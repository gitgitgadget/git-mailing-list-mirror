From: Patrick Lehner <lehner.patrick@gmx.de>
Subject: Re: `git mv` has ambiguous error message for non-existing target
Date: Fri, 16 Nov 2012 08:10:10 +0100
Message-ID: <50A5E6D2.5060609@gmx.de>
References: <50A53A80.4080203@gmx.de> <7vehju8h5j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 08:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZG4O-00074X-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 08:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2KPHKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 02:10:16 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:39727 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751255Ab2KPHKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 02:10:15 -0500
Received: (qmail invoked by alias); 16 Nov 2012 07:10:13 -0000
Received: from 188-194-118-2-dynip.superkabel.de (EHLO [192.168.1.110]) [188.194.118.2]
  by mail.gmx.net (mp036) with SMTP; 16 Nov 2012 08:10:13 +0100
X-Authenticated: #36416844
X-Provags-ID: V01U2FsdGVkX1/VN2YLeMjVt037ESv8IGMEjTVUm/5lS02hwl+Pof
	NcZ5vpyY5nC7Dc
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vehju8h5j.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209866>

But just because mv's error essage isnt very good, does that mean git 
mv's error message mustn't be better? That would strike me as an odd 
bit of reasoning.

On Fr 16 Nov 2012 02:34:32 CET, Junio C Hamano wrote:
> Patrick Lehner <lehner.patrick@gmx.de> writes:
>
>> To reproduce:
>> - cd into a git repo
>> - assuming "filea.txt" is an existing file in the CWD, and "dirb" is
>> neither a file nor a directory in the CWD, use the command "git mv
>> filea.txt dirb/filea.txt"
>> - this will produce an error message like `fatal: renaming 'filea.sh'
>> failed: No such file or directory`
>>
>> It does not mention that the problem is, in fact, the target directory
>> not existing. This seems to be mostly a problem for users unfamiliar
>> with bash/*nix console commands. Although it is documented that git mv
>> will not create intermediate folders (which is fine, because neither
>> does mv), the error message might lead to believe a problem exists
>> with the source file.
>
>      $ rm -fr xxx
>      $ >yyy
>      $ mv yyy xxx/yyy
>      mv: cannot move `yyy' to `xxx/yyy': No such file or directory
>
> It doesn't mention that the problem is with 'xxx' and not 'yyy'
> either.
>
>
