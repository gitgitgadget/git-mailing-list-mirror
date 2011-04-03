From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Background processes in post-receive hook
Date: Sun, 3 Apr 2011 08:52:50 +0530
Message-ID: <BANLkTin4-fMhi_5H1oZ+gPB99stj5GRjVA@mail.gmail.com>
References: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 05:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Dtz-0006V9-ME
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 05:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448Ab1DCDWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2011 23:22:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50654 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab1DCDWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2011 23:22:52 -0400
Received: by vws1 with SMTP id 1so3503419vws.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZLJ9lqxNumu1m+431ZjvqMkvYPK2D8RF5IRELIMyr6M=;
        b=fIkqsPCdeO+CUpIazUN7q+dL2Jz7QDfvb82lA2PRNl4mRnxTicXthsEQOb8+e+YLoO
         Uk+l+C8eVNy5uUPR7hkJJgrkLhYteavXxg5W606ES6SlfmZukkDffj/GTU6lmTfnBLGo
         QMAsc8ky4cl4G7MeuapbH3b83l2BcAQ62ulKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XRvYsvYUKQ0bkg+X7thVqEHjtsvbuuP25FprLCy5PnE8L5WvOcbkx6IMLmoo/2oukE
         yIPmCe8mVtFjXgXI500dbHqyn0iKSZfWmN0YYNPkr+jDJS3x+RnSEQox3Re+iD1sQCQO
         IcpaWjqcWewKZ4Gurpjn4pfYSKV3cF6eZ5Sdk=
Received: by 10.52.66.74 with SMTP id d10mr3614732vdt.25.1301800971103; Sat,
 02 Apr 2011 20:22:51 -0700 (PDT)
Received: by 10.52.109.137 with HTTP; Sat, 2 Apr 2011 20:22:50 -0700 (PDT)
In-Reply-To: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170672>

On Sun, Apr 3, 2011 at 4:33 AM, James Pickens <jepicken@gmail.com> wrot=
e:
> Hi,
>
> I have a post-receive hook (bash script) that launches several backgr=
ound
> processes and exits immediately. =C2=A0I do that so I don't have to w=
ait for the
> background processes to finish every time I push to the repository, b=
ut Git
> seems to wait for them to finish anyways, even though the post-receiv=
e hook
> itself already exited. =C2=A0Is there any way to stop Git from waitin=
g and let the
> push finish immediately? =C2=A0Sorry if I'm missing something obvious=
=2E..

interestingly, the double fork trick doesn't work either...

  ( ( long-running-command & ) )

What Junio said may be the only alternative...
