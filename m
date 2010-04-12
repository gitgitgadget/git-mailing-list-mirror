From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 11:28:37 -0400
Message-ID: <w2t76c5b8581004120828p8e1e5c49m7bcc53c8c3e68d06@mail.gmail.com>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
	 <20100410042609.GA24295@coredump.intra.peff.net>
	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
	 <20100411102255.GB20484@coredump.intra.peff.net>
	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>
	 <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>
	 <4BC3389C.4090807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 17:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1LZ7-0007xt-PG
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 17:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab0DLP2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 11:28:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42289 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0DLP2i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 11:28:38 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so46766bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WMwvokEdlU4BdUH9i2i514uzzi9HAxclzeckHuti350=;
        b=FedUirCzX1xGoSLdzvwmGTF7SKneHehEEOSMfmTLNz4rb4hQnl4XnTCsU1NR6LOzmp
         JmaI6TW158IMqz9ONMRZguAdcxW+TpHwBIfXmOV57WVYvpu5nELMOKAox7+mYzmTkAmu
         ZnYSE43hh56DRX60xzTSUYxkumrqgUEM+k+l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xug+e5/sUM7Z7/678as83gYKU8Ec+r3QjhoOuhGdXdphs87gieFTnE+Xnbq8jUFqFF
         So36CQ7AT8oqwVjLL88FaYta1kYS2bSGubx2+W1D9IReji/h/SLBZswXOjeat9bBsS2n
         MYzjG4BrypNDfdam5lcvfl3DH9gLMWHxTtVaE=
Received: by 10.204.97.202 with HTTP; Mon, 12 Apr 2010 08:28:37 -0700 (PDT)
In-Reply-To: <4BC3389C.4090807@viscovery.net>
Received: by 10.204.34.81 with SMTP id k17mr4938865bkd.78.1271086117675; Mon, 
	12 Apr 2010 08:28:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144741>

On Mon, Apr 12, 2010 at 11:13 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 4/12/2010 16:09, schrieb Eugene Sajine:
>> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
>> $ git rebase master
>> Current branch topic is up to date.
>> <=3D=3D=3D=3D=3D=3D=3D Really? Topic is actually based on next =E2=80=
=93 what does this "up
>> to date" mean??
>
> Why should rebase bother? The difference between master and topic are
> *two* commits. Since these two are already on top of master in linear
> history, you get no advantage by doing a rebase operation. Therefore,=
 you
> see "already up to date".

You lost me completely...
Rebase means change the base of the commit, change the fork point.
Current fork point for topic is next. I want it to be master. What is
up to date here???
The message is poorly worded for sure.

I know that the form i have to use is:

git rebase --onto master next topic

but it is just because topic is not direct descendant of master, isn't =
it?


>
>> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
>> $ git rebase -i --onto master topic
>> Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=
=80=93 here it
>> printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it =
should do nothing,
>> but it still did something and I double checked it.
>
> Not a bug.
>
> Your command is the same as
>
> =C2=A0 git rebase -i --onto master topic topic
>
> because you are already on branch topic. Since there are no commits i=
n the
> range topic..topic, rebase -i told you "noop". This word is perhaps p=
oorly
> chosen, because it does not mean "no operation"[*], but "there are no
> commits to transfer". But branch 'topic' that you gave as the last
> argument (or implicitly by being at branch 'topic') is still transfer=
red
> --onto master. This explains the result that you observed.
>
> Of course, if you do not 'reset --hard topic@{1}' at this point, you =
will
> ultimately lose the commits on branch topic.
>
> [*] You can get "no operation" by deleting the line "noop".
>
> -- Hannes
>

Come on! Please, please, explain me why it behaves DIFFERENTLY:

esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase --onto master topic
=46irst, rewinding head to replay your work on top of it...
fatal: Not a range.
Nothing to do.
                <=3D=3D=3D=3D=3D=3D=3D=3D topic..HEAD is not a range, a=
greed


esajine@ESAJINEWWW /c/git_repos/test2 (topic)
$ git rebase -i --onto master topic
Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=80=
=93 here it
printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it sho=
uld do nothing,
but it still did something and I double checked it.


Thanks,
Eugene
