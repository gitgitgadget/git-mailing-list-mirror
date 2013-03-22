From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Fri, 22 Mar 2013 13:53:23 +0530
Message-ID: <CALkWK0kHFHtsy1Eh+jnY-JNSDUYd2xtiavhPNjaT8H3mJvYZkA@mail.gmail.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com> <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 09:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIxGo-0005jk-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 09:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112Ab3CVIXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 04:23:45 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:60477 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3CVIXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 04:23:44 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so3326538iag.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/Ax4gcyUS175U79OBmXkK1OIKWgRD2yNoD7IO7NG5h8=;
        b=wfPwdgSTqw23xb+/8Ln4A8ageWepVw1jSKEIcwwFLLjl8nWaCOtXJ6KMUE9pqi6GmL
         xHtQn6xSHjOof9xb+DyoVXA9F2GEX4TpZy2ZQ/ajlZ30of5M1diLeED9AcC4TxOYKi75
         luzzxhcnplFmz6dc6a2oGGanvD3aWmfwixNPbdjHbxeNcHagBBsbR8DN7bsJ4y8bGV8L
         OVt1YF2EhQrHXe/xVBk+WbkGThNohO53Rpq7kmj2d/f479gpgzyibp1Hp3SN4Dbi9Sad
         m1Ke683O7MZntPglcuAvdsqdeeJ7fPFRB/SgRO1yEKx4NMqvFpnR2O7jUNuhJk1C6eXy
         /1DA==
X-Received: by 10.50.119.102 with SMTP id kt6mr603886igb.12.1363940623403;
 Fri, 22 Mar 2013 01:23:43 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Fri, 22 Mar 2013 01:23:23 -0700 (PDT)
In-Reply-To: <7vsj3pdcm5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218785>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Andrew Wong wrote:
>>> On 3/19/13, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>>> I know that this is expected behavior, but is there an easy way to get
>>>> rid of this inconsistency?
>>>
>>> You can actually rely on "rebase" to run the appropriate command.
>>
>> Didn't Junio explicitly mention that this is undesirable earlier (from
>> the point of view of `rebase -i` design)?
>
> I am sure it is my fault but my memory fails me.  As Andrew
> mentioned, "rebase --continue" seemed to get this right.

After digging through the list, I did manage to find Junio's original
message I was referring to [1].  This, along with other discussions
has resulted in a sequencer with the Right (TM) design.  I know I've
brought this up several times before and that it has gone nowhere, but
I'd really to have that final 'git continue' in Git 2.0.  Can someone
attempt to break up the migration path into manageable logical steps
that we can start working on?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/179304/focus=179383
