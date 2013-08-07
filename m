From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 7 Aug 2013 11:48:13 -0700
Message-ID: <4E3DEEB7-2664-40CC-84C2-9B0A64534AEA@gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com> <4EE8B37B-F6A1-4BC4-9151-8546868E60A5@gmail.com> <20130807183117.GC2337@serenity.lan>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Aug 07 20:48:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V78mU-0001jY-EB
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 20:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab3HGSsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 14:48:18 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39416 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab3HGSsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 14:48:17 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1701440pdi.13
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=DiyecmKpdsxQONJwAuBQWbnRWflNEmgzjYLQbIlX3N4=;
        b=qxxc9N3w0XSJStrcSrFmuEPY89tQEXWo4B4dF9+FhtpxkP6Uo8o0reaQKxq2vZpQNK
         ebtuHtvBtEom3MxpnUi9gtzdS7JtnK/y50v05r1MuubwCMgtRzrjlm17EcpjIWMEUoG6
         NIk1pB/6BjMudyOZGDzOabqj+tk2DFgvw4iTJAMCE3YrmHQCkjWGapYgxtuLawVZ4BOQ
         I8MHVz25EW8C+LQs5hBjhE/N5ATYKopiOYNkLiVcnTfxY/A/kbaQi7vo7+/8XSlS7DSj
         wekdsISPtZiF2VnSrLhg98+b+3n+nWEr0EpnTg+zuwzEKnbMLWZoXD5qeRR69ozPSkzZ
         6BJw==
X-Received: by 10.68.211.233 with SMTP id nf9mr2189204pbc.26.1375901297178;
        Wed, 07 Aug 2013 11:48:17 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id cn2sm5307419pbb.35.2013.08.07.11.48.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 11:48:16 -0700 (PDT)
In-Reply-To: <20130807183117.GC2337@serenity.lan>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231843>

On Aug 7, 2013, at 11:31, John Keeping wrote:
> On Wed, Aug 07, 2013 at 11:01:57AM -0700, Kyle J. McKay wrote:
>> On Aug 7, 2013, at 09:00, Ramkumar Ramachandra wrote:
>>> Hi,
>>>
>>> This is the difference between whatchanged and log:
>>>
>>> diff --git a/whatchanged b/log
>>> index fa1b223..004d9aa 100644
>>> --- a/tmp/whatchanged
>>> +++ b/tmp/log
>>> @@ -1,4 +1,4 @@
>>> -int cmd_whatchanged(int argc, const char **argv, const char  
>>> *prefix)
>>> +int cmd_log(int argc, const char **argv, const char *prefix)
>>> {
>>>       struct rev_info rev;
>>>       struct setup_revision_opt opt;
>>> @@ -7,13 +7,10 @@ int cmd_whatchanged(int argc, const char **argv,
>>> const char *prefix)
>>>       git_config(git_log_config, NULL);
>>>
>>>       init_revisions(&rev, prefix);
>>> -       rev.diff = 1;
>>> -       rev.simplify_history = 0;
>>> +       rev.always_show_header = 1;
>>>       memset(&opt, 0, sizeof(opt));
>>>       opt.def = "HEAD";
>>>       opt.revarg_opt = REVARG_COMMITTISH;
>>>       cmd_log_init(argc, argv, prefix, &rev, &opt);
>>> -       if (!rev.diffopt.output_format)
>>> -               rev.diffopt.output_format = DIFF_FORMAT_RAW;
>>>       return cmd_log_walk(&rev);
>>> }
>>>
>>> Should we remove it?
>>
>> I use it all the time.  Is there some log option to get exactly the
>> same output?  It doesn't appear that there is.  The closest looks  
>> like
>> "log --name-status" but it omits the modes and hash values.
>
> Is it not identical to "log --raw --no-merges"?
>
> A quick test says "mostly", but whatchanged doesn't show empty commits
> whereas log does seem to; e.g. in git.git:
>
>    diff -u <(git whatchanged) <(git log --raw --no-merges)

That's probably close enough, but if that's all "whatchanged" does is  
basically be an alias for "log --raw --no-merges" that skips commits  
with no changes then the help for whatchanged ought to mention that.

I still think "git whatchanged" is a lot clearer than "git log --raw -- 
no-merges" though.
