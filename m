From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 1/1] index-pack: Disable threading on cygwin
Date: Tue, 26 Jun 2012 23:00:59 +0200
Message-ID: <CABPQNSZ7=kqSjXPLior+LXqAt4AzcybOjJ1P8ZLQ+J-9gCgvdw@mail.gmail.com>
References: <4FE9FD34.5020406@ramsay1.demon.co.uk> <7vk3ytc0es.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjctP-00047Q-IP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab2FZVBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 17:01:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34330 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2FZVBj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 17:01:39 -0400
Received: by dady13 with SMTP id y13so417448dad.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1UVYE/lOfgXDAgf01JrTyEbvBJ6MqvsbcYOuzYDtdGc=;
        b=ueE85nlUR0iiacmvy9dDZ9eZuW7gtcL6uV/xvOTDF7uFCavPQ8ucSzP98IwCSu53w5
         CWgnfJ+zUoxzvRJiJzv0t3k8zhpInP/I0C82eIeWf1KoMaDwEL7PxOHpwMZypNAHWy15
         y0LoTH26dqrUG0wHp/Rg+coNMMSfhPH95yvrwHnZHNtHZjlqPfMHObSwnDaFTGxxtPsm
         8J8weB9kT8z9QHQKZVr78pczCwiNeVz/5kVyID0zZa86IxHrN/0XMllPZRmNE5ZH7Aaw
         uTe0ffadHvRpw+nWcDWz8DhZnZvsT65L1MuCZQJH1NYJHdowNtMqqja+8OvOWWT04R04
         OaDQ==
Received: by 10.68.194.105 with SMTP id hv9mr47480965pbc.126.1340744499389;
 Tue, 26 Jun 2012 14:01:39 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 26 Jun 2012 14:00:59 -0700 (PDT)
In-Reply-To: <7vk3ytc0es.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200681>

On Tue, Jun 26, 2012 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> =A0 =A0- renamed FAKE_PREAD_NOT_THREAD_SAFE to NO_THREAD_SAFE_PREAD
>
> Sensible.
>
>> =A0 =A0- when NO_PREAD, set NO_THREAD_SAFE_PREAD in the Makefile, ra=
ther
>> =A0 =A0 =A0than in git-compat-util.h
>
> I think it is a bad change. =A0When compat/ pread gets improved to be
> thread-safe, this will surely be missed.

But CAN it be fixed? I don't think it could, at least not without
wrapping ALL calls to functions that perform IO on file handles or
file descriptors...
