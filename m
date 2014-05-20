From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out
 to it from a local branch
Date: Tue, 20 May 2014 13:29:40 -0500
Message-ID: <537B9F14.3030403@gmail.com>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <1949847.AaDQEtxZHd@linux-wzza.site> <537B8BA9.7060207@storm-olsen.com> <2726779.MFtIaLB4b4@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arup Rakshit <aruprakshit@rocketmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 20:29:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmonJ-0000Ce-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaETS3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:29:42 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39303 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaETS3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:29:41 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so952215obc.16
        for <git@vger.kernel.org>; Tue, 20 May 2014 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=GfDFKD7dtN23x25KOzF/sa0px1vE+B80CrW6SzJZbwc=;
        b=cyyDAfMs14fhR1SxSvPn0YGhpJFubuP4znLmuZT7DE3OEwyF2Z4Des+C6rklox1n59
         mNl3s206i9538i7neTogdpjrw4wwlWLSeNTKQqYt6YxZSCBJQ06wk6WnQCq9GogDwUap
         I8SqZ9+u9iqf6aBFPN7/odCA/gG9sejJMJ/RcHdRSrZBo2dPrTEdadwriSHt3XEzvgiN
         +ItB6AVX28gTpkZxorgcuzOvo+Xk19uuTT8Bo8HXsSRGJQS2lKmglYydG9Q1yQVygH2M
         TPTDhu5H+LR/k3vndHpxfI2qp0E4agohPA4W8YRVHJ4dcONo1Yu+LfbF5502LLU7GTx6
         3keA==
X-Received: by 10.60.102.238 with SMTP id fr14mr22842347oeb.28.1400610581069;
        Tue, 20 May 2014 11:29:41 -0700 (PDT)
Received: from [10.3.3.221] ([199.227.34.94])
        by mx.google.com with ESMTPSA id z8sm50919811oey.5.2014.05.20.11.29.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 11:29:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <2726779.MFtIaLB4b4@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249721>

On 5/20/2014 12:20 PM, Arup Rakshit wrote:
> On Tuesday, May 20, 2014 12:06:49 PM you wrote:
>
>>
>> It never "came to the new branch", as it was never version controlled,
>> it was an untracked file left behind when you switched branches.
>>
>> Once you added it to the new branch, change_class, it became a version
>> controlled file,
>
> This is still  didn't get it. If an untracked file didn't come in the new
> branch, how would I able to add it to stage ? I am not getting this part. You
> are right, but I am not able to understand this one, my bad! :(

Ok, step by step:

You've created test.rd, that was never added to the git repo. (You never 
committed it to the master branch.)

 > ***********HERE I switched to a NEW Branch****************
 > Arup-iMac:arup_git shreyas$ git checkout -b change_class
 > Switched to a new branch 'change_class'
 > Arup-iMac:arup_git shreyas$ ls
 > git_1.txt test.rb

test.rd is untracked, so still there. Git doesn't touch untracked files.


 > Arup-iMac:arup_git shreyas$ vi test.rb
 > Arup-iMac:arup_git shreyas$ head -1 test.rb
 > class Fooo
 > Arup-iMac:arup_git shreyas$ head -2 test.rb
 > class Fooo
 >    def self.bar

You modified it


 > Arup-iMac:arup_git shreyas$ git commit -am 'changed the class name'
 > # On branch change_class
 > # Untracked files:
 > #   (use "git add <file>..." to include in what will be committed)
 > #
 > #test.rb
 > nothing added to commit but untracked files present (use "git add" to 
track)

You did nothing here..


 > Arup-iMac:arup_git shreyas$ git add test.rb
 > Arup-iMac:arup_git shreyas$ git commit -am 'changed the class name'
 > [change_class 2d40033] changed the class name
 >   1 file changed, 7 insertions(+)
 >   create mode 100644 test.rb

Your previously untracked file has now been checked in. It's no longer 
untracked, so now Git cares.


 > Arup-iMac:arup_git shreyas$ cat test.rb
 > class Fooo
 >    def self.bar
 >      12
 >    end
 > end
 >
 > Fooo.bar
 > Arup-iMac:arup_git shreyas$ git checkout master
 > Switched to branch 'master'

You switched back to master branch, which contains no test.rb (as it's 
clean and has never been committed to), so therefore Git removes the 
file, since the now tracked test.rb shouldn't be on the master branch.

-- 
.marius
