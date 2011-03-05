From: Ruben Laguna <ruben.laguna@gmail.com>
Subject: why is my repo size ten times bigger than what I expected?
Date: Sat, 5 Mar 2011 11:05:24 +0100
Message-ID: <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 11:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvoMd-0007TT-BK
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 11:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab1CEKFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 05:05:25 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39247 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab1CEKFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 05:05:24 -0500
Received: by pvg12 with SMTP id 12so457502pvg.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 02:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=8argtj2qxbVTv5HQ2m0IaK3tgXsUJfpFaKr+TzQ3hjk=;
        b=QhzZLcGh6qjj0BqmJrwbAkkKZA+0xYzMm0bYz3h5m6pkDiu5wsr5Sbld70oNv7oh8Y
         tB1KnuNmIawN9tDLmVBtmqhTbGkDwWggs6u47PaVi0nYYvNnRZqINFQmhxyjKAvUAYbT
         QwNrOo7QhA82seNhB479j6rO5nrP4HNVny7+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=D9N5U2QDYOzhdOfuZxkd2ve+sCj5ViKt6j5NeYJNPT2qZophhu0p+E68wVzzAvcBce
         oSiRZrNZhRiCiPIe0ENTT1vnQDho6nVHPRCmHD18u1sJmPDY2+Zw5TmsrAYrHJdM03fq
         jfZIrVszNP6SpeuZtDJlE5TDz/shMvbjvs1Yg=
Received: by 10.142.209.20 with SMTP id h20mr1371082wfg.1.1299319524445; Sat,
 05 Mar 2011 02:05:24 -0800 (PST)
Received: by 10.143.162.21 with HTTP; Sat, 5 Mar 2011 02:05:24 -0800 (PST)
In-Reply-To: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168483>

Hi,

I had a repo which was big 143MB because it contained a bunch of jar
files. So I decided to remove those completely from the history.

In short I used the git-large-blob [1] to find all the jars and used
the git-remove-history script [2] which does the filter-branch thing,
prune, etc.

I did this on all branches (that I know of) and now I can see that the
jars are gone because I can't find them with git-large-blob. =C2=A0and =
the
repo size has dropped from 143Mb to 87Mb.

My concern is that 87Mb is still really big taking into account he
size of the project.  in fact if I run "git diff-tree -r -p $commit
|wc -c" for each commit and sum all I get 5.5Mb.


I also ran the git-rev-size [3] script that I found in this mailing
list and I only see that the size grows steadly from commit to commit
up to 1482731 bytes. So again how come the .git directory is 87MB?


So, Can anybody tell me if this repository size is "normal" for a
project with 1.4MB source and 352 commits?
Is there a better way to calculate the size (in bytes) of each commit?

Is there any other thing I could do to reduce and audit =C2=A0the repos=
itory size?


Thanks in advance!
Rub=C3=A9n

---
[1]=C2=A0http://stackoverflow.com/questions/298314/find-files-in-git-re=
po-over-x-megabytes-that-dont-exist-in-head
[2]=C2=A0http://dound.com/2009/04/git-forever-remove-files-or-folders-f=
rom-history/
[3] http://markmail.org/message/762zzg5zckbiq2i7
