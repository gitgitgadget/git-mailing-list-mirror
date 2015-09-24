From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: t9819 failing
Date: Thu, 24 Sep 2015 21:29:01 +0100
Message-ID: <CAE5ih7-f3V2YSWW7FO-MxB6BPu7WjB93jDDFs5mKkzz2wDX0yA@mail.gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
	<954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com>
	<CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com>
	<F37BA8D8-6845-4C47-BBE2-3313685FD16F@gmail.com>
	<CAE5ih78m9RbD=s_12ckA+yzRP=fuiruF=kasUSFZEjUZZA21UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 22:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfD8k-00009U-7P
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 22:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbbIXU3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 16:29:03 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35324 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbIXU3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 16:29:02 -0400
Received: by oiww128 with SMTP id w128so47954217oiw.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HgX5VizMTOrpj2Rm2dBjXhXT5yFIpbZYp/cLSbPcGGU=;
        b=LBFLmwyqd2PWteNam4fsSSH6XuZTHCknAKwKrdmRVGMAYhPy82AH9p2Gf5ulZOwrax
         to1FdMdQtOmd8Qt22T57JEMoDyjEiM8zTzvdsBAnbQULPI8nkPOZX2mk23RNxdxhtoib
         ZeQurO7iHtcME+wCxiuwEuu3zA0wGd1kKLKAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HgX5VizMTOrpj2Rm2dBjXhXT5yFIpbZYp/cLSbPcGGU=;
        b=L1+ykLdOmfDe2wR4QnFwh7S8aJuHXN+Uz4bxmFriniqU1Ak9jO+64+OFJcQddcT1n+
         Yo41y7x7qUwoSEGIYhksGbC2hdEF6FfKvKq5TV35Nm5QFugy0btqOLzZJTma/LYdLSod
         k7uC8mqbF9bBQf3ANxjETZmZWE2xkKMtCnL91uJ1WeH7h8Hj1n0QiLfexxav2GD0Gyx5
         oAQNB9rLnlNBi81EivhZvMNo4IxZt2R5GjzNWo2Et40JpjUDG3j97zCJ+QXeSMlifMfn
         hmfKGuHFl8iuHxfGklYZwlC1zBhmxUhmhaZObL7KOPET3EA3ldeTqLhGxSVzUQ4IYc1m
         TphA==
X-Gm-Message-State: ALoCoQnEet1eJ9Uu+9skSiPT4Sjxsxl9gr8MkzhmtbSjDibKxuLMuVU6Eu1Hain5W2CC4hhSEltX
X-Received: by 10.202.211.10 with SMTP id k10mr983814oig.34.1443126541117;
 Thu, 24 Sep 2015 13:29:01 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 24 Sep 2015 13:29:01 -0700 (PDT)
In-Reply-To: <CAE5ih78m9RbD=s_12ckA+yzRP=fuiruF=kasUSFZEjUZZA21UQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278556>

OK, slight correction there - it now doesn't crash getting the disk
usage, but I think it still needs to be updated following the other
changes to case-handling.

Luke

On 24 September 2015 at 08:45, Luke Diamand <luke@diamand.org> wrote:
> On 23 September 2015 at 13:28, Lars Schneider <larsxschneider@gmail.com> wrote:
>>
>>> Here's the last bit of the crash dump from git-p4 I get:
>>>
>>>  File "/home/ldiamand/git/git/git-p4", line 2580, in streamP4FilesCbSelf
>>>    self.streamP4FilesCb(entry)
>>>  File "/home/ldiamand/git/git/git-p4", line 2497, in streamP4FilesCb
>>>    required_bytes = int((4 * int(self.stream_file["fileSize"])) -
>>> calcDiskFree(self.cloneDestination))
>>>  File "/home/ldiamand/git/git/git-p4", line 116, in calcDiskFree
>>>    st = os.statvfs(dirname)
>>> OSError: [Errno 2] No such file or directory: 'lc'
>>>
>>> Luke
>> Confirmed. What do you think about this fix?
>
> Works for me!
>
>
>
>>
>> Thank you,
>> Lars
>>
>> ---
>>  git-p4.py | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 1d1bb87..66c0a4e 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -3478,6 +3478,7 @@ class P4Clone(P4Sync):
>>
>>          print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
>>
>> +        self.cloneDestination = os.path.abspath(self.cloneDestination)
>>          if not os.path.exists(self.cloneDestination):
>>              os.makedirs(self.cloneDestination)
>>          chdir(self.cloneDestination)
>> --
