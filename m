From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: t9819 failing
Date: Thu, 24 Sep 2015 08:45:22 +0100
Message-ID: <CAE5ih78m9RbD=s_12ckA+yzRP=fuiruF=kasUSFZEjUZZA21UQ@mail.gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
	<954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com>
	<CAE5ih78x+jnW3+4d5q5dJidt4LXWV=hMgJTEfsC2dUBLout1Aw@mail.gmail.com>
	<F37BA8D8-6845-4C47-BBE2-3313685FD16F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 09:45:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf1Dw-0000Om-E4
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 09:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbbIXHpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 03:45:23 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33965 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbbIXHpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 03:45:23 -0400
Received: by obbda8 with SMTP id da8so52292981obb.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2NuBmYO+cb4q+p3dcyfai2JY8KPYP0N6EiPeAk6N9xI=;
        b=OEKuIlbOFVyJihOK+VtPJldUlDH9UTLZAdS+wazswJQlprlqdrb+0dLHyLTfagOZRS
         zYnzAk1xbfnNuTYNkfZCo8+AHLzYO1UX8W1/9EUodIZz0/Cjl5fKBZV+ixJo7FKwk5tm
         7v65iz1p1HpazM5SbBTlHFBDxQYmrK7s96ecc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2NuBmYO+cb4q+p3dcyfai2JY8KPYP0N6EiPeAk6N9xI=;
        b=IqumhxsAIwuJ6D1a9cD4iq6v3Xq5yQjTKLMUHCtC2q0rL52YsAyt8Molm5Sge0/xn3
         SCd7NVDfJAXVltL2g/UlW9I7ItmFzZY1h6N4qw3Se4nH33hWr8eaCOLd20AWlvIM7tSr
         qbttfX7/qRXumpxcjS1yIfw9+sWcI6jiuOoXfIZLcriaHjg8ezEz6n3/AfbK7JjvGz51
         igcjN+U6uu6ur3hdgCHcEs56Pqv8n5HIcUoa3Iq6lgsMiA0SaDO8bFKLfabnIPEGkmLd
         wNMPDglu33pMbONXChRq6jEQ1UAjwfqdUY0kappJDJIOZtu3Y63e3sA7lvG/y3IzOEAX
         gJwA==
X-Gm-Message-State: ALoCoQn9JZc3iiLN+h/2TiSrkK1S6qWFP3HzpDz0EF/Sr8ccF2omTWZHHWWsFWAuYoG/Z49aLpNR
X-Received: by 10.182.19.167 with SMTP id g7mr21149765obe.13.1443080722392;
 Thu, 24 Sep 2015 00:45:22 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 24 Sep 2015 00:45:22 -0700 (PDT)
In-Reply-To: <F37BA8D8-6845-4C47-BBE2-3313685FD16F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278537>

On 23 September 2015 at 13:28, Lars Schneider <larsxschneider@gmail.com> wrote:
>
>> Here's the last bit of the crash dump from git-p4 I get:
>>
>>  File "/home/ldiamand/git/git/git-p4", line 2580, in streamP4FilesCbSelf
>>    self.streamP4FilesCb(entry)
>>  File "/home/ldiamand/git/git/git-p4", line 2497, in streamP4FilesCb
>>    required_bytes = int((4 * int(self.stream_file["fileSize"])) -
>> calcDiskFree(self.cloneDestination))
>>  File "/home/ldiamand/git/git/git-p4", line 116, in calcDiskFree
>>    st = os.statvfs(dirname)
>> OSError: [Errno 2] No such file or directory: 'lc'
>>
>> Luke
> Confirmed. What do you think about this fix?

Works for me!



>
> Thank you,
> Lars
>
> ---
>  git-p4.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 1d1bb87..66c0a4e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3478,6 +3478,7 @@ class P4Clone(P4Sync):
>
>          print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
>
> +        self.cloneDestination = os.path.abspath(self.cloneDestination)
>          if not os.path.exists(self.cloneDestination):
>              os.makedirs(self.cloneDestination)
>          chdir(self.cloneDestination)
> --
