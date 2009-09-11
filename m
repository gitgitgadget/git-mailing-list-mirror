From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: one half of a rebase
Date: Fri, 11 Sep 2009 23:10:38 +0200
Message-ID: <81b0412b0909111410k3f3ebfaco393bb37ff5a6b5c1@mail.gmail.com>
References: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dylan Simon <dylan@dylex.net>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmDOI-0005qQ-WC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbZIKVKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756405AbZIKVKg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:10:36 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57406 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbZIKVKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 17:10:35 -0400
Received: by fxm17 with SMTP id 17so1077227fxm.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qFIW4ZCJr8OHZiyi0g3WGcGF7gSUa/O7ecpSsM/VofE=;
        b=Ziic3up+3QhLXhZ5qB43WI3p5aGrT3RG6ljr+r3pvP/XNDsZ6V6WvZrGvYRzJkTqC1
         5Z6EJ1ROJjENEBgpW3zbzrgkjQbD9ibEQiYwtc1LEPadzvxemVEJVOxNJJcHMMWm7tIC
         0bXWXb4wKJ4EY7yl69Z6A+A1dtYmzRCBLyD3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RZ7z8nP897lLfKz7t1NB4/AfS8kG0MWRbZbQUVVmzHrIa1SRu3EqfVznbPx+uXhYCU
         W4XOrdUsgSqUp2wg1hzc4oMtuQavLjD7Ub2L5HRu9Hw+TLCeF3w9w8sVd7J7JAuyYJna
         hCLBK3spXnLTvZYjlyq0Ax8EW0BX7iZW4xF7I=
Received: by 10.204.160.144 with SMTP id n16mr2449730bkx.152.1252703438168; 
	Fri, 11 Sep 2009 14:10:38 -0700 (PDT)
In-Reply-To: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128219>

On Fri, Sep 11, 2009 at 19:25, Geoffrey Irving <irving@naml.us> wrote:
> If I could do (2) as a separate operation, it would look something li=
ke
>
> =C2=A0 =C2=A0git cherry-pick-all topic
>
> which is simpler and faster since it avoids switching files back and
> forth (master to topic and back). =C2=A0Is there a robust way to achi=
eve
> the cherry-pick-all semantics with current commands? =C2=A0If not, ho=
w
> difficult would it be to partition rebase accordingly?

I have this in my .bashrc:

$ gcp3 ()
{
    git format-patch -k --stdout --full-index "$@" | git am -k -3 --bin=
ary
}

Then, while on master branch:

$ gcp3 master..topic
