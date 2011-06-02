From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 11:38:53 +0100
Message-ID: <BANLkTikTi7nryTsyNV5incW3TxaOROyzMw@mail.gmail.com>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
	<20110602103259.GA30081@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 12:39:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5Is-0004Xh-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933458Ab1FBKi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 06:38:56 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59231 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933431Ab1FBKiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 06:38:54 -0400
Received: by yxs7 with SMTP id 7so269873yxs.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=b4OWjxIEk69k9pa4w0wK6P5/gl9ewSI5izP2emy/pyU=;
        b=QjV7QZxjq6AYb+O9+D6zmGdMNcJMu97gi4SpSdJ0P4V3TNr2jIwvl5iueaP8UK7VC1
         2le4SO2+PkuuPsECEQTKtglQRw8MHNYSPIdFCrBYc45jp5SNuWSy8ZuSz/O5xdBarFaT
         pLq/4+riFKLXeBwl988t1fU5GnXW3e+J6L2iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=orKtLcMT8APYuGsU5A4EQpwdTZ7/mzIj34sseUl0KVZSNIlAMMBb++YNq1gteduFe1
         AciYBdk+1Y2QvTVKqMHN7a4c/Zyc6NFZB53Nayobrbzok7Wo22swxh+8A4pBJKSAOUie
         IOLQUqkqs/Zkhia59yzEeBi28OZ3dH4vGGPxE=
Received: by 10.90.249.30 with SMTP id w30mr528026agh.3.1307011133309; Thu, 02
 Jun 2011 03:38:53 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Thu, 2 Jun 2011 03:38:53 -0700 (PDT)
In-Reply-To: <20110602103259.GA30081@centaur.lab.cmartin.tk>
X-Google-Sender-Auth: _9qHCskFJ--gwBFjIu9HozgehDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174938>

On 2 June 2011 11:32, Carlos Mart=EDn Nieto <carlos@cmartin.tk> wrote:
> On Thu, Jun 02, 2011 at 11:17:41AM +0100, Howard Miller wrote:
>> Trying to explain this as concisely as possible.
>>
>> I started with the following branches (names changed to protect the =
guilty)...
>>
>> * clientA
>> * clientB
>>
>> both have a common ancestry....
>>
>> I then checked out clientB created a new branch clientB_patch and di=
d
>> a load of work and commits.
>>
>> However, I actually wanted all those commits to apply to clientA
>> branch instead so....
>>
>> git checkout clientA
>> git checkout -b clientA_patch =A0 =A0 (to ensure I didn't wreck orig=
inal branch)
>> git rebase --onto clientA_patch clientB clientB_patch
>
> The man page for git-rebase covers this exact situation (around line
> 88 in my version) . In its case, it's
>
> =A0 =A0git rebase --onto master next topic
>
> which translates to your case as
>
> =A0 =A0git rebase --onto clientA clientB clientB_patch
>

Thanks. That's what I said (except I added an extra branch onto
ClientA because I interpreted the instructions - wrongly - to say that
ClientA would change).

However, I've just realised the bit I missed. I still need to do a
(fast forward) merge to get my ClientA_patch branch to actually
reflect the changes. I can't help thinking that (although the diagrams
are perfectly correct) that a line to the effect in the manpage might
have saved some thinking time :)
