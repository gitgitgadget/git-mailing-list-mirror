From: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>
Subject: Re: [PATCH 2/2] Makes _do_open2 set _gitdir to actual path
Date: Tue, 03 Feb 2015 11:00:41 -0500
Message-ID: <54D0F0A9.3080607@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>	<1422897883-11036-1-git-send-email-remirampin@gmail.com>	<1422897883-11036-2-git-send-email-remirampin@gmail.com> <CAFOYHZB_c3U9jpAq=jrGgMU+wMMf8w5D9iqLC9ccGC8S3hhXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIfuC-0004TC-H4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 17:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966161AbbBCQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 11:00:44 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:49291 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965669AbbBCQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 11:00:43 -0500
Received: by mail-qg0-f46.google.com with SMTP id i50so52784005qgf.5
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oDR5gurmUKTIxCwss+83jAFcFHUf485FFzTobBEBi8w=;
        b=RWXOeFaeeZ+zsUgtSn/v10nqmZMpKox+W4TR0GRo2axstrVdEWeyz2h15hC28zh7gi
         JzJbal+qkCFRmIN2JevqrjgqVfmTK3Cx6xnNKGH/++S9ost2QCMY8bGHSnRqm2n0SsN4
         W5bYhKrnTi4N6Gi+RA022PbUlsTOyC0WvM5Yke6XKuwhfJx+HLhizf1++3Ub6Q0Ia9Lm
         ZYYlFNhprjzaGcYDOnh/8z8BOg867WBvoi9yrIKpzMqbHQjGkvxS9b0XVWgnZr6vhnHv
         zjRRgPceJVhsVpx+E+sZ1s1oiHawTV27PqMBimcMHoMPxVXQkIBJDwzsHby+30wo89ab
         Ge5w==
X-Received: by 10.224.7.197 with SMTP id e5mr54841955qae.64.1422979243128;
        Tue, 03 Feb 2015 08:00:43 -0800 (PST)
Received: from [128.238.102.81] ([128.238.102.81])
        by mx.google.com with ESMTPSA id d3sm21625452qaf.13.2015.02.03.08.00.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2015 08:00:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAFOYHZB_c3U9jpAq=jrGgMU+wMMf8w5D9iqLC9ccGC8S3hhXZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263322>

2015-02-02 12:24 UTC-05:00, Remi Rampin <remirampin@gmail.com>:
>> -                       return [_is_git [file join [file dirname $path] $link_target]]
>> +                       set link_target_abs [file join [file dirname $path] $link_target]

2015-02-03 3:51 UTC-05:00, Chris Packham <judge.packham@gmail.com>:
> At this point link_target_abs is something like
> sub/../.git/modules/sub. It might be nice to normalize this with 'git
> rev-parse --git-dir' or even just (cd $link_target_abs && pwd). I'm
> not sure if tcl has anything built in that could do this kind of
> normalization.

There is 'file normalize' according to the docs. I can update the patch
if needed.
