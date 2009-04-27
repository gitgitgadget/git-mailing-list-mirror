From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 20:42:37 +0200
Message-ID: <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
	 <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVo1-0001IQ-U1
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759582AbZD0Sml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 14:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759579AbZD0Smk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:42:40 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:58944 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759599AbZD0Smj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 14:42:39 -0400
Received: by bwz7 with SMTP id 7so87385bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6UnPHS5O3urpBYXdhg3YXPegAVo4DCZgR5jt4BiYKSk=;
        b=B4XizoL2G+HTnFSrmFHmLMHSEyHkesREc1GUrCFc97KL6kzewqyA5Tzlx3G/V354JL
         KBCYtoUMbcHS5gxa3JWLsnrTFxz2uzROyx7ZWiJyglYrPl69dlObL5S8fNNVFrkn3mxt
         LYe3cYdnhchbJ7/uP2M/+aihGBE1IDk/qVBNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xVNtDLCjZ+oxyV/0ZiLHb/BvTwFRxEB1tSv0B91D1GUOcfXHFXN07u4HshA3KKS1g/
         R/JFlufbr5E/y1OAT9HtJuiO4HruheMaTtCt9OCcdQI0H7BfZuOcI+ovwrGi2dFnP7AM
         REW+zkWIP/GGzaHlIZIcFznxOD2anrr8NizhQ=
Received: by 10.223.104.74 with SMTP id n10mr2042370fao.5.1240857757409; Mon, 
	27 Apr 2009 11:42:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117704>

On Mon, Apr 27, 2009 at 8:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Something like this should fix it.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus

(Sorry that you're getting this mail twice, Linus - I forgot to reply a=
ll)

This does indeed fix the crash, but I find the resulting operation
quite bizarre. I'm getting a "fatal: unmatched paranthesis", however
"git grep '(('" is happy to simply grep for the double parenthesis.
Now, if I had done "git grep '\('", I'd expect an unmatched
parenthesis-error... Am I misunderstanding something here?

$ git grep '('
fatal: unmatched parenthesis

$ git grep '(('
Documentation/CodingGuidelines: - We use Arithmetic Expansion $(( ... )=
).
[...]

$ git grep '\('
fatal: command line, '\(': Unmatched ( or \(

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
