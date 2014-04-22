From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 10:09:49 -0700
Message-ID: <5356A25D.1050001@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com> <5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch> <53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch> <53559020.1050407@gmail.com> <53558f6269f91_640076f2f08f@nysa.notmuch> <857g6h5ssh.fsf@stephe-leake.org> <5356996d12ede_3e5aed7308e5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Stephen Leake <stephen_leake@stephe-leake.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 19:10:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WceCt-00062l-5c
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbaDVRKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:10:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54007 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbaDVRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:09:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so5170289pab.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ePUOBJzIYhclTcKpKsvPrA5cP5OShIJBzthVg0vsrJw=;
        b=zRjjDbcuDJIxv+gEsF+2P5DlKzdmwTvd/r5IxFZuwFbnFxBWjM23DGySLoPcOeOHgl
         Te+gLUnwv6WcGL+IcFX9C8RrWROpIyqEqkVQldSJ+0MdO/kOGRdwpdjLdcPY/KyX+O49
         e5CQ1edccegSkVnMr+NMIjhSZdxMM5rLwtN1y+FAUgflKNgj2+atzc1xeZghHwmwa6mW
         vcWTySmQ0SmHflooZ/iwXJwRfozpI1tUf/3rWz0J3xC6LV0+fjCRw+s9P7xAznGFU5Jd
         qQfCbO8/+KzVIB5saJRVfiozw5glhUa3w9MVFrXS3i6IWD2nhN4rsmInV6IklmOBTvq2
         OGyg==
X-Received: by 10.68.194.134 with SMTP id hw6mr45573968pbc.49.1398186598787;
        Tue, 22 Apr 2014 10:09:58 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ry10sm151454565pab.38.2014.04.22.10.09.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 10:09:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <5356996d12ede_3e5aed7308e5@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246753>

On 4/22/2014 9:31 AM, Felipe Contreras wrote:
> Stephen Leake wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Ilya Bobyr wrote:
>>>> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
>>>>> Ilya Bobyr wrote:
>>>>>
>>>>>> Also, most have names that start with either "pre-" or "post-".
>>>>>> It seems reasonable for both "pre-update-branch" and
>>>>>> "post-update-branch" to exist.
>>>>> I don't see what would be the point in that.
>>>> Do you see the point in the other hooks doing that?
>>> Yes, there a reason for the existance of those hooks. Now tell me why would
>>> anybody use post-update-branch instead of pre-update-branch?
>> I have a branch which should always be recompiled on update;
>> post-update-branch would be a good place for that.
> And why would pre-update-branch not serve that purpose?

"pre-" hook could be used, but if the hooks is not supposed to prevent
the operation, it seems reasonable to put it in the "post-" hook should
one be available.
For example, for clone and branch that would mean that that the branch
sections are already created in .git/config, but for "pre-" hooks,
should be find the right spot, configuration could probably be absent
just yet.

I do not think that someone is objecting adding just the "pre-" hook first.
But it seems unlikely that one can envision all the possible use cases
to say that "post-" hook would never be useful.
