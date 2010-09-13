From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git log for a merged branch
Date: Mon, 13 Sep 2010 16:43:59 +0200
Message-ID: <AANLkTikw0Cx7aymTxpjRwwxdj0s607eL0creyV5Y+KJQ@mail.gmail.com>
References: <AANLkTikbnoR_=x1_Aq4jh1BuMarEMxXkY=iX0iOjdgyt@mail.gmail.com> <15224422.248536.1284387218322.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 16:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvAGl-00083W-FQ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 16:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0IMOoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 10:44:22 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54647 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab0IMOoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 10:44:21 -0400
Received: by pxi10 with SMTP id 10so2157961pxi.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 07:44:20 -0700 (PDT)
Received: by 10.114.95.12 with SMTP id s12mr48468wab.217.1284389059754; Mon,
 13 Sep 2010 07:44:19 -0700 (PDT)
Received: by 10.231.30.193 with HTTP; Mon, 13 Sep 2010 07:43:59 -0700 (PDT)
In-Reply-To: <15224422.248536.1284387218322.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156094>

On Mon, Sep 13, 2010 at 4:13 PM, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Santi B=E9jar" <santi@agolina.net>
>> To: "Stephen Bash" <bash@genarts.com>
>> Cc: "Michele Ballabio" <barra_cuda@katamail.com>, "Git Mailing List"=
 <git@vger.kernel.org>
>> Sent: Monday, September 13, 2010 10:00:18 AM
>> Subject: Re: git log for a merged branch
>>
>> If there is more than one merge-base you=B4ll have to use:
>>
>> git log mergecmt^2 --not $(git merge-base mergecmt^1 mergecmt^2)
>>
>> and you may use this shorter form:
>>
>> git log mergecmt^2 --not $(git merge-base mergecmt^@)
>
> That's surprisingly compact... =A0Impressive.
>
> Slightly changing the topic, we normally tag the release branch, then=
 merge, then delete the branch. =A0Is there a simple way to determine m=
ergemt from the release tag?

So, in other words, you want the list of descendants of the given
release tag say v1.7.3-rc1, contained in a give branch, say "master":

$ git rev-list --parents v1.7.3-rc1..master | grep $(git rev-parse
v1.7.3-rc1^{})
5418d96ddca8134b5abeb99430f61c062d91f722
3b3a8ed4beadf5d9437597108355b23c7143bc81

But note that it may not be unique and may change over time. In
particular if you have more commits on top of the tag and merge again.

Santi
