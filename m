From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 42/44] ruby: remove GIT_PAGER from environment
Date: Sat, 28 Sep 2013 18:33:38 -0500
Message-ID: <CAMP44s0v5tj=e1o0tze00OzRM1YNuMU9YaVvtav02Eoj8+O-nw@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
	<1380405849-13000-43-git-send-email-felipe.contreras@gmail.com>
	<524765DE.9030009@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 01:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ41L-0003R1-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 01:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab3I1Xdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 19:33:41 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:46213 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab3I1Xdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 19:33:39 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3305302lab.13
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MVLQJftyliUIrDurUnzUq7Fav5roPvqV1mtzBmhrMQA=;
        b=WdiJ/VBCVtbr78IIe3B7m7OdEA8NEU9MdKh/PvCbqhBJGaO+BORDx4SGs3/AwglpGk
         yv4YmV5byZ8em1etvCnpIFLXaxrZAqkzfngn0N9Z7ayzfYqHkaQvMKIXEZYY9ls4kVLA
         Fo0qEdO82u63TuwOGGmq57G9VH/Bh+5lV4nk9ZdQ/T67eQrBuAuhYkDvko3xOskkqJ8J
         CGl1huJMHdcww4CUmGtZSycoqN+Aa81VlqbimU3tBA55ACUNsMyYXc8cwfiVb2nz1hHI
         Tb2xcL9vOIF6K8cwtiwijEBUmm0dqun88tLxhseH/G4/k/yRai1oUhTrKPOFLkmtL9F2
         oW+g==
X-Received: by 10.112.57.49 with SMTP id f17mr15306449lbq.26.1380411218146;
 Sat, 28 Sep 2013 16:33:38 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 16:33:38 -0700 (PDT)
In-Reply-To: <524765DE.9030009@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235571>

On Sat, Sep 28, 2013 at 6:27 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> On 09/29/2013 12:04 AM, Felipe Contreras wrote:
>> We are not calling any git commands any more.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  git-request-pull.rb | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/git-request-pull.rb b/git-request-pull.rb
>> index fde8d1a..941ff72 100755
>> --- a/git-request-pull.rb
>> +++ b/git-request-pull.rb
>> @@ -2,8 +2,6 @@
>>
>>  require 'date'
>>
>> -ENV['GIT_PAGER'] =
>> -
>>  patch = nil
>>
>>  def usage
>>
>
> Could this be squashed into the patch introducing the ENV?
> (I assume that patch is among the 44 patches?)

It could be, but when ENV['GIT_PAGER'] was introduced, there were 'git
foo' commands being called, so they would get a different $GIT_PAGER
if we do so, which would be a change from the original script.

To be honest I don't know what that code is trying to achieve, but to
err on the side of caution I'm leaving the code close to the original.

-- 
Felipe Contreras
