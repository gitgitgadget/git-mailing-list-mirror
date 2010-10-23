From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Sat, 23 Oct 2010 20:33:33 +0200
Message-ID: <vpqeibgn4hu.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-2-git-send-email-Matthieu.Moy@imag.fr>
	<20101023181350.GA21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ivH-0004Ey-Jq
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209Ab0JWSeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:34:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48522 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671Ab0JWSeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:34:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9NIRIoE013627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 20:27:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9iuL-0007YL-Um; Sat, 23 Oct 2010 20:33:34 +0200
In-Reply-To: <20101023181350.GA21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 13\:13\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 Oct 2010 20:27:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NIRIoE013627
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288463239.67147@vLMPxMIqFQTkxaPmWYiFEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159806>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/gittutorial-2.txt
>> +++ b/Documentation/gittutorial-2.txt
>> @@ -373,7 +373,7 @@ $ git status
>>  #
>>  #       new file: closing.txt
>>  #
>> -# Changed but not updated:
>> +# Changed but not staged for commit:
>>  #   (use "git add <file>..." to update what will be committed)
>
> I find this even more confusing, though I admit that may be due to
> habit more than anything else.
>
> My reading, before:
>
> 	These files were changed, but the version to be committed has
> 	not been updated to include the latest changes (use "git add
> 	<file>..." to add these changes to the index).
>
> Afterwards:
>
> 	These files were changed, but they are not staged for the
> 	next commit.

I don't see what "git status" lists as "files", but more as "changes".
Actually, the header for staged commit agrees with me:

  # Changes to be committed:

So, while these _files_ may have staged changes, the modifications
themselves are not commited.

> I would prefer to say something to the effect of
>
> 	# Has unstaged changes:

I'm fine with that if people prefer it. Otherwise, I propose:

  # Changes not staged for commit:

which would give some symetry in the complete output:

  # Changes to be committed:
  #
  #       modified:   foo.txt
  #
  # Changes not staged for commit:
  #
  #       modified:   foo.txt
  #

Which one do you like best?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
