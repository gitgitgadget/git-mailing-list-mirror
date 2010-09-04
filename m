From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Additional remote on a local clone. Where do the objects go?
Date: Sat, 4 Sep 2010 22:15:45 +0800
Message-ID: <AANLkTik=qeoq67KZa8Bj7Ynrt8O8ija6yeH6_+e4=gOZ@mail.gmail.com>
References: <i5kudr$dp7$1@dough.gmane.org>
	<AANLkTi=_uP_zFOV_k=cM8TXH16kTPAoPGpNkz+QUSzb-@mail.gmail.com>
	<i5len7$dpr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 16:16:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrtXJ-0004oZ-LB
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 16:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab0IDOPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 10:15:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55594 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab0IDOPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 10:15:47 -0400
Received: by ewy23 with SMTP id 23so1632588ewy.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UnE7QKBCk8RXJoTMyIsYry5/Ltg8kFKTNzqX9u20ZvE=;
        b=XJdglp1mrzX1DlQTJCypl80tTicq53sjlqyqobH5eHnaxL0tiv38Cw0dFBE8piCjBP
         XcA7GCj1ChgNmFs/xRpw00/Ez2ju7rGBHlcPznrTraA4kkli8VIOC1Pzh4HI16rQR53k
         SQsXIedxa+RbHPIfVgo/wBHIRJgKIGpLs01z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WcPYOi23ecDU8X+nMXH3SMl54zLEDZTsudadepum0DhwHkpSofZjEZshia3CGp1pW6
         iKojvvqo7uOsz7LqRyp2jKKPYksnYGSBNIyizRlVfzdelDam2g/85B+cogPkmop0mK52
         NqN4Dbud//I4rfNf/ZcGJy/kwed1B7S7aSZI4=
Received: by 10.213.25.144 with SMTP id z16mr690779ebb.40.1283609745971; Sat,
 04 Sep 2010 07:15:45 -0700 (PDT)
Received: by 10.213.27.144 with HTTP; Sat, 4 Sep 2010 07:15:45 -0700 (PDT)
In-Reply-To: <i5len7$dpr$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155328>

Hi,

(Please avoid dropping emails from the Cc list. Since you're using
gmail, you could use "Reply to all".)

On Wed, Sep 1, 2010 at 7:51 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Tay Ray Chuan wrote:
>> Two improvements: shared objects, and configuring git-pull:
>
> I'm confused. I thought the local clone already used shared objects?

You'd have to use "-s/--shared" with git clone; I don't think it's
done by default.

(On hindsight, I should have used this instead of setting it up
manually by writing to .git/objects/info/alternates.)

> So this will pull from the gitorious remote and store the objects in the
> parent git from where they are shared with this local clone?

No, you'd have to first pull from gitorious in your parent directory,
before going into the local repo/branch (eg. qt46) and then pulling
again.

> Which is the better solution between this and git-new-workdir given that
> these are permanent branches, not temporary, and I'll want to push and pull
> various clones and share the objects. It looks like the git-new-workdir
> option creates symlinks, whereas the local clone creates hard links, and
> this solution creates a redirect of sorts.

I haven't used git-new-workdir comprehensively, so I'll avoid
commenting too much, but I'd like to know if you've looked at
branches? You can just switch between each and do your qt 4.6- and
4.7-specific work.

I say that, because what you're doing sounds like what a hg user would
do to emulate git branches.

-- 
Cheers,
Ray Chuan
