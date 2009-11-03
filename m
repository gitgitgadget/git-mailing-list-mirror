From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Problem signing a tag
Date: Tue, 3 Nov 2009 08:31:25 +0100
Message-ID: <81b0412b0911022331q2976b6e6u575a9700b212623d@mail.gmail.com>
References: <200911021558.17550.joshua@eeinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joshua J. Kugler" <joshua@eeinternet.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5DrZ-0007kD-Oi
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 08:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZKCHbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 02:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756062AbZKCHbW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 02:31:22 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54207 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbZKCHbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 02:31:21 -0500
Received: by bwz27 with SMTP id 27so7222186bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 23:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RL++XJQiAxLKtXOcJOv5poO9o4kumy1qsbDZsrI1F2w=;
        b=aZO2+SB2GLad5/34z5FNRFoJnLhdTWbJxnt56J6O6LpgRxhYpAKZzOBHjrg25Csb2h
         YBesjI7eGWiuc3Vq3XS0It1cJlE817+6fIhNG41D6UTJFf3xOlKKJ836z8eXgAF2eNVz
         TWStykaqVxoSVlpGWZHpVlS6fuQCV9eoBV6aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ncfyPmTyGTEYeXl91LcPfXuYl+9OwH5Hm5jq0IwtJeic4umm+ZXN+IcM1Sneb4rnNk
         c7pe/UcvAHJYmAvg4leyZNFHQ76eqcRgJfUar4/JYfjLMFaW9uULoGAyr4u4o+vdfDHS
         0ZGTfAIcIXTbOSEfcrQG42ZqSajjfm9MbppwM=
Received: by 10.204.34.20 with SMTP id j20mr4623480bkd.57.1257233485637; Mon, 
	02 Nov 2009 23:31:25 -0800 (PST)
In-Reply-To: <200911021558.17550.joshua@eeinternet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131950>

On Tue, Nov 3, 2009 at 01:58, Joshua J. Kugler <joshua@eeinternet.com> =
wrote:
> Nobody on the git IRC channel responded to this question, even after
> asking it a few times, so I thought I'd try here.
>
> I'm having trouble signing a tag. =C2=A0I'm using this command:
>
> git tag -u EAFD344D14EA086E -F .git/TAG_EDITMSG tag_name
>
> I type in my passphrase, and am then told:
>
> error: gpg failed to sign the tag
> error: unable to sign the tag
>
> However, if I use this command:
>
> gpg -s -u EAFD344D14EA086E
>
> and use the same passphrase, it works fine. Is there any way to find =
out
> why a key-signing is failing?

What does "echo $?" after it prints? IOW, maybe plain gpg fails too,
without printing anything special, and you don't pay attention to the
exit code. Git does. And it runs "gpg -bsau <key-id>".
