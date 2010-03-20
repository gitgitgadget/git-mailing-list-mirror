From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command 
	line
Date: Sat, 20 Mar 2010 10:17:06 +0100
Message-ID: <81b0412b1003200217m39c79418w54ac0735e8e6405a@mail.gmail.com>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
	 <7vmxy4kss9.fsf@alter.siamese.dyndns.org>
	 <fcaeb9bf1003200209r6051f906kf2a0a1e96752845e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 10:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsuo0-0007uO-Fv
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 10:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0CTJRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 05:17:10 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40402 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab0CTJRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 05:17:08 -0400
Received: by bwz1 with SMTP id 1so615715bwz.21
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ERTe+Uf14dw7vs5veVvxmCRgytrsX18XJQLpWtKKA08=;
        b=olc+A5s4fRLkipg3F5257Ptg5sQ9OMMwmbo9m7cUXM0PzK5ymNfCjHBV8qIz3mx2cD
         0BroaRP/siDiWw1/mQ0wJ2hWunTrgW9fKzNwlnRQQWcT2wQ+PtVGYIm460V038psyyYH
         XMYD0kGih6SGOg6rpC3Cs/jbt892CO+OotzNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JDX+UE11vjf6OCjlNVwwAimsqMsKLgfOpkEtxBvTr8rz2021UwouGdpRjYSuyek2Pv
         1lqaKdlMLDjy/nLsumw6lEWob3vH/S8PqkMZDNVt6a0UbSlQHkRERXguBCCjadctdoH6
         Rsq19jvbKcqJPGX/Hu55sYeqMdjP5hCymhTo0=
Received: by 10.204.9.152 with SMTP id l24mr3057214bkl.193.1269076626344; Sat, 
	20 Mar 2010 02:17:06 -0700 (PDT)
In-Reply-To: <fcaeb9bf1003200209r6051f906kf2a0a1e96752845e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142697>

On Sat, Mar 20, 2010 at 10:09, Nguyen Thai Ngoc Duy <pclouds@gmail.com>=
 wrote:
> On 3/20/10, Junio C Hamano <gitster@pobox.com> wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>> =C2=A0> The values passed this way will override whatever is defined
>> =C2=A0> in the config files.
>> =C2=A0>
>> =C2=A0> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> =C2=A0> ---
>> =C2=A0>
>> =C2=A0> Someone wanted to have this once. I accidentally remembered
>> =C2=A0> that when I wanted to temporarily set some config parameter
>> =C2=A0> (format.suffix?). From looking at code it seemed simple enou=
gh,
>> =C2=A0> so I did it.
>>
>> How does this interact with core.worktree and the setup sequence in
>> =C2=A0general?
>
> To me it looks like another config file to the config stack. No thing
> can go worse (except that if you have core.worktree in
> $GIT_DIR/config, now also specify -c core.worktree=3Dfoo, then
> core.worktree code would be called twice).

Yes, that's why I said the whole thing is not very friendly.
To an experienced user it will be expected, though.
