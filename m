From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git status internals and line endings
Date: Fri, 13 Nov 2009 10:04:43 +0100
Message-ID: <40aa078e0911130104v6acdecedxf629c5ef35a62740@mail.gmail.com>
References: <4AFC70CE.5020106@syntevo.com>
	 <20091113001547.GB28836@sigill.intra.peff.net>
	 <4AFD1414.6030907@syntevo.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 10:05:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8s5e-0002gd-M5
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 10:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbZKMJEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 04:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbZKMJEk
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 04:04:40 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44740 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbZKMJEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 04:04:38 -0500
Received: by fxm21 with SMTP id 21so197880fxm.21
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Z2nLX14qXqy6pgUHvPX1UpojKoTalWbjtUSvHt59YLo=;
        b=GW+sjdSh6rZPq3LN+c7xDJGomIE3fjK2JepTeUPqyrI5ZaxRrAfsvIBynKyRVmX9dJ
         T1zOHXe1Ug+xB+oJOQuW7aByV4YThvOdtnjhA4oHLmdcf3BPBvn1EKvAbKtH2SqRe6K4
         Y6jOU8pBIQd9x3gc61S9D70kd4vYkA49CMB5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=b71tIgrnD704kff/j+iX7jclSCHXobD+HXVtQnvwO4s/ZW7gPuzcCTiVB9Z7kQsnDV
         8rgrZ4Tdo1FEWTC6wMboespNAQWQvto8CCAE7dX/RXv1QgHz4faySG0PBGQ4Ex4jSdvE
         rO0X4nySjPgQtc8heqUOZaasf5SlOGcHFbPs4=
Received: by 10.216.86.193 with SMTP id w43mr1288855wee.17.1258103083550; Fri, 
	13 Nov 2009 01:04:43 -0800 (PST)
In-Reply-To: <4AFD1414.6030907@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132826>

On Fri, Nov 13, 2009 at 9:08 AM, Marc Strapetz
<marc.strapetz@syntevo.com> wrote:
>> Sounds like the core.autocrlf setting (see "git help config"), which I
>> believe is set by default on Windows.
>
> I have checked both $GIT_DIR/config and ~/.gitconfig and autocrlf has
> not been set. I have then set autocrlf = false for the Windows
> repository and still the file didn't show up as modified. On Linux, I've
> added autocrlf = true (resp. autocrlf = input) for the repository and
> still the file shows up as modified. Not that I don't like this
> behavior, but I don't understand it :) Windows Git version is 1.6.5.1,
> Linux version is 1.6.3.3.
>

In order to make changes to core.autocrlf effective, you need to
delete .git/index and perform a hard reset:
$ rm .git/index
$ git reset --hard

Did you do this before checking if the files were modified?

-- 
Erik "kusma" Faye-Lund
