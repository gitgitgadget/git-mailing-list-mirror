From: Geoffrey Irving <irving@naml.us>
Subject: Re: one half of a rebase
Date: Fri, 11 Sep 2009 22:23:24 -0400
Message-ID: <7f9d599f0909111923v76e0f411n16555e7cdc0c3ed1@mail.gmail.com>
References: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com> 
	<81b0412b0909111410k3f3ebfaco393bb37ff5a6b5c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dylan Simon <dylan@dylex.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 04:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmIHV-00066O-12
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 04:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbZILCXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 22:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbZILCXn
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 22:23:43 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:55199 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZILCXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 22:23:42 -0400
Received: by vws33 with SMTP id 33so1072440vws.33
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Dowig/LoZy6Wzxmw8ufE3lalxZFezrWB/eA8nL7TE8Q=;
        b=NzWqiZpu/yRz7EccZkrGBHdlVfQwoI9uYhFofXORmY5uKTfivZ0gErQ5Qsm7NZSzgd
         lRTiwZ5gAPbk0GuiutN7S8ta2zwD/bG9VCbtd4L6p+xiOfqennMQ+AY0mGqKARcblZbi
         I9TAASn9oDk8WVZoqyf8DRJDNHay80bfHggBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=TzDgwvjEH4porKykYSI37khArJ4RVIYepO1c2iSBub671vqzaMKFkarMB7DUKsjQ6+
         JUM31GdF0jHUZMrvgDOPteOF+Qz1jzBoyb5K8i+VSFg4Lma5XLPcoqecm+Tmh2AERN5A
         krGjf823fmYmkfQ7QDQAesHyW09sB7eLjK//U=
Received: by 10.220.108.233 with SMTP id g41mr4473829vcp.2.1252722224701; Fri, 
	11 Sep 2009 19:23:44 -0700 (PDT)
In-Reply-To: <81b0412b0909111410k3f3ebfaco393bb37ff5a6b5c1@mail.gmail.com>
X-Google-Sender-Auth: 5c7c98d78afa9d2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128234>

On Fri, Sep 11, 2009 at 5:10 PM, Alex Riesen<raa.lkml@gmail.com> wrote:
> On Fri, Sep 11, 2009 at 19:25, Geoffrey Irving <irving@naml.us> wrote=
:
>> If I could do (2) as a separate operation, it would look something l=
ike
>>
>> =A0 =A0git cherry-pick-all topic
>>
>> which is simpler and faster since it avoids switching files back and
>> forth (master to topic and back). =A0Is there a robust way to achiev=
e
>> the cherry-pick-all semantics with current commands? =A0If not, how
>> difficult would it be to partition rebase accordingly?
>
> I have this in my .bashrc:
>
> $ gcp3 ()
> {
> =A0 =A0git format-patch -k --stdout --full-index "$@" | git am -k -3 =
--binary
> }
>
> Then, while on master branch:
>
> $ gcp3 master..topic

Great!  That should work nicely.

Geoffrey
