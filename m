From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [git-users] Re: how to get the formated patches from the merge
 id
Date: Fri, 15 Jun 2012 13:59:22 +0200
Message-ID: <4FDB239A.9070803@lyx.org>
References: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com> <9579793f-d72f-424c-9546-f2caa1fbf847@googlegroups.com> <CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-users@googlegroups.com, tfnico@gmail.com, git@vger.kernel.org
To: lei yang <yanglei.fage@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 13:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfVBq-0003tK-6f
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 13:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab2FOL71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 07:59:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49146 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2FOL70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 07:59:26 -0400
Received: by eeit10 with SMTP id t10so898139eei.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 04:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Go2d0DQB86FUHVxkKvPKU/WEVSuwGgy/zoUD3QIepUw=;
        b=hNf8VvPLe635cDYkYZD3fOYhxfvoNDItdJ5FvCHPiu/nEc3Wb18mBkwgpxFfZUzGbr
         u9Y+5aY2Eeq++b8FtxCwfTCY7XoxKBS3yCKreLOCvPlBCgAmWmn/7mxh1BJvB9GEXyk8
         uGsPg5Tm0xiMt7i/D+gsNEQno/GgPkW9pOTMGdkE6VXPFFdaze1h0xVLEMB+L1hqNqgu
         8hVdLaYlrm3i6gsf86jLf4feSagcqhBabCZVLoxe9RxxOBt2pEw89UV7TM7b/PF+Fx/u
         sFM4deAP3uvMx+71zVHyBuzc+n8vRBgUd51Y+70s+V7MnkVPkKTFYfRG1x4APJkLiQ+V
         QOlg==
Received: by 10.14.40.20 with SMTP id e20mr1363369eeb.119.1339761562379;
        Fri, 15 Jun 2012 04:59:22 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id c51sm30115335eei.12.2012.06.15.04.59.21
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 04:59:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmNGe9Vz/lxFz3CFN4R2Zib/nRGBjoYwPJOzLSBVtyfGo3R8/ZcVPNXCq/YLtmc+R7ZLHCL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200047>

Op 15-6-2012 13:46, lei yang schreef:
> Hi
>
> I mean,
>
> I have a commit like below
> commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
> Merge: b724cc1 51bfd29
>
> This commit done this work: merge b724cc1..51bfd29 commit,
>
> The question is how could I *onlys* through
> 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the formated patch for
> the
> commit(b724cc1..51bfd29)

It is still not clear what you want to accomplish.

Your proposal: "git format-patch b724cc1..51bfd29" only gives you the 
commits that were in the branch 51bfd29 that weren't yet in the branch 
b724cc1. This just reflect the commits of one of the branches, but not 
the "work done by the merge commit".

If this is really what you want you can do:

$ git format-patch 0e93b4b3^1..0e93b4b3^2

0e93b4b3^1 means the first parent of 0e93b4b3, which is b724cc1. 
0e93b4b3^2 means the second parent, which is 51bfd29

HTH,

Vincent
