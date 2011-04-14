From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Thu, 14 Apr 2011 15:50:53 +0200
Message-ID: <BANLkTin6=b9E=2gBjsWd+Y9Fg-APR1xOgw@mail.gmail.com>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
	<BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 15:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAMwm-0007hl-4y
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 15:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798Ab1DNNuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 09:50:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab1DNNuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 09:50:54 -0400
Received: by vws1 with SMTP id 1so1284517vws.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DL7vXHZSVw1ou8Vp4NUKVaactVrt2rXZKEy7/bU7mEM=;
        b=AOBwREZw9I3rfyaNT1yTnnxVEGb0OF8jhZp2PQw8MqdBsR7zFZgfC2cZDGA0e+aN1g
         K7IeGp25fASCgDoHpJsAhnj6h4P35vUio5oxgw+GaEhFOZqtlvFKYd97jQ2vj+prDraQ
         rU+OaMm1zrQYslQpY5W/8MIi1mM8pUN0W2icY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LYx+7nUVHgvqXzFDE44TM56w45SYVgE4w43NAoBFJFIaAY8wuFnoCln8LZgstKK8nO
         Gezmpp9ZXu7hhO7PH/QEEaHcqhB490Q0deTSAmbjd7LNpRHMTNt9i76g6umRbufZ627r
         Fq8LkaeMBcebhAYW0AENvJ1xX/DwW1hYhULbc=
Received: by 10.52.75.231 with SMTP id f7mr1092745vdw.158.1302789053459; Thu,
 14 Apr 2011 06:50:53 -0700 (PDT)
Received: by 10.220.180.202 with HTTP; Thu, 14 Apr 2011 06:50:53 -0700 (PDT)
In-Reply-To: <BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171516>

On Thu, Apr 14, 2011 at 3:38 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> On Wed, Apr 13, 2011 at 12:43 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> * mh/git-svn-automkdirs (2011-04-01) 1 commit
>> =A0(merged to 'next' on 2011-04-03 at 7fa4978)
>> =A0+ git-svn: add an option to skip the creation of empty directorie=
s
>>
>> Should be safe, but I'd like an Ack from git-svn folks.
>
> I wanted to test performance of this change - what's the best way to =
do it?
>
> I tried some ideas, but rebase was too fast for performance measureme=
nts.
> I did not have new commits, but just some old, already in trunk chang=
es, which
> I tried to rebase - probably it was just fast forward?

I found some old not-yet-rebased branch (with 3 commits) and tried reba=
sing it.
I saw no time difference - maybe I'm doing it wrong?

I did following for both true and false config setting:

git checkout -b test_rebase old_branch
time git svn rebase
git checkout master
git branch -D test_rebase
<repeat>

Results I got:
13.7s 13.4s 13.6s (config: false)
13.6s 13.6s 16.6s (config: true)

The last "true" result is higher because rebase had to fetch one new re=
vision.


--=20
Piotr Krukowiecki
