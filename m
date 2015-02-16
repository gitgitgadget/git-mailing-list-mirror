From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Mon, 16 Feb 2015 21:18:46 +0100
Message-ID: <54E250A6.4070605@gmail.com>
References: <54DBEAA5.6000205@gmail.com>	<xmqqbnkysygl.fsf@gitster.dls.corp.google.com>	<54DD2FDA.7030604@gmail.com>	<xmqqsieaog4a.fsf@gitster.dls.corp.google.com>	<54DD5A89.5080502@gmail.com> <xmqq61b5obla.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBI5BRGTQKGQE2OGX6VA@googlegroups.com Mon Feb 16 21:18:49 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBI5BRGTQKGQE2OGX6VA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBI5BRGTQKGQE2OGX6VA@googlegroups.com>)
	id 1YNS7z-0003Qt-5D
	for gcvm-msysgit@m.gmane.org; Mon, 16 Feb 2015 21:18:47 +0100
Received: by mail-wg0-f64.google.com with SMTP id z12sf3100945wgg.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 16 Feb 2015 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=RqYadHSiF6Cl/iXjS/CGmnG4ckpcYizNaBO7FDO2uzw=;
        b=RrDR2VVwmXbC4hYhxN6hZT/7ZnPHQm941nkmq097QrdpnbRCNpWMpq3/00QKNE04GP
         KLSoRWnelMfuyO7fnyYimusPQ18tkCwY/qYlQGCh+TmflQcl6CzxtSAEugQ2j/xz5aFt
         HIyyz/K7KUDVXnKkki//ToEakLdjoov46SYPXUf5y92UL+nhn/R5PtxXvMI6jeXb5rn6
         OsFeQrNvYomrv7PyRhyhpmWjWwuUXfHTf2xeQnWQGh+Q1XhnDjUswqFbTwv+v4ySZpSp
         oj75Rh9quHaKSe+1k1q9BuFKbfwcoZFAh5roCtu4VoXLp9PDudODr5G72tvt2XLxPk1T
         rVRQ==
X-Received: by 10.152.198.227 with SMTP id jf3mr47955lac.13.1424117926740;
        Mon, 16 Feb 2015 12:18:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.116.14 with SMTP id js14ls616659lab.69.gmail; Mon, 16 Feb
 2015 12:18:43 -0800 (PST)
X-Received: by 10.112.160.3 with SMTP id xg3mr3144021lbb.5.1424117923199;
        Mon, 16 Feb 2015 12:18:43 -0800 (PST)
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com. [2a00:1450:400c:c00::22e])
        by gmr-mx.google.com with ESMTPS id ew5si8333027wid.1.2015.02.16.12.18.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 12:18:43 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e as permitted sender) client-ip=2a00:1450:400c:c00::22e;
Received: by mail-wg0-x22e.google.com with SMTP id a1so31415974wgh.5
        for <msysgit@googlegroups.com>; Mon, 16 Feb 2015 12:18:43 -0800 (PST)
X-Received: by 10.194.200.68 with SMTP id jq4mr53190626wjc.128.1424117921842;
        Mon, 16 Feb 2015 12:18:41 -0800 (PST)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u18sm24307100wjq.42.2015.02.16.12.18.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 12:18:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqq61b5obla.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263917>

Am 13.02.2015 um 20:28 schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 13.02.2015 um 00:38 schrieb Junio C Hamano:
>>>
>>> We do have sec/nsec fields in cache_time structure, so I have
>>> nothing against updating the msysGit port to fill that value.
> 
> Having said that, we do not enable the NSEC stuff by default on Unix
> for a reason.  I'd expect those who know Windows filesystems well to
> pick the default there wisely ;-)
> 

Now I'm a bit confused about the discrepancy between racy-git.txt and
the Makefile.

Racy-git.txt explains that the nsec-part may be dropped when an inode
is flushed to disk if the file system doesn't support nsec resolution.
This was supposedly an issue with the Linux kernel fixed back in 2005.

In my understanding, this means that git would see the file as
changed and re-check the content (i.e. it will hurt performance).

IOW: Git may be slow if the file system cache has better file time
resolution than the on-disk file system representation.


However, the Makefile has this to say on the subject:

# Define USE_NSEC below if you want git to care about sub-second file mtimes
# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
# randomly break unless your underlying filesystem supports those sub-second
# times (my ext3 doesn't).

Am I missing something? Is there anything in Git that will actually
"break" with USE_NSEC if the OS / file system doesn't support it
(rather than just being slow)?

History:
* The Makefile comment was added in 2005 (bdd4da59), along with a
  comment in read-cache.c explaining the issue (i.e. flushing to disk
  will clear the nsec field).
* The comment in read-cache.c was removed in 2008 (7a51ed66),
  seemingly dropping USE_NSEC support entirely.
* USE_NSEC support was re-added (without the read-cache.c comment) in
  2009 (fba2f38a).


Regarding the Windows situation: I've just verified (on my Win7 x64
box) that file times obtained through a variety of APIs (GetFileTime,
GetFileAttributesEx, GetFileInformationByHandle, FindFirstFile) are
consistent and properly rounded to the file system's resolution (e.g.
10ms / 2s for FAT). This is even if the file is still open and I try
to SetFileTime() to unrounded values.

So I think enabling USE_NSEC should be fine on Windows.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
