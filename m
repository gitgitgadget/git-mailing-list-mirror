From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Tue, 26 Apr 2016 11:20:58 -0700
Message-ID: <CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:21:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7bg-0001uF-1k
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcDZSVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:21:01 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36146 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbcDZSVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:21:00 -0400
Received: by mail-io0-f181.google.com with SMTP id u185so27823931iod.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=URJiwY6ycOiFUQ5dy5OSPARCkR91W5QSoed+c1VsP7A=;
        b=SakENRNldmwE+V1Ko7UGfX1bhskK9+DycokHYaN1AlgBXPPGKljZ8BCUzAkktdWBBx
         H1qEtmtZiViBwkWH26dYNpuiv6SHP4li9whpvcicsFYj/GpofeQAbJCtiUJ7GqBXfCDG
         THpGLTvgmUmpo4YKfhb30aNBtdOKAfPcPOeVCazEJP+mtSxD86ufySlxSXUw32YcbS7x
         iM9zuVEyOc/7M7qzectSu8BLTMtmi27zAUkd27RUrX2rFR3uG4+gNkQksuGcrS4jZ1U7
         lpbxLihmukHor/MBSgQ9le2l/oXNceZdQjdjBer04TCr43SIftk49e1djnEp2kiecqje
         IQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=URJiwY6ycOiFUQ5dy5OSPARCkR91W5QSoed+c1VsP7A=;
        b=ZW26l9/ob/vFnzo+0ks0lrD1z7TFOiWBnjHlRDOCF8QmJAvEvVYWSpQY76LuMoKMoF
         ic3du5670Us3bG6I397vb5jbf4XzAZjShoUHsMmeKuNQFWn4tYQ2M+O7SGEQ3v19Hl1/
         I9XqIFKaQQzLoK9xai0k6kM4I/5i8crgAX/SSrdOHA65yYX3lsFr7Z/rF9TA+Mh0h8q5
         FPMnaokMkp2N3AQu+0R6p1jQfWzjnmDfcbD5c45r8yGQhbJXLNDOrv00VNsYQyAwzTMs
         tE2ujsR+CU/zWNqL+R+LRN19xl2RNRZVR85/TJLTF9XvgekaFym8mlYDo8jWG2oI0ZOO
         UT9Q==
X-Gm-Message-State: AOPr4FXHN5EUmpsNG4pJMZW6TtBUjJe6MQ2w08W9nfCFRzHQaXaiD9h2je3vRIZpUU7FEtkNrwgt+NyiuNZ8BG4B
X-Received: by 10.107.174.205 with SMTP id n74mr5176147ioo.96.1461694859138;
 Tue, 26 Apr 2016 11:20:59 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 11:20:58 -0700 (PDT)
In-Reply-To: <xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292640>

On Tue, Apr 26, 2016 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     git checkout origin/master
>>     # toy around, do stuff
>>     git checkout -b new-shiny-feature
>>     git format-patch origin-master..
>>
>> Now I have set the format.useautobase option and then the `git format-patch`
>> fails with
>>
>>     fatal: Failed to get upstream, if you want to record base commit
>> automatically,
>>     please use git branch --set-upstream-to to track a remote branch.
>>     Or you could specify base commit by --base=<base-commit-id> manually.
>>
>> but as I indicated I want patches from origin/master onwards,
>> Could we make use of that information?
>
> As you indicated where other than in this e-mail?
>
> I think the way for you to indicate that desire expected by this
> series is to use "git branch" to set upstream of new-shiny-feature
> branch to origin/master.  Shouldn't that work, or is that too much
> work?

I can totally do that for longer series which require some back and forth.

But one-offs, such as typo fixes or other small things[1], for which I do
even have a local branch (i.e. checkout origin/master && fix &&
commit && send-email) this is another step that potentially bothers me.
Maybe I'll get used to it.

>From a UI perspective it seems logical to also check if the base
can be obtained from the patch range specifier. the message of
patch 2 focuses on the advantages for the maintainer and 3rd party
people. So I was just testing it as an individual contributor to ensure
it can be used easily. (People only use this once the benefits outweigh
the disadvantages. And as we do not have any advantage of it in Git,
the negatives need to be kept low?)

Thanks,
Stefan

[1] http://thread.gmane.org/gmane.comp.version-control.git/292634
