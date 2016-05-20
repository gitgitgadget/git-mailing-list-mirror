From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Fri, 20 May 2016 11:12:27 -0700
Message-ID: <CAGZ79kaBjHXGNxR_6WNWMtmBm0H_QCpHGciM7B1yY1yJ3S23wA@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
 <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com> <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
 <xmqq1t4wfyv4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:12:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oua-0001OW-CX
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbcETSMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:12:30 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35685 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcETSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:12:29 -0400
Received: by mail-ig0-f170.google.com with SMTP id bi2so142259398igb.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ArDX7ob+03yg6pTCulhqjJw8CsnJbxBbf4ch1VwWypk=;
        b=GptZlSyGy8AoUOWipToVdcMwnvyDvTJXtPDNS/NMlkUUCz2yxfo5kNqjZUexy8mAlB
         FsKbiJnB8hS1jdc3l/qzG3mNC4NN/yPHMpyBXs2kGvwpIuKxH4Ckb/aLeAV8ytcqwIWj
         A+xNtxVItbufX2HXNy8F1NKk0xqbZi1oikKu0kOsMFcR5sCq9/Oe0EZaTT3RKUVKxx0c
         ksKAbfcZ4vDbIukvH6rQ4WZHiJAnQc8mpSiNUF51jPGYJ9pK8JrIxcZS39t2WTVkaNVf
         oaNy/F7Dx8IE21y6SulRn0jX9V4H52+3wcDRFcgvrsu4fajIosl2k38CSaBkRs4g1UTa
         0f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ArDX7ob+03yg6pTCulhqjJw8CsnJbxBbf4ch1VwWypk=;
        b=P3Zpy7ls/4OrX3HDpmck93tFSZXRICIiFF5YWl93d0n75qSCrxopXr1iCFfgMkGWHQ
         FUV9FckJq1XwwDdiK6L17/IpWd9O1sTyVEm5n6LLi+4bM2Ws2VadCX8aucAUixx7gzxU
         B3K3QI06GDfH/nC1zyOIFTT8R36uFiCRAfz2RYEN6xDsxFUYs17S9hfNnX3q0jbhs8yU
         NhenLsf3vyik5YxCLPIsqZSQ/g8lly2Mm0Lq82BZkSPHAul7yE0NptFS8II1po0O/KtO
         6Ik76+4Fl2a7yuIjnwAKyLnS4vhrEoVwWzCgLSlXrm8+vhJ5kj2R+vHc8IYr4738h+Iw
         r87Q==
X-Gm-Message-State: AOPr4FUJoKb8nZMr4D3Fo3alj/V8KUB2D68zWcKDVqFukw1wQjmYaOBJCeRO6NiRKDisGJw+e6OyWY/ekSIzghf4
X-Received: by 10.50.250.165 with SMTP id zd5mr4221498igc.85.1463767948193;
 Fri, 20 May 2016 11:12:28 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 20 May 2016 11:12:27 -0700 (PDT)
In-Reply-To: <xmqq1t4wfyv4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295196>

On Fri, May 20, 2016 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Right. But upon finding the new name for clone, I wondered why
>> this has to be submodule specific. The attr pathspecs are also working
>> with any other files. So if you don't use submodules, I think it would be
>> pretty cool to have a
>>
>>     git clone --sparse-checkout=Documentation/ ...
>
> It would be cool, but arent' "sparse" and the various existing
> status "submodule" has very different things?

Yes they are. In one of the various "submodule groups" series I
proposed a "defaultGroup" which allows commands to ignore
some submodules. That was conceptually the very same as a
"sparse checkout, just for submodules", i.e. the submodule is
initialized and has a directory as a place holder, but most commands
ignore its existence.

We decided that was a bad thing, so now I think of a light weight
"submodule.updateGroup" which holds a pathspec and is only
used for "submodule update" commands that have no explicit
pathspec given. (That setting would be set via "git clone
--submodule-pathspec <pathspec>")

>
>  - A submodule can be uninitialized, in which case you do get an empty
>    directory but you do not see .git in it.
>
>  - A path can be excluded by the sparse checkout mechanism, in which
>    case you do not get _anything_ in the filesystem.

Yes, but isn't that one of the minor issues?

>
> So "git clone --sparse-exclude=Documentation/" that does not waste
> diskspace for Documentation/ directory may be an interesting thing
> to have, and "git clone --sparse-exclude=submodule-dir/" that does
> not even create submodule-dir/ directory may also be, but the latter
> is quite different from a submodule that is not initialied in a
> superproject that does not use any "sparse" mechanism.
>
> Besides, I think (improved) submodule mechanism would be a good way
> forward for scalability, and "sparse" hack is not (primarily because
> it still populates the index fully with 5 million entries even when
> your attention is narrowed only to a handful of directories with
> 2000 leaf entries; this misdesign requires other ugly hacks to be
> piled on, like untracked cache and split index).
>
> I do not think we want "submodule" to be tied to and dependent on
> the latter.

Ok I just wanted to probe how much resistance I get here as an
indicator of how much more work that would be.

Besides I think (improved) sparse mechanism would be a good way
to not confuse users between submodule scalability and single
repo scalability. ;)

We don't have to keep 5 million things in the index there, but we can
stop on the tree/directory level, i.e. if a whole directory is excluded
That's all we'd need to keep a record of, no?

As a user I'd prefer to be exposed to as few concepts as possible,
and adding yet another concept of sparseness is not a good thing
IMHO, so I'll try to keep it simple there.

Thanks,
Stefan
