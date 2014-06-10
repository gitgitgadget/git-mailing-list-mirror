From: =?UTF-8?Q?Pierre=2DFran=C3=A7ois_CLEMENT?= <likeyn@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 10 Jun 2014 16:59:19 +0200
Message-ID: <CANWD=rUz9Wgoktp7-NkQMvWDmYOPv0kMqUNoe4FPJ9+Ax_UJBA@mail.gmail.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
 <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
 <87vbsayy9w.fsf@fencepost.gnu.org> <CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
 <xmqq61k9d5nk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuNWb-00082S-DD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 16:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaFJO7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 10:59:41 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:57135 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaFJO7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 10:59:40 -0400
Received: by mail-ve0-f175.google.com with SMTP id us18so6121115veb.6
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mM6qQJAGioKZKrm7Jk83pAWB17VjDuhUxkrFlkJBNgg=;
        b=uLhBJI0ZAijLGorNl3mqoLq+GGZ+R9dkoIoUky7v/6FuVtk2owSe7PkeVOVvXQz9sg
         dECQkgT3PR3QUpBqCupq9grbkwEtCjkUFF6TEDXs9P7XsqQDViQyXH4j4AbopzSzq+bs
         5uL4tJ8jHxkU9qVYFiPfgD+VuWCBZ2aa6piSIRnPXR4Zp5CNE/0EK62JLcMw8GQzjZGX
         zJ6TIuzrGEfSuF5+MLIQ+ZFxHJwmTsRCA90DJPRrwciOlJBqdXmaSN2z3/bvpu6QXLuP
         tGHECPXqUh9D3dk4cNdHM6/V/FBZpqP5rRXGPzrVUgZklvohyPppSuRkoU1jDaekiUKl
         VE1g==
X-Received: by 10.58.210.68 with SMTP id ms4mr5101903vec.6.1402412379649; Tue,
 10 Jun 2014 07:59:39 -0700 (PDT)
Received: by 10.58.182.104 with HTTP; Tue, 10 Jun 2014 07:59:19 -0700 (PDT)
In-Reply-To: <xmqq61k9d5nk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251195>

2014-06-10 1:28 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:
>
>> Hm, I didn't think of "git apply --index"... Makes sense for this
>> special use, but I'm not sure about the other use cases.
>
> Try merging another branch that tracks a file your current branch
> does not know about and ending up with conflicts during that merge.
> Resetting the half-done result away must remove that new path from
> your working tree and the index.

Hm I see. Even though the documentation doesn't make it very clear
about what happens to such files, it turns out the scenario we
stumbled upon seems to be the special use case after all. Thanks for
shedding some light on this :) I wonder why does git-reset's hard mode
not always remove untracked files then?
--
Pierre-Fran=C3=A7ois CLEMENT
Application developer at Upcast Social
