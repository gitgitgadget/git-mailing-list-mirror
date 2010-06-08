From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 14:28:16 -0300
Message-ID: <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 19:28:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM2bA-0000vp-6l
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 19:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab0FHR2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 13:28:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45985 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0FHR2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 13:28:18 -0400
Received: by bwz11 with SMTP id 11so1241071bwz.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BdKF8fYWGbhrMqWGTOIBlUEfZSOxmj/x0+gn9ywLHH0=;
        b=VXNIALoH2tsXD8Oz9oxXvz9hlEvPDsUgx8rlKzEjbDR0FKWck/GbFHjkBnC8knjwO6
         LKec3cpUvmVXJQ8YTHa7MmD9sEhfPRAfUtWSGT9aBFobpBa7FPrl4WnH3DM1ExPVWOBP
         +NDiDWauz0B4UU9WT5ynyaaHBambvC5wCFfRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PQunLYO3XhbHJft1DKN18w9IJucM1+DljbKAKSE1HsqkGcMtlKE/YSzRT8DUpmjPHz
         DbQrd90xFUPLzXz+RfPIdEa3EHrD0vavOAA8EHvwJTDQL37gsRnKcINvxxT9AOO82aU2
         nzm/TaGNFMPZYjsXSc5U82i3hp/H+GKMcb3Q4=
Received: by 10.204.33.88 with SMTP id g24mr111973bkd.186.1276018096387; Tue, 
	08 Jun 2010 10:28:16 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Tue, 8 Jun 2010 10:28:16 -0700 (PDT)
In-Reply-To: <4C0E6810.3070301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148694>

On Tue, Jun 8, 2010 at 12:56 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 08.06.2010 16:39, schrieb Dario Rodriguez:
>>
>> On Tue, Jun 8, 2010 at 11:17 AM, Johannes Sixt<j.sixt@viscovery.net>
>> =A0wrote:
>>>
>>> =A0$ GIT_PAGER=3D/is/not/there git log
>>> =A0$ echo $?
>>> =A0141
>>>
>>> That's SIGPIPE, just as I would expect.
>>
>> As I said in the original thread...
>>
>> $ PAGER=3D/nothing/here ../git log
>> $ echo $?
>> 0
>
> That's no surprise with your toy repository: git-log has run to compl=
etion
> (without overrunning the pipe buffer) before the pager process that i=
t
> forked can even execute its first instruction.
>

I cannot understand what's the point... I'm running git without
installing it, but why do you say "toy repository"?...

>> btw: I still think 'more' is much more sane fallback default than
>> 'less'... look (with your patch applied):
>>
>> $ ../git log
>> error: cannot run less: No such file or directory
>> commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
>> Author: #######<#######@Maquina01.(none)>
>> Date: =A0 Thu Jun 3 20:02:23 2010 +0200
>>
>> =A0 =A0 OtherCom
>>
>> commit acf110f7c878a37e4a5af8499134df28da0e8ab3
>> Author: #######<#######@Maquina01.(none)>
>> Date: =A0 Thu Jun 3 20:01:37 2010 +0200
>>
>> =A0 =A0 inicial
>>
>
> How is this an argument for 'more'? (Just asking; I don't see your po=
int.)
>

No problem, let me explain: 'more' is older and standard while
(correct me if not true) 'less' is not in POSIX:2008. I work in a lot
of Unix-like systems and I found 'more' as a standard, while less is
just sometimes installed... my error running 'less' is such an
argument for 'more' because:

$ PAGER=3Dmore ../git log
commit fccd640197e34dbff72954924ed5c76c42a4aac7
Author: ###### <######@Maquina01.(none)>
Date:   Tue Jun 8 19:23:23 2010 +0200

    commit
stdin: END

'more' is not a problem... and as a POSIX standard it's almost never a =
problem.
