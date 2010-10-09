From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 01/10] cat_file: take -i/-w parameters
Date: Sat, 9 Oct 2010 22:57:02 +0200
Message-ID: <AANLkTinfMQ0OpqEfY7gVRU_CofxkV+SXiruMndKq+s3-@mail.gmail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
	<20101009203219.GN29673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:57:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gTg-00087Y-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab0JIU5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 16:57:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39349 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112Ab0JIU5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 16:57:03 -0400
Received: by iwn6 with SMTP id 6so1739180iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iyJEAp8agKUcadGZwgh3xMjg6NlnMQM55DP6xZi7hO0=;
        b=pJ0I7JAwlHGBsNpqwREtJvpfvc+sqyKMc5sYebN6iWAtTzq81EBgjEzluTzRAxahW4
         uUjQgVH+DnC3ALBwieHrHdW8e5ryydsX7KIjvFXg+024aqup+vzmd0cCGMDVbyGYQtsE
         HdbqEViIBmxHfClFsIGFxAPyuhRYgp2NCs8XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UCHjl3sPzmMukW2Uzid/xuijR3LUKp8IHVjqcfj+IOz4YIO1CBrd6dQPtsT8zHPPWx
         0HMB7SeMAMr+7Si76oRCGU5oEC+CiL4h18nzn+A/TQUcrY8hDmKMK7mkovf0pg9iq5u5
         vDPkbwYasMchsIXDSTRq6CxCww9Nw1lBSDwUg=
Received: by 10.231.157.195 with SMTP id c3mr3515966ibx.155.1286657822103;
 Sat, 09 Oct 2010 13:57:02 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sat, 9 Oct 2010 13:57:02 -0700 (PDT)
In-Reply-To: <20101009203219.GN29673@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158610>

2010/10/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
> On Fri, Oct 08, 2010 at 09:57:59AM +0200, Bert Wesarg wrote:
>> This changes the way how cat_file selects the source of the file. It
>> accepts an optional parameter which is either -i or -w and will reac=
t on this
>> instead of the branch name. tg-patch is updated accordingly and can =
now
>> accepts the current branch name as argument with -i or -w given.
>>
>> cat_file was also broken for the worktree case when we are not in th=
e top level.
>>
>> Also, tg-patch allowed to be on the top-base branch, but -i and -w d=
oesn't
>> make sense there too.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> doesn't apply anymore. =C2=A0Do you care to fix and resend? =C2=A0I t=
hink it's
> your own change to cat_file BTW ... :-)

Right, Sorry. I should have done a git fetch. Will resend now.

>
>
>> ---
>>
>> I will probably never understand why TopGit accepts to be on a top-b=
ase branch.
> /me shrugs.
>
>> I will probably never understand why TopGit not changes the cwd to t=
he top level.
> I can imagine that strange things can happen then, but I don't have a=
n
> example.
>
>> I will probably never understand why TopGit does not use the git-sh-=
setup.sh.
> I'm not sure this works in all cases. =C2=A0And I think it's not sens=
ibe as
> we don't have control over this file. =C2=A0And what if it starts pro=
viding a
> function with the same name as one of our's?

It does already: die.

Regards,
Bert

>
> Best regards
> Uwe
>
h
