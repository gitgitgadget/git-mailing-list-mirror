From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Wed, 13 May 2009 00:38:02 +0800
Message-ID: <46dff0320905120938m36018b45y780126df42ed4194@mail.gmail.com>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
	 <7vhbzq8g7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3v0C-0000du-Qe
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZELQiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 12:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZELQiF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:38:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:18850 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZELQiC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 12:38:02 -0400
Received: by yx-out-2324.google.com with SMTP id 3so45664yxj.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xdbZhJlcHsVNY7fJa4VD793ftydwMePnig+Bu8TFWoY=;
        b=oCIOcPT7j2euX6xq7n9xn0OPSmNxyYTKVID8GyOfmgDx1z9Ww0+mlLKmzMiBWCvjg/
         RBTxQNIuv/goqtvEegFSu9gh86vvdg4gIjz4wFgo9x/Qrlu92FYeVgE1bKd4TqaLk5sP
         uUG/iKxhJz43Z80Jq/wDO0UvR9mrclqMcVdkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ngB9oi/byyGC87BtkB7voYLeC0IfYkwqv/Ydmmw3jP1lYLLo2Hp8TH1hsn5IAxoFfT
         b8LwEi+RzLFKjmaJZ590dp0TXJuyEd0tOwnh/UXPAvv+c177lJV448ocwL/T7AUSj29h
         1Sg45YDqK0MO/BMe+yWda6/BkPY1ELKwmevVY=
Received: by 10.90.92.16 with SMTP id p16mr430646agb.35.1242146282740; Tue, 12 
	May 2009 09:38:02 -0700 (PDT)
In-Reply-To: <7vhbzq8g7u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118922>

On Tue, May 12, 2009 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>> a----b
>> =C2=A0\----c
>>
>> Given the graph above, I want to create a commit b1 on top of c, whe=
re
>> b1 and b have the same content. i.e.
>>
>> a----b
>> =C2=A0\----c----b1 =C2=A0 =C2=A0( content(b) =3D=3D content(b1) )
>
> On "c", you can:
>
> =C2=A0 =C2=A0git read-tree -m -u b
> =C2=A0 =C2=A0git commit

is -u necessary?

>
> I think with newer git you can say
>
> =C2=A0 =C2=A0git reset --merge b
> =C2=A0 =C2=A0git commit
>

When the working directory is clean, it seems "reset --hard" and
"reset --merge" behave the same. So after "git reset --merge b",  the
HEAD is moved to b, and i have nothing to commit.
