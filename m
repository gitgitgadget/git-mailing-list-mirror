From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: A small Git bug
Date: Sun, 10 Apr 2016 18:34:34 +0100
Organization: OPDS
Message-ID: <6809717A50B04A2482A4F37492363698@PhilipOakley>
References: <1460301449.7971.4.camel@narod.ru> <CAOLa=ZTJydx5iXVRz0nxrQM0RgzN-xgTO-6KUjVDck5ApXe1Pw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git" <git@vger.kernel.org>
To: "Karthik Nayak" <karthik.188@gmail.com>,
	"Victor Porton" <porton@narod.ru>
X-From: git-owner@vger.kernel.org Sun Apr 10 19:34:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apJFy-0003tf-1R
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 19:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbcDJRef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 13:34:35 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:44354 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcDJRef (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 13:34:35 -0400
Received: from PhilipOakley ([92.16.240.233])
	by smtp.talktalk.net with SMTP
	id pJFoaDCaV0mUYpJFoaGhAz; Sun, 10 Apr 2016 18:34:32 +0100
X-Originating-IP: [92.16.240.233]
X-Spam: 0
X-OAuthority: v=2.1 cv=TInlMwRa c=1 sm=1 tr=0 a=w1kgAgviRxPwKHMxFvamow==:117
 a=w1kgAgviRxPwKHMxFvamow==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=79As6FxkAAAA:8
 a=TSbVqHtbAAAA:8 a=_0_ADerl8aiCGs3CeJoA:9 a=QEXdDO2ut3YA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfH5oMy8RJFkn0Ek/j9tIEtIRY/5fxtaU7GqXFvbY2T+sJLBhU+7ukETA4l2asADPEvB+W+QL4IkyJ52ITsbsc0c673U0q97om+6QeSptw/fdcV4WS0eG
 nuQNAJXg5Kjsva/OMDEziIJ6w9UO7x6wTyaUAsw4ATWv51iNKftWzTsdFpWU4Co1i9+mK/LK1ESP5KbL4+YuJonWJegZal59IBdGt+bMzKTIDL8e5TjUMiDm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291181>

From: "Karthik Nayak" <karthik.188@gmail.com>
> Hello,
>
> On Sun, Apr 10, 2016 at 8:47 PM, Victor Porton <porton@narod.ru> wrote:
>> I have three branches: master, prerelease, and devel.
>>
>> Suppose now we are in master.
>>
>> I often run the following command (in fact it is an alias, to save
>> typing):
>>
>> git push && git checkout prerelease && git merge master && git push &&
>> git checkout devel && git merge prerelease && git push && git checkout
>> master
>>
>> There is a small problem: After running this command my text editor
>> proposes me to reload changed files.
>>
>> So, it seems that the above command marks some files as changed. It is
>> wrong, because it is inconvenient a little to reload a file or two
>> every time after I submit the changes.
>
> Its more of intentional behavior than a bug. When you merge branches, the
> timestamp of the files involved are updated to reflect the merge.
>
> Your text editor seems to have picked up this change in the file's 
> timestamp as
> changes made to the content of the file.
>
Victor,
There is also a patch series in discussion [1] about doing these conflict 
free (hopefully) merges without the use of the worktree. This would allow 
you workflow to be re-coded so that the checkout dance never occurs and 
master is undisturbed, removing the editor's change logic from the problem.

[1] http://thread.gmane.org/gmane.comp.version-control.git/291007
--

Philip 
