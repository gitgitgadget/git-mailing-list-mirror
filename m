From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] Improving performance of git clean
Date: Tue, 14 Apr 2015 23:33:46 -0400
Message-ID: <CAPig+cTnhCQHOvAkNyXxD+KKjs5bwSRTARvwZeLHqJ4tPq3FVg@mail.gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 05:33:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiE5N-000574-39
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 05:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbbDODdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2015 23:33:53 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34848 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220AbbDODdr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 23:33:47 -0400
Received: by labbd9 with SMTP id bd9so23106348lab.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 20:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BS7ZTSKDcjrmL8M2bLTdU3BZvRAg3hfaMP/jsx4g8ZQ=;
        b=eMIsbVhTJRJ5KP8RvHT2U7ot+jJ87oPG+hEZaGuCaw8E+394GN5z84yzvgqg8wZUGT
         f46lROiamiaKDyC1pVPfuNqo16YWgwQWvT2ewFngSvjHohURwJkgqh398ZbdxSTGkrM8
         bwd3VLsRTmvIQjDZze+yjQcANNs+JIpC3OQLdpq8ljvziPfphM46ZaiUvvLzvBaj+biT
         Q7scu4XGQppF3+eIGc6FtdAaEHB06Ng+QF+sup1s92vyagJYfyLI8vmF+X2ICVucH1kj
         KEuwzrH05hZfxlsSRgxI/nauP9B+XBxQoRbsCXmpSTVXyl468Xrcz3ldyzz30DkDF/89
         Edpg==
X-Received: by 10.152.170.136 with SMTP id am8mr22289390lac.102.1429068826297;
 Tue, 14 Apr 2015 20:33:46 -0700 (PDT)
Received: by 10.114.25.193 with HTTP; Tue, 14 Apr 2015 20:33:46 -0700 (PDT)
In-Reply-To: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
X-Google-Sender-Auth: SAA-m4GT2VVgGYpUv5TR4S0lL8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267181>

On Sat, Apr 11, 2015 at 12:43 PM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
> v1 of the patch can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=3D=
266839
>
> changes in v2:
> * fixed commit message,
>   "p7300: added performance tests for clean"
>   change to:
>   "p7300: add performance tests for clean"
> * simplified test code
> * removed non portable ls -A in test
> * removed non portable $(seq ) in test
> * fixed missing " || return $?" in test
> * fixed missing sub shell for 'cd' command in test
> * fixed broken && chains in test
> * added assert new clean.c:is_git_repository to guard against
>   negative array index
> * use size_t instead of int for strbuf->len
>
> fixes held back for cleanup patches:
> * fixed existing broken && chains
> * added assert in existing code to guard against
>   negative array index
>
> Thanks to Eric Sunshine and Torsten B=C3=B6gershausen for the very he=
lpful
> review!

Thanks. This version looks much better.
