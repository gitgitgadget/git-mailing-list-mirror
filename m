From: Alan Sargent <alsarg72@gmail.com>
Subject: Re: fatal: protocol error: bad line length character: GET <<<<<
Date: Wed, 26 Jan 2011 14:40:27 +0800
Message-ID: <AANLkTin2Fn4mbrrDF4ceEYQZoyGRNymsk0aouBaUp94-@mail.gmail.com>
References: <AANLkTimDbHdOwkPu6qihdgJFY0bS0XTVatLCriCmM1nX@mail.gmail.com> <20110126055955.GA13304@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 26 07:40:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phz3m-00027G-Q1
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 07:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab1AZGkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 01:40:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49489 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1AZGks convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 01:40:48 -0500
Received: by bwz15 with SMTP id 15so904750bwz.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 22:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2/5FQcidMjF8GWSQ4rlH7+Mz8YOmCpdui9GvCvZVvm0=;
        b=XpavOQ1RqVNUmAxiSSqVvrPfgFeJIe3wNOOtYYwhR3HfqYsYDwyI/I7UQn4aCx6pEC
         mJ1EXa++7Vyftx/lUReYmCV66WH5+O4aOy7cM9++T6B5ze0v8Yh11dcDsYGPRceHpkgo
         eIwJFUfDjzohDzSA3pLpKXDnbHNbHTjJfvX/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=qzclxbg1oUYyyYdiM1IRZZMW+uVUqLrG6ioYRTvAzBstI1vLSgHtMSOA9CrnAHOTPF
         FQnC768KnFEVhem0sLPUmjEnDEuknJhm11lr8u5IMfRqOcEBiNqE31GYIW2VAaRVZ2Mo
         tVavfleiyXnpjfT/eN8oVjmgX2RgZQC3Xflhs=
Received: by 10.204.119.133 with SMTP id z5mr35709bkq.72.1296024047476; Tue,
 25 Jan 2011 22:40:47 -0800 (PST)
Received: by 10.204.100.205 with HTTP; Tue, 25 Jan 2011 22:40:27 -0800 (PST)
In-Reply-To: <20110126055955.GA13304@LK-Perkele-VI.localdomain>
X-Google-Sender-Auth: zBtrgZ0GRdh4a1cbWugUYvvIkeM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165503>

Ah! Thank you very much.

:)

On Wed, Jan 26, 2011 at 1:59 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Jan 26, 2011 at 12:53:11PM +0800, Alan Sargent wrote:
>> Hello,
>>
>> The "fatal: protocol error: bad line length character" seems fairly
>> common, but in the archive and the faq there isn't reference to this
>> particular instances - GET.
>>
>> alan@toaster:~$ git init myrepo
>> Initialized empty Git repository in /home/nev/myrepo/.git/
>> alan@toaster:~$ cd myrepo
>> alan@toaster:~/myrepo$ git daemon
>> fatal: protocol error: bad line length character: GET=A0=A0<< just h=
itting
>> F5 in the browser
>> fatal: protocol error: bad line length character: GET
> [...]
>
> Git daemon serves git:// protocol, not HTTP, you can't access it from
> web browser.
>
> If you are looking for Git repository web interface, look at gitweb
> or cgit.
>
> The error is because HTTP begins the request with "GET " and git
> daemon is trying to interpret that as length of packet, failing
> and spitting out a fatal error.
>
> -Ilari
>
