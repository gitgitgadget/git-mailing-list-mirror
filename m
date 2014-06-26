From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 00/11] add performance tracing facility
Date: Thu, 26 Jun 2014 08:11:44 +0700
Message-ID: <CACsJy8AoDJLMbhG82AMnt61hK_DoXQ16SY_M2J_XnUuTamv0qQ@mail.gmail.com>
References: <53980B83.9050409@gmail.com> <CACsJy8AV5GhB+7iHL11vAMvp=X2yeHgO-ejrtMQqGNG3z_ekBw@mail.gmail.com>
 <53AAE17A.7050500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
	Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBB3XGVWOQKGQEWJB7SJA@googlegroups.com Thu Jun 26 03:12:16 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBB3XGVWOQKGQEWJB7SJA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBB3XGVWOQKGQEWJB7SJA@googlegroups.com>)
	id 1WzyEZ-00034f-U7
	for gcvm-msysgit@m.gmane.org; Thu, 26 Jun 2014 03:12:16 +0200
Received: by mail-ie0-f183.google.com with SMTP id lx4sf521121iec.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Jun 2014 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=2Rv28BBf+Rwy6b0N8upu5wZGhS4yeonhCRs1TfjILds=;
        b=NrSGuiuOmlAoeVurOPVqjb9IS19IDGYz1cIuj2wRg53amumF8uFlJUFn312zt3Y46X
         2BPZzSjmiGNc26UKSDAm3yw0GA4nHLSmfz67myUQPgK2eNQJeFGD2XJS3PD33j3S/Irl
         9coFvDcJSXy7ZTr5hwU+qVEC4eDOrvrvkQV9D6Ul4QhKUMEuQ3lbdYbLYQ5dARC0+9qC
         lGB6jjtW65N8E2ljecBmhA7+PeQgZIqk/4Z5EajWAfVfp2qf6MjmgOeE1a3YrNCeQDmp
         pPoElp3DFOLc0JRiMvdb8NzuK0XDTpULXS6F6knsZxtO7AM5umcGvj621yqhtEFLs24x
         YAfg==
X-Received: by 10.50.124.8 with SMTP id me8mr11066igb.15.1403745135087;
        Wed, 25 Jun 2014 18:12:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.152.101 with SMTP id ux5ls67049igb.1.canary; Wed, 25 Jun
 2014 18:12:14 -0700 (PDT)
X-Received: by 10.68.209.130 with SMTP id mm2mr6458366pbc.3.1403745134240;
        Wed, 25 Jun 2014 18:12:14 -0700 (PDT)
Received: from mail-qc0-x22b.google.com (mail-qc0-x22b.google.com [2607:f8b0:400d:c01::22b])
        by gmr-mx.google.com with ESMTPS id x7si657482qcd.3.2014.06.25.18.12.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 18:12:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::22b as permitted sender) client-ip=2607:f8b0:400d:c01::22b;
Received: by mail-qc0-f171.google.com with SMTP id w7so2490457qcr.2
        for <msysgit@googlegroups.com>; Wed, 25 Jun 2014 18:12:14 -0700 (PDT)
X-Received: by 10.224.165.70 with SMTP id h6mr17463587qay.78.1403745134132;
 Wed, 25 Jun 2014 18:12:14 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Wed, 25 Jun 2014 18:11:44 -0700 (PDT)
In-Reply-To: <53AAE17A.7050500@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::22b
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252483>

On Wed, Jun 25, 2014 at 9:49 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 25.06.2014 16:28, schrieb Duy Nguyen:
>> On Wed, Jun 11, 2014 at 2:55 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.
>>>
>>> I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:
>>>
>>>  > GIT_TRACE=1 git stash list
>>>  00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
>>>  00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
>>>  00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'
>>
>> Can I have an (build-time) option to show <function>:<line> instead of
>> <file>:<line>? I know it's not supported by all compilers, which may
>> make support a bit cumbersome..
>>
>
> Is this really useful? <file>:<line> is unique, but <function>:<line> is not. E.g. in case of "hash_name:47" you'd have to guess if its the one in attr.c or name-hash.c...

It depends on your view. If I'm tracing a certain operation, function
names let me know roughly what's going on without looking at the code
because all (or many of) the names and their purposes are already in
my mind. But for publishing the traces, then I agree <file>:<line> is
better.
-- 
Duy

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
