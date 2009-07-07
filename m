From: Elijah Newren <newren@gmail.com>
Subject: Re: request for documentation about branch surgery
Date: Mon, 6 Jul 2009 21:45:22 -0600
Message-ID: <51419b2c0907062045p648d5478x88515261249a2d79@mail.gmail.com>
References: <200907070105.12821.bruno@clisp.org>
	 <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 05:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO1ca-00083j-CT
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 05:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbZGGDpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 23:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZGGDpU
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 23:45:20 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:40776 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbZGGDpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 23:45:19 -0400
Received: by yxe26 with SMTP id 26so6304701yxe.33
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OQ9WQweGjPrNrDJCiatMWPYWIM8xdNjdFnQPPipVWkY=;
        b=H4+8i+penxe43N9lUV7hF8XayqA40QFkIbwnLXlbCELn9CSI/2I3Q0g3dC3RPhQFuh
         6YwqRiDzRFand1PCoCu9ecOZymwR/q6ZcdM66cU4B2ePU6N7DuZox1jnQ6o7Hae5Hhxe
         FPReN498FwniuAok5kz9iePUkexzseImSEoxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wZ/dNG56tL+m54ZdoBx3x1hXqFNlk+2UZveuVntuPNf71Lif3+cvhmpDfKZfCy8OoO
         Hw42M4PpTk94gy/LqzbcrVaWSu6GtPH9+OT42fGMB84/HUWHS6gaCgIuoVPeEdQsn/2H
         n7qM1eiXuV7PDXZ5PySd5tAWk+qdescq3iCFE=
Received: by 10.90.66.14 with SMTP id o14mr4769635aga.116.1246938322257; Mon, 
	06 Jul 2009 20:45:22 -0700 (PDT)
In-Reply-To: <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122820>

On Mon, Jul 6, 2009 at 8:30 PM, Elijah Newren<newren@gmail.com> wrote:
>> =C2=A0This is achieved by
>>
>> =C2=A0 =C2=A0$ git checkout master
>> =C2=A0 =C2=A0$ git reset --hard E =C2=A0 =C2=A0 =C2=A0# Cut the bran=
ch "master"
>> =C2=A0 =C2=A0$ git merge released =C2=A0 =C2=A0 =C2=A0# Copy commits=
 from branch "released" to "master"
>
> I'm assuming master isn't checked out. =C2=A0If so, the following is =
faster:
> =C2=A0$ git branch -f master E

Sorry, I meant
  $ git branch -f master released
because we want to set master to the tip of the released branch, not to=
 E.

> (If master is checked out, just 'git reset ---hard released')
>
