From: Phil Hord <phil.hord@gmail.com>
Subject: Submodules as first class citizens (was Re: Moving to subtrees for plugins?)
Date: Sat, 6 Jun 2015 13:49:14 -0400
Message-ID: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: lucamilanesio <luca.milanesio@gmail.com>, 
	Repo Discussion <repo-discuss@googlegroups.com>, Git <git@vger.kernel.org>
X-From: repo-discuss+bncBDYMHBPJ3QORBLXFZSVQKGQE3GZVC5A@googlegroups.com Sat Jun 06 19:49:38 2015
Return-path: <repo-discuss+bncBDYMHBPJ3QORBLXFZSVQKGQE3GZVC5A@googlegroups.com>
Envelope-to: gcvr-repo-discuss@m.gmane.org
Received: from mail-vn0-f61.google.com ([209.85.216.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <repo-discuss+bncBDYMHBPJ3QORBLXFZSVQKGQE3GZVC5A@googlegroups.com>)
	id 1Z1IDx-0007UV-5A
	for gcvr-repo-discuss@m.gmane.org; Sat, 06 Jun 2015 19:49:37 +0200
Received: by vnbg129 with SMTP id g129sf24206234vnb.0
        for <gcvr-repo-discuss@m.gmane.org>; Sat, 06 Jun 2015 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Z+fYzSE6SqyA14qyk2MwaV4qrxTgWR4+g7F0UKTAGGQ=;
        b=vk45ZGfxObrTVqd0F/Zri1uC+BoqGwyjNHl6blW/kQgFc/o0p5cE6wb5oDJKO/xLUZ
         sNw/e1A1ve2UMsvUeB37U+8tB5xNGysq/EAUijjVvwtVtTvsDfi7tWo0gjgI31gaKt8T
         haXPNPXi9HXFEqo/MQVTTydLeLzx6T63ZjY0O7iV81ZbJmlpT43IzLdh+BJLMQYYIjnb
         WiPQVl6qSBREgBmFgR5uhfNy8qzo0EuwK3xVNTWX4BuhCXCanXos02QrmNxREoWbqhlf
         Pq8Ckywj9VME4esD16orXHrv979KkZuKU7G515c7K7RrAyPtCC4BBmW4+OxR7Zf5wVru
         iMaQ==
X-Received: by 10.140.21.111 with SMTP id 102mr115073qgk.4.1433612976365;
        Sat, 06 Jun 2015 10:49:36 -0700 (PDT)
X-BeenThere: repo-discuss@googlegroups.com
Received: by 10.140.38.116 with SMTP id s107ls2173486qgs.20.gmail; Sat, 06 Jun
 2015 10:49:34 -0700 (PDT)
X-Received: by 10.129.41.204 with SMTP id p195mr8267105ywp.7.1433612974682;
        Sat, 06 Jun 2015 10:49:34 -0700 (PDT)
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com. [2607:f8b0:4002:c01::22b])
        by gmr-mx.google.com with ESMTPS id z7si553468yhc.2.2015.06.06.10.49.34
        for <repo-discuss@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 10:49:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of phil.hord@gmail.com designates 2607:f8b0:4002:c01::22b as permitted sender) client-ip=2607:f8b0:4002:c01::22b;
Received: by yhan67 with SMTP id n67so28613545yha.3
        for <repo-discuss@googlegroups.com>; Sat, 06 Jun 2015 10:49:34 -0700 (PDT)
X-Received: by 10.129.106.133 with SMTP id f127mr7298108ywc.8.1433612974564;
 Sat, 06 Jun 2015 10:49:34 -0700 (PDT)
Received: by 10.37.106.198 with HTTP; Sat, 6 Jun 2015 10:49:14 -0700 (PDT)
X-Original-Sender: phil.hord@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of phil.hord@gmail.com designates 2607:f8b0:4002:c01::22b
 as permitted sender) smtp.mail=phil.hord@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list repo-discuss@googlegroups.com; contact repo-discuss+owners@googlegroups.com
List-ID: <repo-discuss.googlegroups.com>
X-Google-Group-Id: 540870184241
List-Post: <http://groups.google.com/group/repo-discuss/post>, <mailto:repo-discuss@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:repo-discuss+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/repo-discuss
Sender: repo-discuss@googlegroups.com
List-Subscribe: <http://groups.google.com/group/repo-discuss/subscribe>, <mailto:repo-discuss+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+540870184241+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/repo-discuss/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270939>

On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com> wrote=
:
>>
>> Some devs of my Team complained that with submodules it is
>> difficult to see the =E2=80=9Cfull picture=E2=80=9D of the difference
>> between two SHA1 on the root project, as the submodules
>> would just show as different SHA1s. When you Google
>> =E2=80=9Csubtree submodules=E2=80=9D you find other opinions as well:
>>
>> Just to mention a few:
>> -
>> https://codingkilledthecat.wordpress.com/2012/04/28/why-y
>> our-company-shouldnt-use-git-submodules/ -
>> http://blogs.atlassian.com/2013/05/alternatives-to-git-su
>> bmodule-git-subtree/
>>
>> To be honest with you, I am absolutely fine with
>> submodules as I can easily leave with the =E2=80=9Cextra pain=E2=80=9D o=
f
>> diffing by hand recursively on submodules. But it is true
>> that it may happen to either forget to do a git submodule
>> update or otherwise forget you are in a detached branch
>> and start committing =E2=80=9Con the air=E2=80=9D without a branch.

...

> Ideally, as a "git clone --recursive" already exists, I would like to
> see a "git diff --recursive" that goes through the submodules as well :-)
>
> Something possibly to propose to the Git mailing list?


I've worked on git diff --recursive a bit myself, along with some
simpler use cases (git ls-tree --recursive) as POCs. I think some of
the needs there begin to have ui implications which could be
high-friction. I really want to finish it someday, but I've been too
busy lately at $job, and now my experiments are all rather stale.

It would be a good discussion to have over at the git list (copied).
Heiko and Jens have laid some new groundwork in this area and it may
be a good time to revisit it.  Or maybe they've even moved deeper than
that; I have been distracted for well over a year now.

Phil

--=20
--=20
To unsubscribe, email repo-discuss+unsubscribe@googlegroups.com
More info at http://groups.google.com/group/repo-discuss?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Repo and Gerrit Discussion" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to repo-discuss+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
