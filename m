From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git merge
Date: Tue, 20 Mar 2012 18:50:01 -0500
Message-ID: <4F6917A9.3000400@gmail.com>
References: <4F685237.5060402@labage.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabien Dubail <fabien.dubail@labage.be>
X-From: git-owner@vger.kernel.org Wed Mar 21 00:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8of-0008Is-0T
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab2CTXuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:50:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37633 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab2CTXuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:50:03 -0400
Received: by yhmm54 with SMTP id m54so594173yhm.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gucA6mnFrxosMas0Z0R+gy1WGlBsKFQFNdzYOjA84+0=;
        b=FKLoHXeIuK4ur95uCwZanxUtdTaUWBgbnodR7uNBW15otv7E8IlijyLaLBMD3ue/Vy
         ARRuuA7mz+QeYn5h3kI78NvPh3hZ9VjrtbguaJ9TCjrLpANG1r4Ycn3RnJTatvYZdGvz
         7Qf10Olk2ouDk5azS/os5bQGn87j7i21w4Qgvh20SSNOpqe/Hp5904OgFUQA72WIdRCl
         FKypDqGFU+Gb4c5chJEkuWd4C1teggJALGZxynjKb0C0c5BwKiqfjjLWYX83URVpeOvv
         i8sYjZ0bZUlucndAo9kI5HWoFWI/kAydNiH5hK70l/oKfUyaF28jaMSwqX1QwySiazOE
         4goQ==
Received: by 10.60.20.38 with SMTP id k6mr2414267oee.26.1332287402690;
        Tue, 20 Mar 2012 16:50:02 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b3sm2881022obp.6.2012.03.20.16.50.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 16:50:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <4F685237.5060402@labage.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193553>

On 3/20/2012 4:47 AM, Fabien Dubail wrote:
>
> I've conflicts when I merge branches. I can resolve some conflicts but
> not all. The remaining conflicts will be solved by someone else?
> To do that I would like to merge only some files and resolve 'my'
> conflicts. (something like: 'git checkout branch files' but with merge)
> Than remaining files will be merged by someone else and remaining
> conflicts will be resolved .
> Is-it possible to do that with git and how? Or is there an other way?
>
One way you can do it is to create a branch containing your resolutions. 
  Then the other person pulls your branch.  They would redo the merge on 
their own branch and checkout your resolutions to apply your work, and 
resolve the remainder himself.  This could go on for mutltiple people. 
You can edit the merge commit message to document who resolved which 
conflicts.

Maybe someone has a better way.  We did a "distributed merge" this way. 
  I pulled everyone else's branches containing their resolutions and 
then redid the merge and checkout out their resolutions from their 
branches and resolved my portion assigned to me personally.  Actually, I 
think I did mine in a separate branch and then when all were done I 
redid the merge and checked out out everyone's portions from their 
respective branches (including mine) to accomplish the distributed merge 
(merge conflict resolution).  (In our case, we were actually doing 
git-rebase "merge", but I think it would work for git-merge also.)

Maybe someone else has a better way.

v/r,
neal
