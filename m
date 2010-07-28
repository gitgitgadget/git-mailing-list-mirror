From: Tong Sun <suntong@cpan.org>
Subject: Re: Recommended work flow with git to send in patches
Date: Wed, 28 Jul 2010 18:40:06 -0400
Message-ID: <AANLkTikkXQNiaagPGN5cYCDg6hfvojpLcEePWF6UbUDV@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<m3y6cwkew7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 00:40:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeFIM-00034Z-Lm
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 00:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab0G1WkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 18:40:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55137 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0G1WkH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 18:40:07 -0400
Received: by yxg6 with SMTP id 6so1171846yxg.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oiqUaRwe/lTngsCXejC4ECs1Alba15t/hrXLAuaOrDo=;
        b=e8wl1JbSvU3eQ+J2uZaI8cIfvrpuW3KR7dDKJIQBO9WRoMwO4CC8M0Y4CK2qb+0wlt
         H/ERmcD6IxMSo5Ds7BnZNeRxgAnu68I5JIsR4TfksTDwsdl5pwwGmDTx40kGe6ziETai
         G2S+6gXhXOzsz0Ciu1C3QUc8q0tKC2va7kJYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Gv+9s6KSCEwnlzcN2b6E2XO3kScSCygCIffKzEgMkpT0D7Q6FNgH8Q7vjxOTl15xFc
         7toLOh1AmOS7HSl5qdb2xjgLgu4l0RRvWyXTLgYRp4Nhl3G/G5eue1Cdjgj8/skIkj9F
         VT0Vw/9EmiXLL8T1Wg4XQAvZ02BdIz1w670Ro=
Received: by 10.150.62.7 with SMTP id k7mr4375689yba.269.1280356806856; Wed, 
	28 Jul 2010 15:40:06 -0700 (PDT)
Received: by 10.229.233.206 with HTTP; Wed, 28 Jul 2010 15:40:06 -0700 (PDT)
In-Reply-To: <m3y6cwkew7.fsf@localhost.localdomain>
X-Google-Sender-Auth: DtmibeRnFxh61OcKWViLhZu_J3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152125>

On Tue, Jul 27, 2010 at 1:35 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:

>> First of all, philosophy for version control with git:
>>
>> . While developing, small/independent commits are good thing, so tha=
t
>> =A0 it's easy to decouple different changes.
>>
>> . But when integrating something in a main branch, commits should co=
ntain all
>> =A0 logical/related changes.
>
> I think that in final results, i.e. in patches that you send, or
> commits that you send pull request for, you should have commits that
> do one thing, and do it completely and without breaking. =A0Neverthel=
ess
> having small commits that you publish / send to maintainer is a good
> thing; it is always easy to review a few small patches, than one
> mage-patch.

Yeah, that's actually exactly what I believed before getting feedbacks
from grml developers for squashed patches. It's an interesting topic
to me, so let's dig deeper into it.

Say that I need to add a feature to a CLI program. I would
instinctively divide it into 3 logical steps/patches, 1st to the user
interface (the command line handling), 2nd to the implementation, and
3rd to the document.

Do you think 3 small patches is the way to go, or a single patch is,
since all 3 are logically related?

Now back to our topic, thanks for your work flow explanation, I'll
answer/ask in this single message.

> Why not git-clone (possibly shallow, if you are working on one-shot
> patch or patch series)?
>> Ok, to explain it, I have to touch upon my "life long story" of usin=
g
>> git.

> I don't understand this second step.  Why do you want this second clo=
ne?

That's what I searched and found from the Inet when I was looking for
the recommended work flow, which was to do 'git clone' from web once
then 'git clone' several local working copies to work on several
independent unrelated features. Now I know creating my own local
branches is the way to go.

> If you plan to continue working on this repository, and it is not
> one-shot patch or patch series, it would be better (easier in the
> future) to use "git remote add".

Could you elaborate more on this with git commands please, so that I
can have a full picture?

Thanks again for your clearly explanations, I think I don't any
further questions for the moment.

cheers,
