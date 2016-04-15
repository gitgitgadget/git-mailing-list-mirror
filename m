From: Stefan Beller <sbeller@google.com>
Subject: Re: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 10:59:46 -0700
Message-ID: <CAGZ79kZifiEY1rg6KNFRnkOemjJhY9fFpxHmK0gB8fLh1siAxw@mail.gmail.com>
References: <5710A2D3.8090003@otterhall.com>
	<CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Albin_Otterh=C3=A4ll?= <gmane@otterhall.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar823-0000bW-S9
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbcDOR7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 13:59:48 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38726 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcDOR7r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 13:59:47 -0400
Received: by mail-ig0-f174.google.com with SMTP id ui10so29709675igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=4GZqazsAGY76+JRZvKYKQC0G+8pokqbKyr8Omp4Zeo4=;
        b=VdkzCl+XWfsAVSxVHfKASJro2r/SDjh87HM6FlCJZDhAn/umn53xBkuMc4z8fV+uCy
         ucMBdh4e3N9NK7Lusw2v8WZRofTgbhq31kce93Snghda3cZasBKcxhephphSIV5XgHCK
         Y0FfAVCmL+GWF6yXe8o7bYVxjfBXnNeb+sraV476JrB61bDRz/9gmBm9LOgm6Pfdt5JB
         R0SlFsmD/YKx9Cz6GIMgHMXF5CiPRELYPFXv/p5+/9l+dUCXePCBgmlMELiDenXy6fZ9
         aDkPdKn2D+1RKhhdaACAlFKgMVG+iQuXHW1int1gmAs/iBgEd02gTiBDHq5Ov27Ugint
         Bhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=4GZqazsAGY76+JRZvKYKQC0G+8pokqbKyr8Omp4Zeo4=;
        b=h0ph0vuB2WxMmI3RQpV87EP+jx0/i4kcIZfzao75OXX7L3XlNc7D25OP7J6pqQWinA
         YYffR0wcjMW1tCjgZ9b9QkOGI47wd1nO05n9kiS7bX3aSSG3H31QGvc1xv6cdrJSQOeN
         jHZ3hga5b/pBQpobwGVlMkuIC9apCqpVGIZ/VU7zAHktJQVyCxIet+K2twe1sF3n60uN
         dhk0lhlP6VJksThWIDt8xO/u5Av6WhjC8cTC4KxsBPs8dtTGM9X6JfEGIwYN9RxdFeWj
         ppaiDr5PUsU9NkVq3hCjwOL1AZ0ObgOp93VkUkGXB/qDQuEHC+vgohkwTzJBtN0+U9CQ
         ziKw==
X-Gm-Message-State: AOPr4FV/GAFfAxXt5ra8uKCJb7S1x2C1jfeLADD+W08jxQYhozxXcDxKSexoC0KLM27C1Q+UUAyOsLcurIdJJzh5
X-Received: by 10.50.217.130 with SMTP id oy2mr6682483igc.94.1460743186283;
 Fri, 15 Apr 2016 10:59:46 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 10:59:46 -0700 (PDT)
In-Reply-To: <CAGZ79kaN-s74cJkgOq3+7e57-BKevMr8pr=tAHVEpELetVYnTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291630>

On Fri, Apr 15, 2016 at 10:18 AM, Stefan Beller <sbeller@google.com> wr=
ote:
> On Fri, Apr 15, 2016 at 1:14 AM, Albin Otterh=C3=A4ll <gmane@otterhal=
l.com> wrote:
>> I've a submodule located in a subdirectory
>> ({git_rep}/home/{directory}/{submodule}), and I wanted to move the w=
hole
>> directory up a level ({git_rep}/{directory}/{submodule}). But when I
>> used 'git mv {directory} ../' the '.gitmodule' file didn't get modif=
ied.
>>
>> Best regards,
>> Albin Otterh=C3=A4ll
>
> Thanks for the bug report!
> Which version of Git do you use? (Did you try different versions?)

I think I can reproduce the problem. A regression test (which currently=
 fails)
could look like
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4008fae..3b96a9a 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
        echo content >file &&
        git add file &&
        git commit -m "added sub and file" &&
+       mkdir -p deep/directory/hierachy &&
+       git submodule add ./. deep/directory/hierachy/sub &&
+       git commit -m "added another submodule" &&
        git branch submodule
 '

@@ -475,4 +478,14 @@ test_expect_success 'mv -k does not accidentally
destroy submodules' '
        git checkout .
 '

+test_expect_failure 'moving a submodule in nested directories' '
+       (
+               cd deep &&
+               git mv directory ../ &&
+               git status
+               # currently git status exits with 128
+               # fatal: Not a git repository:
directory/hierachy/sub/../../../../.git/modules/deep/directory/hierachy=
/sub
+       )
+'
+
 test_done
