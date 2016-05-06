From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Fri, 6 May 2016 17:30:08 +0700
Message-ID: <CACsJy8BbWyw37sQkAq-B_De87N3XzZA9A1fm1A8A7MzfPBtdrw@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
 <xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com> <CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
 <xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 12:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayd1x-0005XI-6x
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 12:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcEFKak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 06:30:40 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34065 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbcEFKak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 06:30:40 -0400
Received: by mail-lf0-f52.google.com with SMTP id m64so126343274lfd.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pzRObFCej+GgX2+3pUNENPdC/SUcXnANAq6QiUneQPQ=;
        b=UsmMTAIjVMwQLzt8zgksxzH/5Krhf8UqwobCP6oNvpNazwu3PQAghXN26W3inZXyQ/
         Q60gbUevCo+Z9C/MiHzxm/ZLCWp2KhCWyXedWo02nSdS8SGj6lPQm6UQ8iAPNI7VVg4O
         mcfuDJ6YNVPtCJKYXBwelkKHUuxAn9uluh8R43p4k/5LDPUIGVmoT0MAgUReniwNA0Nf
         prvtMCVK7fcelGEdYs0MNdBqEVuFpU5qmopInIEHk1BfzQjZy96ia+1kCEo5VSEFImgB
         CybwTRE+xeWSZnulJvg7o6GPkdnycrqxYz0WilDjpsgKpztPjC5oDmigsdOlAfpRtNbL
         FJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pzRObFCej+GgX2+3pUNENPdC/SUcXnANAq6QiUneQPQ=;
        b=dcfnQaOaNmgNuNUxkFV3c+ReETjJkY0z28VrRZ5OIEuQhQTfZ/jipZDyh0py8gL/NE
         p0jKnotJlxJGcFBEjRRtN7OGVyb9jh62FX6M/Wf6fVGgwP+VTXasz5C8E8prglQRhsb5
         klThum6Y3D+oT70F4091stK9F6vxwHF1JxkU97cKuSmzK86K+DrhQxNkVzfeWcrjH+Df
         5jOFEfJ5J+TsE4Ud+GpMBHs9a06Ka+6e4ZCdGQw5B9/y5hob7vyhyos+/shrAdHcOfrd
         7CiSnieEcj5/E19OtzoIRQDkUmPsmw3CIlnGD6Z8Hur0c0xgPuL7Ed7gSFTfvwHGdQ7K
         CiSA==
X-Gm-Message-State: AOPr4FXl/3S/tCN+w05E+7gId+BeOmrAScmHMcVncxchLyaTBFhW3trkn1374V83lK4kRdOMTA+chkEJkvxHvA==
X-Received: by 10.112.54.132 with SMTP id j4mr9528375lbp.3.1462530638373; Fri,
 06 May 2016 03:30:38 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 6 May 2016 03:30:08 -0700 (PDT)
In-Reply-To: <xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293758>

On Fri, May 6, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I wonder if the patches mentioned have something to do with the "git
>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>> repository in some way?

The same functionality is added in 8745024 (parse_pathspec: support
stripping/checking submodule paths - 2013-07-14) so if it didn't fail
to notice that before 5a76aff1a6 and did after, it's a bug.

>>
>> Which is considered a feature now. Maybe we should add tests for that?
>>
>> http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
>
> That is a bug, plain and simple.  Duy any ideas where we went wrong?

I vaguely recall this symptom. It has something to do with the index,
the check we do requires a gitlink in the index, I think. So if the
gitlink entry is not in the index, our protection line fails. I think
doing all this at pathspec level is wrong. We should wait at least
after read_directory() is done, by then we have a lot more info to
decide.

> I think we already have code to avoid adding beyond symlinks.
> "git add deep/in/the/tree" should refuse if deep/in is a symbolic
> link (and happens to point at a directory that has the/tree in it).
> We used not to catch that long time ago, but I think we fixed it.
>
> The logic and the places to do the checks for "no, that thing may be
> a directory but is an unrelated repository" should be the same.
-- 
Duy
