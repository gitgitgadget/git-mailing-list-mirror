From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Thu, 4 Nov 2010 10:35:11 +0100
Message-ID: <AANLkTin1R8+N=TG2fhc1UdzT6G65JB1awrw+Q8xY7uBA@mail.gmail.com>
References: <loom.20101104T014408-903@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: MDellerus <mdellerus@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwE2-0005N9-Rq
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0KDJfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 05:35:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54062 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0KDJfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 05:35:12 -0400
Received: by fxm16 with SMTP id 16so1258180fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kaxWm0vkhCRRIdNQlyaY9Z25Obxytix5XmxIqnd8U7I=;
        b=qdees8/1OuWq8UxNa26Pv4wQLRrmn1qLnqMlw9dXclHo8z9b4vjPB+Goz5fYLSVfG6
         CNIG1Crl50eCsSLVfGIq61cf8qT3fGBBBS/F9ybB4HkMxA+m6YlD25oKeYAT7JKh9f9N
         KUewZ8K3rO6iQD5gMHaXJFLaP6Cd+N7BYFdMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dZZHUJTSk3DRkIb+1GqP8ffcWefYHJW1mkE0hjrEWQDg5vp8qoNcPRIMdVzrOunMmi
         MW1K/CRFkBfIcdURvJNAyv/+tVhxFEyohQvhO6OyW8BFOoYSZqwpJXl/zmJFguXxRLX+
         f/CCLqXsa8CqceAwV5R8yQYp1Zz0kkR+ZGA+I=
Received: by 10.223.115.203 with SMTP id j11mr425534faq.35.1288863311203; Thu,
 04 Nov 2010 02:35:11 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Thu, 4 Nov 2010 02:35:11 -0700 (PDT)
In-Reply-To: <loom.20101104T014408-903@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160705>

On Thu, Nov 4, 2010 at 01:45, MDellerus <mdellerus@yahoo.com> wrote:

> I have a co-worker who has suggested that, using "svnadmin hotcopy",
> subversion can be just as "distributed" a system as Git
>
> While I see how this can be done, it hardly seems to me to qualify as=
 "just as",
> making this "plausible" at best.
>
> Can anyone give me a quick confirmation of this? =C2=A0Confirmed? Pla=
usible? Busted?
>
> If this is confirmed or plausible, could someone give me a quick run-=
down?

The problem here seems to be that your coworker took "distributed"
literally.

When we talk about "distributed version control systems" we don't just
mean that the raw copy of the complete revision history is
distributed (although that's also included).

If that was the case packing up the ,v files on a CVS server or
distributing a "svnadmin dump" would give you that FTP-archive-like
distribution.

"Distributed" means that you can easily share the complete revision
history with yourself/others and *put it back together again*. E.g. a
workflow I had yesterday was:

 1. Clone a "master" repo
 2. Hack it on my laptop, thinking it worked
 3. Push my revisions to deployment server #1, made & commited some hot=
fixes
 4. Synced those to deployment server #2, made & commited some more fix=
es
 5. Synced those back to my laptop
 6. Synced them back upstream

If a workflow like that isn't any harder than commiting to one
"master" repository you have a distributed system. You *could* do that
with SVK using some massive hacks, but it would quickly fall down when
you have multiple parties with diverging histories that you need to
join.
