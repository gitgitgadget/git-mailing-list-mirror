From: Kevin Leung <kevinlsk@gmail.com>
Subject: Re: [PATCH] git-p4: Fix empty submit template when editor fires up
Date: Sun, 10 Jan 2010 21:52:53 +0800
Message-ID: <e66701d41001100552p6cf2fde8m6463613cfcc4315b@mail.gmail.com>
References: <1262235876-1239-1-git-send-email-kevinlsk@gmail.com>
	 <20100110111153.GA19612@progeny.tock>
	 <20100110111440.GB19612@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTyE1-00088q-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab0AJNw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 08:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155Ab0AJNwz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:52:55 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:42875 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0AJNwy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 08:52:54 -0500
Received: by gxk3 with SMTP id 3so9712983gxk.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vv4OXLgm2/4boR2QcLYS66Dw/peHBoNczgHm364S/kI=;
        b=K8tXJotmod7dpgk0Pykae+1HNqTneBwhZjw2BPQGiKiUtSW88A8WvRGnOI4WE/OJlV
         dUWCEqHq6uCB/lH302kJq+BIGYyccWGJtHncxBHQgZ89dGUzZlHJhurYgrBOOTPOyKry
         fNI6ylgJIS5B7YuRojAFCughs1SeENsYm0fK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hm030OSIA3VzhcOmNELPKTEd8J/gYEeD42HI2RN9AoNSdy+mAzl5n5YDVwvqnlFXAW
         Tt+BR6JnpINJaHIarL2qvPoxcJZouaAwaw9JM/ZdoHewhXTJudfLJhesQHw7O/ymKxup
         +5EGNgrt7mCx2hIE1J9UWhobfRUPkj4iP5nFg=
Received: by 10.91.196.4 with SMTP id y4mr10133561agp.107.1263131573640; Sun, 
	10 Jan 2010 05:52:53 -0800 (PST)
In-Reply-To: <20100110111440.GB19612@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136581>

On Sun, Jan 10, 2010 at 7:14 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>> Kevin Leung wrote:
>> > read_pipe() returns "\n". We need to remove it before passing it
>> > to system().
>> >
>> > Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
>>
>> If I understand correctly, this is a cosmetic change:
>
> ... and of course I didn't the subject. =A0Sorry about that. =A0Thank=
s
> for cleaning up my mess.
>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
>> What is the rationale for the rewritten system() line? =A0I would ha=
ve
>> understood a change to
>>
>> =A0 =A0 =A0 os.spawnlp("sh", "-c", editor + " \"$@\"", fileName)
>
> I am still curious about this, though it is not so important.

You are right, the system() line is not so important. I can revert
that line of change.

Kevin
