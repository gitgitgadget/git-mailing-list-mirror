From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 16:12:43 +0200
Message-ID: <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
References: <48D59A30.5020403@cs.tamu.edu>
	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>
	 <48D8EDDA.3050804@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Freeman" <jfreeman@cs.tamu.edu>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8ec-0000Jv-Em
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbYIWOMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYIWOMp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:12:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:13062 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYIWOMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:12:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so314386yxm.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8u5eV/Wayl3cyHvljFvxFQY6Ho09XlUINsyM+A/vg8k=;
        b=Bxj8GxLfak8szFWMFt5uKr68AOIeDwq9IDhBc3Pi0heYBgBRFtoXhQz0NvnSMnjXUI
         oHShMSiArwzTKGHrvxlXIXE5enrjTru7sCpe7uYSXmadEj8W2XDuJXdv3g4Uj17vae1m
         XuTQLHiOXA5++SrplsyjN864/hBfz5x28mBKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ASuhHXN9sS4M6JeFF8U0nh3B4R7DbQzFWqICKOkZbym0uQ8w/1qX9LFbZLvtEuhA86
         vc24v+WqkeR7nqIxBYJPhE67n6tOn75Cv+/uM/4NVFgK7SppuMXExq/dfd34qq8ZTQfe
         auCOZBu/J6YMAg3Ng+R8h2xVmfWkArtj1WDWU=
Received: by 10.151.42.18 with SMTP id u18mr9290881ybj.57.1222179163562;
        Tue, 23 Sep 2008 07:12:43 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Tue, 23 Sep 2008 07:12:43 -0700 (PDT)
In-Reply-To: <48D8EDDA.3050804@cs.tamu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96567>

2008/9/23 John Freeman <jfreeman@cs.tamu.edu>:
> Alex Riesen wrote:
>>
>> Do these work:
>>  $ ssh john@remote.system.edu ls -R /home/bob/path/to/repo
>>  $ ssh john@remote.system.edu 'cd /home/bob/path/to/repo && pwd'
>>
>
> Yes, they do.  I wish the mailing list did better threading; please see my
> other posts if you happened to miss them:
>
> http://article.gmane.org/gmane.comp.version-control.git/96442
> http://article.gmane.org/gmane.comp.version-control.git/96505
>

Saw them. .bashrc (/etc/bashrc too) is not used for non-interactive sessions,
like yours (of course, you can source them from
.profile/.bash_login/.bash_profile).

Have you tried the commands exactly? (Even more interesting would be to try
a simple getpwd program which prints errno)
