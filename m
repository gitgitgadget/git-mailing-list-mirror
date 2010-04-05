From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to keep different version numbers in different branches?
Date: Mon, 05 Apr 2010 21:22:17 +0200
Message-ID: <vpqd3ydr9g6.fsf@bauges.imag.fr>
References: <hpcscv$umg$3@dough.gmane.org>
	<y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrsT-0006cy-8j
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab0DETWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 15:22:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44881 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141Ab0DETWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 15:22:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o35JHotv008907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Apr 2010 21:17:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NyrsH-0006jl-LT; Mon, 05 Apr 2010 21:22:17 +0200
In-Reply-To: <y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com> (Avery Pennarun's message of "Mon\, 5 Apr 2010 14\:51\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Apr 2010 21:17:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o35JHotv008907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271099871.34193@ZvXLLcQrqnTRhePp0RoLkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144052>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Mon, Apr 5, 2010 at 10:34 AM, Stephen Kelly <steveire@gmail.com> wrote:
>> I want to make a 0.1 release, so that would mean creating a 0.1 branch and
>> updating files contained in the branch such as the README file and the CMake
>> files and the api documentation to report version 0.1.0, and creating the
>> 0.1.0 tag. The next tag on that branch would be 0.1.1 etc. Simultaneously,
>> the version number in those files is changes to 0.2.0 in the master branch.
>>
>> However, now I have changes in my maintenance branch (0.1) which should not
>> be merged into master (that is, the commits which change the version
>> number).
>>
>> How are you supposed to handle that with git? Simply merge and resolve the
>> conflict on master by keeping its version number? Am I missing some other
>> way of doing it here?
>
> I've used that method.  it works fine, and the conflicts are only
> whenever the maintenance branch version number changes, which is very
> rare (and easy to see).

You can even make sure it _never_ happens, by making a one-commit
release branch which changes the version number for each release. This
one-commit is never merged in anything:

 0.1                         0.2
  |                           |
  v                           v
--o--o--o--o--o--o--o--o---o--o--o <--- master branch
   \                      /
    o--o--o--o--o--o--o--o--- ...  <--- maintainance branch
           \              \
            o <- 0.1.1     o <- 0.1.2

Here, the maintainance branch never changes the version number in
README & friends.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
