From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [GSoC/RFC] Ideas on git fetch --deepen
Date: Sat, 7 Mar 2015 14:32:23 +0800
Message-ID: <CABwkPcoHPyid0gKjjg0NiXY4TYtCbeSJe6XK5HEDFNKR+-_tFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 07:33:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU8II-0004w6-Db
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 07:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbbCGGcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2015 01:32:54 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37789 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbbCGGcn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 01:32:43 -0500
Received: by paceu11 with SMTP id eu11so43364022pac.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 22:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=BeOa4pk7EyJype3kJOwsDnMDdmUtZuD9EMCW6ek2t7E=;
        b=TDziRJmaA0VDrCFuMC6J5LBSPmg2ycdwWfzjqYdlQ9e8/9Tr+osUcdHHGmKJiQ8R2E
         gH7+unJnPlDJhxvfCI9taXmDdT2a3tY93qQh0O44+ahxxsDM+fp1pXfLguqIT4zEBCl6
         QlaGlaOvZj9XfeeUNSNuS5/rWEAe0t8WfGIOZry9mT+zEn8WS8LGViNHG5xA4Nl0qI/O
         XHGTVlDXRSZjv3tYezKuolQMyXjFxWKslwaNeMT6FImiS+5303h2WkaARQcZgc/Q19cL
         qL8TRL7rElnoB79RaFwbDXp91nLBzQsbi7Ts75pozhzJPOj7EKF/L9EAvAtICRCre/cg
         iYQA==
X-Received: by 10.70.134.8 with SMTP id pg8mr32334649pdb.138.1425709963283;
 Fri, 06 Mar 2015 22:32:43 -0800 (PST)
Received: by 10.70.78.225 with HTTP; Fri, 6 Mar 2015 22:32:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264992>

Hi all,

My name is Dongcan Jiang. I am studying for my Master Degree at Peking
University
majoring in Computer Science. I have been using Git to manage my projec=
ts
for about half a year. It's really exciting that Git has been helping m=
e make
revision control much more convenient. Therefore, I am very interested =
in
doing some works for Git in GSoC 2015.

I have submitted my v2 patch on a microproject recently, and I am waiti=
ng
for comments on v2 now.

In the meantime, I have been scanning ideas on the git gsoc page and
their related mails. I find that I am interested in most of them, espec=
ially
"git fetch --deepen" idea.

Here is my understanding about this idea.

Although "deepen" and "depth" have different behavior, "deepen" can be
achieved by "depth" with some extra calculation. If we know the
distance between "my history bottom" and "your tips", we can set the su=
m
of "deepen" step and this distance as "depth" step. Then we can reuse
the logics of processing "depth" to complete it.

Take graph in [1] as an example.

>  (upstream)
>   ---o---o---o---A---B
>
>  (you)
>                  A---B

the distance of "my history bottom"(A) and "your tips"(B) is 1, then
"git fetch --deepen=3D3" can be achieved by "git fetch --depth=3D4"

However, I am a little worried about whether this idea is enough for a
GSoC project. I hope you can give me some comments and suggestions.

[1] http://article.gmane.org/gmane.comp.version-control.git/212950

Thanks,
Dongcan

--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
