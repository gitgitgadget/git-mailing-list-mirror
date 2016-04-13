From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 13:34:55 -0700
Message-ID: <CAGZ79kYj+4_6BsrcRRzsvdp_FcRG9VuiJ1tLjSo3D5_uWe2nfQ@mail.gmail.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<56FE8898.20906@ramsayjones.plus.com>
	<CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
	<570E9C46.6080905@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:35:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqRVA-0003TO-1k
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 22:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbcDMUe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 16:34:57 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34798 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbcDMUe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 16:34:56 -0400
Received: by mail-io0-f178.google.com with SMTP id 2so83905428ioy.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tSTsWy7HeS4trMx2N/lf0bA1Pknrw7QEKzoXbjf5oCw=;
        b=VKVGm00TJzvz+ss9+gWLK06rM12qlOp7FyZTtdineSdkdfy1A1fygPjZ2dukExLkEv
         F1hmWIKURV/3iI6zDRLd2ThMWIqtNIBQmfsXv1LFNWhqJ298btyWy9GFmx6Qb9DT5ATE
         qwVfqDna7+JrhNyYiR43cSNUN9GZGschmLFdz3CjuhGu8mOolXfFtlxeGm05g97mE4FG
         2c/vHtkYzYcUplK2Q6hiy7FCWWfE/wmn7mSxTUTlmMwXXr2vwBSVhZJELXu9+34EbVqk
         9+R9p+nsfMerR9dMrVZvhlMbcIMfSwCOPqyTixHLwvy1ywxQXFoemJlcHA3bwADs9Bvt
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tSTsWy7HeS4trMx2N/lf0bA1Pknrw7QEKzoXbjf5oCw=;
        b=TEwOziqCaabYbRUG+OtTb8yU7X0QBW77f9PkMBf3PsGNpoLp1xE+nn2JWgTWGYxa1n
         0690Hc3h5to9FjGMVEeVOUgtV1ATYBdZXixvtX3vYy99wOzkq0Tw6Nvnxh4LPmSN8cTE
         ZDjQa4WjkOR+T3PcIV34IC3RtUS6iYoyg98Nv49aT/JkN6aPjjMk2g3MHZmvPCx7OnAN
         0G4PpjJRkgPWVJP9xRoLXdPa9fPNrCwkbdmVV1+hwZfb+3MJ9ThjuHC1u67igHSl2Nq6
         a0lJjh+f3BAcWrm3Rh8OeFIOb+L/WADIBNgPAswC97hNHuaVbSgcwzTMGkZOlRVKfGKi
         OHBg==
X-Gm-Message-State: AOPr4FWXauVm04BRJ5eAhm46KWKAkBrFGpQvZ0sskh4ERRlImVFwggt2n8jMZ72mWrE2SfNySFlzI1MEkxGTW39N
X-Received: by 10.107.184.8 with SMTP id i8mr12280831iof.96.1460579695688;
 Wed, 13 Apr 2016 13:34:55 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 13:34:55 -0700 (PDT)
In-Reply-To: <570E9C46.6080905@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291481>

On Wed, Apr 13, 2016 at 12:21 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 12/04/16 16:58, Stefan Beller wrote:
>> On Fri, Apr 1, 2016 at 7:41 AM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>
> [snip[
>
>>>> -     }
>>>> +     sm_gitdir_rel = strbuf_detach(&sb, NULL);
>>>
>>> ... this is good, but ...
>>>
>>>> +     sm_gitdir = absolute_path(sm_gitdir_rel);
>>>>
>>>>       if (!is_absolute_path(path)) {
>>>> -             /*
>>>> -              * TODO: add prefix here once we allow calling from non root
>>>> -              * directory?
>>>> -              */
>>>> -             strbuf_addf(&sb, "%s/%s",
>>>> -                         get_git_work_tree(),
>>>> -                         path);
>>>> +             strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
>>>>               path = strbuf_detach(&sb, 0);
>>>
>>> ... can you please fix this up.
>>>
>>> Thanks!
>>>
>>> ATB,
>>> Ramsay Jones
>>
>> Looking at the current code of origin/sb/submodule-helper-clone-regression-fix
>> we do not have this issue there, but I'll keep it in mind for a resend.
>
> Hmm, actually, the above change wasn't the original culprit (as I thought), but
> a different instance of the same fault. :-D
>
> I've lost track of which version is now in 'pu' (currently @ 45a4edc "Merge branch
> 'sb/submodule-init' into pu"), but sparse is still warning:
>
>       SP submodule.c
>   submodule.c:256:43: warning: Using plain integer as NULL pointer
>
> So, the fix looks like:
>
>   diff --git a/submodule.c b/submodule.c
>   index 5d1238a..4cc1c27 100644
>   --- a/submodule.c
>   +++ b/submodule.c
>   @@ -253,7 +253,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
>                   return NULL;
>           case SM_UPDATE_COMMAND:
>                   strbuf_addf(&sb, "!%s", s->command);
>   -               return strbuf_detach(&sb, 0);
>   +               return strbuf_detach(&sb, NULL);
>           }
>           return NULL;
>    }
>
> Also, I note that t7406-submodule-update.sh test #4 is failing.
> (looks like absolute vs relative paths)
>
> ATB,
> Ramsay Jones
>

Ok fixed this instance here, too.
I'll hunt down the path issue now.

>
>
