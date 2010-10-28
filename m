From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Fri, 29 Oct 2010 01:39:57 +0200
Message-ID: <vpqpqut7upe.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
	<20101028183513.GC14212@burratino>
	<7vaaly9eji.fsf@alter.siamese.dyndns.org>
	<20101028220956.GC16125@burratino> <vpqfwvqdjes.fsf@bauges.imag.fr>
	<7vsjzp9a69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBc7h-0003OM-Gj
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab0J1XnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:43:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:60698 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171Ab0J1XnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:43:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9SNdwFq022827
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 29 Oct 2010 01:39:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBc4c-0006Q1-9M; Fri, 29 Oct 2010 01:39:58 +0200
In-Reply-To: <7vsjzp9a69.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 28 Oct 2010 16\:20\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 29 Oct 2010 01:39:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160251>

Junio C Hamano <gitster@pobox.com> writes:

> Well, I was aiming for the same.  It is not the "files" but the changes
> that matter, but what we list are files.

Not only. We also list "pairs of files" in the case of a rename, and
list symlinks (which are technically files on unix, but not
necessarily seen as such by all users).

>> I second that. Furthermore, keeping it short increase the changes that
>> user will actually read the message.
>
> You could do s/Files with/With/ to shorten them.  Or perhaps
>
>     Changes to be committed are in:
>         new file: foo.c
>     Changes that will be left out are in:
>         modified: foo.c

I don't like the wording, and it would be worse in the case of
renames :

Changes to be commited are in:
   renamed: foo -> bar

Anyway, I don't think we have a problem to solve here. While the
"changed but not updated" was really confusing, I didn't see complains
about the "Changes to be committed", and I really think this one is
fine as it is.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
