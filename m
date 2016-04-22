From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Fri, 22 Apr 2016 10:10:56 +0200
Message-ID: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com>
References: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com> <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com> <CAC5gnOx1ZbNnYzMYYfD5TkXkgHAz7qgOTVCEiu2D0PA-MZLrvQ@mail.gmail.com> <E90E5734-C130-42A4-9230-9C95A466C919@gmail.com> <CAC5gnOx9W3S3f=92T_LNWBfFm71xe9uNY3O_exxetcf2Xjp+Ew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Ben Woosley <Ben.Woosley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 10:11:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atWBH-00020F-3T
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 10:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcDVILH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 04:11:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36772 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbcDVIK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 04:10:59 -0400
Received: by mail-wm0-f47.google.com with SMTP id v188so11107633wme.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rX00xLSa/L/b/TJ3XYnJ1CZtXFku3XolYlmsVVAuKoA=;
        b=sPvK7t9gzkuiRH5p76CWoF5VdUrklq80OX7ouZYFEpHSU5Gn97tAR4DCd/3lgpFM+s
         f1wM6lHG8MRHX4Lk/5W2EJix/RaJ8J7ZRFj1Qj5WB2tzRZq1pYJQQUikGXUcaQ1SIaCi
         IxmcxymYM9iQddrmq+Bh6DYCqloAg1Ukez8TEwEBGmisFymFVOKwIH+8aZII09gywCHP
         B9L3ZJb+Sw41/+RP16jYEfVQt2YdJqfUai/Ba3HG5ZX3D8HIEemC2hVu76vuuywxz2JM
         6jJJE4SNS2HV2ilVmT9Jr6JMugVzRF/WP19wB99oBBnDsRsRKBI/Yxc+YDyXdmu55WJk
         uijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rX00xLSa/L/b/TJ3XYnJ1CZtXFku3XolYlmsVVAuKoA=;
        b=jvOxemz3FFOfe4ycWUCXWDGEBKjlR3uQLtsoK/CArSFAVkplMvoMR3xxPs+q1g8NAd
         kLgIcsk7E5q6QbUCVrFLHlr0H4gVdZSlfLTIwa47z751ppiXAcnRfWkKMyQ7vaNG6KQO
         BITW+W4ytMKWZY3nUNKwGHmXyx4RctSYYYjWsuZxSx+EH5i3/bMeVeGDUSPGvIKe5bvK
         hkDSmvymJQE8w9Vnlcy3q6vVtT7oznzQg6/ib282vM6Q9AezRFbCduKzagnmAr9J/K9n
         Cmt/8d2dKVoHnD0CwvNvflG4Vu+Oztugl1e4mha089yzT40wUZ3BgioN7yV61ru9baH0
         bJ4A==
X-Gm-Message-State: AOPr4FU9WLV5K8kebgt7FUKiW3opMqIW/RtoU2ykuSLOYb8G5rIyyt9YX3dAsk1PKeBpOQ==
X-Received: by 10.194.113.67 with SMTP id iw3mr15215989wjb.99.1461312657612;
        Fri, 22 Apr 2016 01:10:57 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB43AA.dip0.t-ipconnect.de. [93.219.67.170])
        by smtp.gmail.com with ESMTPSA id by7sm6817577wjc.18.2016.04.22.01.10.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 01:10:57 -0700 (PDT)
In-Reply-To: <CAC5gnOx9W3S3f=92T_LNWBfFm71xe9uNY3O_exxetcf2Xjp+Ew@mail.gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292179>


> 
> 
> On Wed, Apr 20, 2016 at 12:36 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> 
>>> On Wed, Apr 20, 2016 at 12:00 PM, Luke Diamand <luke@diamand.org> wrote:
>>>> On 20 April 2016 at 19:28, Ben Woosley <Ben.Woosley@gmail.com> wrote:
>>>>> From: Ben Woosley <ben.woosley@gmail.com>
>>>>> 
>>>>> The git lfs pointer output was changed in:
>>>>> https://github.com/github/git-lfs/pull/1105
>>>>> 
>>>>> This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
>>>>> while Linux was pinned at 1.1 via GIT_LFS_VERSION.
>>>>> 
>>>>> The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
>>>>> it takes the latest homebrew version regardless.
>>>> 
>>>> Is this related to the very similar thread going on here:
>>>> 
>>>> http://thread.gmane.org/gmane.comp.version-control.git/291917/focus=291926
>>>> 
>>>> Thanks
>>>> Luke
>> 
>> 
>> On 20 Apr 2016, at 21:13, Ben Woosley <ben.woosley@gmail.com> wrote:
>> 
>>> Yep it's addressing the same problem - I developed this independently
>>> after having only viewed the github repo:
>>> https://github.com/git/git/pull/231
>>> 
>>> Things I like about my patch:
>>> 1) it maintains ongoing support for git-lfs 1.1 by retaining it in the travis CI
>>> 2) it's a fairly minimal intervention into the existing behavior
>>> 
>>> Lars how about adding my Travis changes to your patch?
>>> Here's a look at the CI output: https://travis-ci.org/git/git/builds/124105972
>>> 
>>> Best,
>>> Ben
>> 
>> 
>> Thanks a lot for your fix! It's great to see other people than
>> me actually using this feature :)
>> 
>> I already sent a v2 with LFS 1.x support, too:
>> http://article.gmane.org/gmane.comp.version-control.git/291993
>> Would you mind reviewing it, too?
>> Sorry for the duplicated work :-(
>> 
>> Your Travis changes are 100% correct and a very nice way to ensure we
>> support Git LFS 1.1 and Git LFS 1.2. Unfortunately we run all other Git
>> tests twice which increases the overall build time a lot (because we
>> can only run 5 build jobs in parallel with the free Travis CI plan).
>> I am not sure if testing an outdated LFS version justifies the increased
>> build times...
>> 
>> Best,
>> Lars
>> 
>> PS: Please see Junio's comment regarding top posting:
>> http://article.gmane.org/gmane.comp.version-control.git/291932

> On 20 Apr 2016, at 23:10, Ben Woosley <Ben.Woosley@gmail.com> wrote:
> 
> Thanks! Some thoughts:
Again, please see Junio's comment regarding top posting:
http://article.gmane.org/gmane.comp.version-control.git/291932

> 
> * One option on the Travis front would be to just test one combination
> of the 1.1 build - e.g. linux + clang + 1.1, so you'll stay within the
> 5 parallel builds while also having some coverage on lfs 1.1.
TBH I still think testing an outdated Git LFS version does not justify
+10 extra minutes of computing. Plus if we want to be consistent we would
need to do the same for LFS 1.0, 1.2, and for pretty much every other
dependency...  


> * It might be risky to match on contentFile when looking for the
> prefix - there could be expansions or other modifications applied by
> git-lfs between input and output. I would think it a bit safer to just
> match on the beginning of the line.
Agreed. I will incorporate this in my next version and CC you.


> * Have you guys thought about splitting out git-p4? It seems like a
> good candidate for an extension / add-on, and would remove the soft
> git-lfs dependency.
Yes, this was previously discussed here:
http://article.gmane.org/gmane.comp.version-control.git/276822/


Cheers,
Lars