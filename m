From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 10:20:28 -0400
Message-ID: <CAA3EhHKORv3n9b4Ln1L36_ETZVjEqrZeutKiK0ML=u3ecrqJ0g@mail.gmail.com>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
 <877gvgrxw7.fsf@thomas.inf.ethz.ch> <20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr>
 <87haujr15p.fsf@thomas.inf.ethz.ch> <20120610114615.Horde.Sp1YK3wdC4BP1GznJuNzcNA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 16:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdj0g-0003G3-8x
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 16:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab2FJOUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 10:20:49 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56945 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab2FJOUt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 10:20:49 -0400
Received: by vcbf11 with SMTP id f11so1701815vcb.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Sm13RCYlgp5wRO7I67pdnyIM8Uc7EKSCzJxVw2RvcfA=;
        b=g4S1d8lmj3iGzrYhnchSdiF7wwDS5j2jtMLMJ0fNToDUWzB5VHmDfSwdjwbMWM1K5a
         oalExDywzhZFKoXVsTVZCvwYn7dz7mZfP7CAz3T5SQz8GnhiS8PoFLmJoCBkptUWonSp
         H4nusSRB+k+eHpAEMwnZiuNh6gn5ruHj5g0sgf8M/CIvo/AnuGonXiTyQjsOxjJJsT8z
         /RTb6WQp9XRIMnHiDMPVxT6dcn4klcHZUTNcGtCBaujUJNAmqsZf7h6y0FttupY1pAVJ
         y1dJG3kUarTAPxLqoZXxqqK/jF35DX4RXdHqtMMI9+xYBNvQKGVi4Eays7tvjCglDvCb
         kNHg==
Received: by 10.220.223.144 with SMTP id ik16mr10703617vcb.36.1339338048361;
 Sun, 10 Jun 2012 07:20:48 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Sun, 10 Jun 2012 07:20:28 -0700 (PDT)
In-Reply-To: <20120610114615.Horde.Sp1YK3wdC4BP1GznJuNzcNA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199605>

On Sun, Jun 10, 2012 at 5:46 AM,  <konglu@minatec.inpg.fr> wrote:
>
> Thomas Rast <trast@student.ethz.ch> a =E9crit=A0:
>
>> =A0- We avoid using braces unnecessarily. =A0I.e.
>>
>> =A0 =A0 =A0 =A0if (bla) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D 1;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 is frowned upon. =A0A gray area is when the statement extends
>> =A0 over a few lines, and/or you have a lengthy comment atop of
>> =A0 it. =A0Also, like in the Linux kernel, if there is a long list
>> =A0 of "else if" statements, it can make sense to add braces to
>> =A0 single line blocks.
>>
>> I'm not the one who wrote them, but I'm taking the last sentence to =
mean
>> that you should not put the braces unless the omission will break th=
e
>> vertical alignment of the 'else if' chain.
>
>
> I agree with you and that's what I thought. Still
>
> Junio C Hamano <gitster@pobox.com> a =E9crit :
>
>> Two points on style (also appear elsewhere in this patch):
>>
>> =A0 =A0 =A0 =A0if (!"applying") {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state->rebase_in_progress =3D 1;
>> =A0 =A0 =A0 =A0}
>>
>> =A0- "else" comes on the same line as closing "}" of its "if" block;
>>
>> =A0- if one of if/else if/else chain has multiple statement block, u=
se {}
>> =A0 even for a single statement block in the chain.
>

I'm happy to produce a patch to update the documentation if there is
consensus to avoid using braces unnecessarily for if statements with
one line, but not in the case that there is {} used in a if/else
chain. Thomas, Lucien, are you on board?
