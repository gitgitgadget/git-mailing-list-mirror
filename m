From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git log for a merged branch
Date: Mon, 13 Sep 2010 16:00:18 +0200
Message-ID: <AANLkTikbnoR_=x1_Aq4jh1BuMarEMxXkY=iX0iOjdgyt@mail.gmail.com>
References: <201009090117.06555.barra_cuda@katamail.com> <30770696.248360.1284385078695.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 16:00:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov9aQ-0006IU-81
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 16:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab0IMOAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 10:00:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55736 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0IMOAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 10:00:39 -0400
Received: by pvg2 with SMTP id 2so2131676pvg.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 07:00:38 -0700 (PDT)
Received: by 10.114.136.19 with SMTP id j19mr4199483wad.170.1284386438608;
 Mon, 13 Sep 2010 07:00:38 -0700 (PDT)
Received: by 10.231.30.193 with HTTP; Mon, 13 Sep 2010 07:00:18 -0700 (PDT)
In-Reply-To: <30770696.248360.1284385078695.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156091>

On Mon, Sep 13, 2010 at 3:37 PM, Stephen Bash <bash@genarts.com> wrote:
>
>
> ----- Original Message -----
>> From: "Michele Ballabio" <barra_cuda@katamail.com>
>> To: "Stephen Bash" <bash@genarts.com>
>> Cc: "Git Mailing List" <git@vger.kernel.org>
>> Sent: Wednesday, September 8, 2010 7:17:05 PM
>> Subject: Re: git log for a merged branch
>> On Wednesday 08 September 2010, Stephen Bash wrote:
>>
>> Let's call the merge commit "mergecmt". The commit where the "releas=
e"
>> branch
>> branched off is
>>
>> git merge-base mergecmt^1 mergecmt^2
>>
>> ... where mergecmt^1 is the first parent of the merge (usually on th=
e
>> "mainline" branch) and mergecmt^2 is the second parent, which
>> usually(*)
>> refers to the "release" branch (in this case, tagFoo).
>>
>> So
>>
>> git log $(git merge-base mergecmt^1 mergecmt^2)..mergecmt^2
>>
>> is what you want.

If there is more than one merge-base you=B4ll have to use:

git log mergecmt^2 --not $(git merge-base mergecmt^1 mergecmt^2)

and you may use this shorter form:

git log mergecmt^2 --not $(git merge-base mergecmt^@)

HTH,
Santi
