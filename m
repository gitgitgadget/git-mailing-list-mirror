From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees
 for plugins?)
Date: Sat, 06 Jun 2015 23:26:18 -0700
Message-ID: <5573E40A.3020502@gmail.com>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com> <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Repo Discussion <repo-discuss@googlegroups.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Luca Milanesio <luca.milanesio@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 08:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1U2P-0001eB-A2
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 08:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbbFGG0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2015 02:26:23 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34858 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbFGG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 02:26:22 -0400
Received: by qkhq76 with SMTP id q76so62385002qkh.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=agZUELGaCdq36LOxavdZ+9wbun6qpA9Ob0XIW1m3trg=;
        b=BcKdIFdkmPMUaJL8HzzEZoAQOQITHLyOwxK89GlZHwcB96U3F2xvTT9YAUGx7AycHA
         vb0/LwEjJDnrx68P1VUey/3Vzh61yGMTnDXslZQoR2oLquVVya+RpYiQrFctSeZWc9KH
         EJOLoKNm3hKfpQEJ+lHbctF9eXrMtz537KPJV/hE81m2gWmWd9fARxKi6jlujjguys5l
         7TN5FnCeVQGhfUlvSeSEbYN0/IdEAtQ1cRzN9gM+UC7FD2TvJh0ciSsP7e6MLo+hWq3J
         2JGqcUs+Spkp7lsEKuWpwaTo9Q6CXAN1Nt1mbCWFjC2PM0cockf8lyqf/ZgxeannWm7z
         t5bQ==
X-Received: by 10.229.224.202 with SMTP id ip10mr13527790qcb.14.1433658381804;
        Sat, 06 Jun 2015 23:26:21 -0700 (PDT)
Received: from [192.168.2.5] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id 84sm6280578qha.47.2015.06.06.23.26.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 23:26:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270958>

On 06.06.2015 12:53, Luca Milanesio wrote:
> Thank you Phil, you anticipated me :-)
>=20
> Luca.
>=20
>> On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
>>
>> On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com=
> wrote:
>>>>
>>>> Some devs of my Team complained that with submodules it is
>>>> difficult to see the =E2=80=9Cfull picture=E2=80=9D of the differe=
nce
>>>> between two SHA1 on the root project, as the submodules
>>>> would just show as different SHA1s. When you Google
>>>> =E2=80=9Csubtree submodules=E2=80=9D you find other opinions as we=
ll:
>>>>
>>>> Just to mention a few:
>>>> -
>>>> https://codingkilledthecat.wordpress.com/2012/04/28/why-y
>>>> our-company-shouldnt-use-git-submodules/ -
>>>> http://blogs.atlassian.com/2013/05/alternatives-to-git-su
>>>> bmodule-git-subtree/
>>>>
>>>> To be honest with you, I am absolutely fine with
>>>> submodules as I can easily leave with the =E2=80=9Cextra pain=E2=80=
=9D of
>>>> diffing by hand recursively on submodules. But it is true
>>>> that it may happen to either forget to do a git submodule
>>>> update or otherwise forget you are in a detached branch
>>>> and start committing =E2=80=9Con the air=E2=80=9D without a branch=
=2E
>>
>> ...
>>
>>> Ideally, as a "git clone --recursive" already exists, I would like =
to
>>> see a "git diff --recursive" that goes through the submodules as we=
ll :-)
>>>
>>> Something possibly to propose to the Git mailing list?
>>
>>
>> I've worked on git diff --recursive a bit myself, along with some
>> simpler use cases (git ls-tree --recursive) as POCs. I think some of
>> the needs there begin to have ui implications which could be
>> high-friction. I really want to finish it someday, but I've been too
>> busy lately at $job, and now my experiments are all rather stale.
>>
>> It would be a good discussion to have over at the git list (copied).
>> Heiko and Jens have laid some new groundwork in this area and it may
>> be a good time to revisit it.  Or maybe they've even moved deeper th=
an
>> that; I have been distracted for well over a year now.
>>

Glad you're working (or planning to) working on submodulues. This is
also on my todo list for the next months as well.

I'd review stuff in that area if you're looking for reviewers.

Stefan

>> Phil
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
