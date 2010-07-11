From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [GSoC Update] The 7th week
Date: Sun, 11 Jul 2010 15:02:38 +0800
Message-ID: <AANLkTilejGRx_ypUExeXvr04oI5voHSWV-WlAEbTmPu1@mail.gmail.com>
References: <AANLkTimyVewBItArmb7Q2ELy0Dk20LvxIdhoucap8nO6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 11 09:02:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXqYn-0004Xr-ML
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 09:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab0GKHCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 03:02:41 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46509 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0GKHCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 03:02:40 -0400
Received: by qyk38 with SMTP id 38so3896387qyk.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PukQ/Pu0oERVIP5zMJXthbOpcc7AL+OHGM9xdj/fm1M=;
        b=lWmKhQY9D+uzo3TtcievMHbYq+TOlNdvS3DyItqpIFVHRab4r4rcN1fLwRtXjVCvkN
         DRISfJl3LCvt4EG3ZC8oXFwDxWlFeCKiLmd9MdXqNmg57EQijAlKcIQW0PGNljOvNS8D
         dsGiu1Zk0vwUMZMRzt6Fa+EHqglXKsVG0yYpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jI9TRvNdxzsJMTA7rD8kyytRrvHIMVIBE/FNSNVLxxG+cyKpKTa6IJTccTFH7XhqTn
         cQKMQKu38RRB0AOAAjIfo2smHlWIeAy7fXxumnOYGKuATqSnDua7z5zy773G1Ku5BD29
         sMIlyac+Ri1cAQ6wqKD03Vw8G87hfVqqq/ycY=
Received: by 10.229.232.197 with SMTP id jv5mr931481qcb.121.1278831758664; 
	Sun, 11 Jul 2010 00:02:38 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sun, 11 Jul 2010 00:02:38 -0700 (PDT)
In-Reply-To: <AANLkTimyVewBItArmb7Q2ELy0Dk20LvxIdhoucap8nO6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150764>

On Sun, Jul 11, 2010 at 2:57 PM, Bo Yang <struggleyb.nku@gmail.com> wro=
te:
> Hi all,
>
> =A0 =A0This is my status update of the 7th official week of GSoC.
> =A0 =A0In the past week, I worked hard parallelly on two branches, on=
e is
> the parent rewrite feature and the other is the basic 'git-log -L'
> problem fix. Generally:
>
> =A0 =A01. parent rewrite: I have finally figure out a version 1 of it=
 and
> submit it the list. It contain the basic support for '--graph' option
> and I also add a few new test cases for it, also there is a little
> document update;
> =A0 =A02. the 'git-log -L' basic feature: I have fixed 2 potential bu=
gs
> of it and also try to free the commit_list along with the
> cmd_line_log_walk to try to reduce some memory leak.
>
> =A0 =A0And there is an extra commit, which is a little bug fix of
> previous 'diff-graph' series. :-)
>
> =A0 =A0What's coming on:

In the second half of GSoC, I will try to figure out the following thin=
gs:
1. Now, when we traverse the line level log, we do:
    limit_list -> sort_in_topologically -> [limit_line_list if
--graph] -> traverse the result.
    It is we deal with the whole history as least 2 times and maybe 3
times when '--graph' given.
    I will try to figure a way to do a 'in place topologically iterate
on the history', to reduce the times of whole history traverse.
2. When we reach the point that, some lines of code are added from
scratch, line movement/copy will be detected, and then follow the
source of movement/copy and go on list the line level log.

That's all, thanks!

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
