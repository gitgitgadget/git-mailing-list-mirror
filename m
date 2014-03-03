From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Help needed: Tests failed While replacing char array with strbuf
 in bulk-checkin.c
Date: Mon, 3 Mar 2014 17:14:26 -0500
Message-ID: <CAPig+cTE7wtVpmjN=p56JB6avL8n_JhDC6g5cAgGcmJQ8OVt5g@mail.gmail.com>
References: <d7af2c2bcb07168ecddedf76ca776cd0@students.iiit.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: "saikrishna.sripada" <saikrishna.sripada@students.iiit.ac.in>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:14:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKb85-0006F4-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbaCCWO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:14:28 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:38589 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbaCCWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:14:27 -0500
Received: by mail-yk0-f172.google.com with SMTP id 200so12138235ykr.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 14:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=M7nzd3dq9n9sVHu/pYT3wX2uLhVFpE1kVoEU4PnfrHo=;
        b=C6nVM0LNQNOylmjgHjx9HXaYCM2lm2ct5ESbvo9VUfsYCtaLMdkoSJX2NShd/LXpge
         o2Z79Rwib9fBWZlj9H86uTUrcMfMjBLkL3NAjb5++VrFaKYA/5cyrTGRPfFC5HDFuyde
         5U8zdpmRAgYmFpD687z3W+QYT9enBCvgoANhpcqUvEbqQgwGK676wGeCB11vormdBoUb
         RnD1LVJQYzXvrykUur7fpfs5Ntynr9szTWkVnoxz13oVVKxerefyK7wwaf92Q/VkLi2X
         N0pXRtkhFOC+NsN5cjmdf7NHpVSKxVz71Ye6046RawoQeQ9W8Fvqodyj5Zw5/Ond1uEb
         hNtA==
X-Received: by 10.236.120.147 with SMTP id p19mr24821286yhh.6.1393884866904;
 Mon, 03 Mar 2014 14:14:26 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 14:14:26 -0800 (PST)
In-Reply-To: <d7af2c2bcb07168ecddedf76ca776cd0@students.iiit.ac.in>
X-Google-Sender-Auth: bHfqgAVQ5cgwk8NlSn7XHMzRo5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243276>

On Mon, Mar 3, 2014 at 4:11 PM, saikrishna.sripada
<saikrishna.sripada@students.iiit.ac.in> wrote:
> I am trying do complete the microproject 4, inorder to apply to GSOC.
> I have made the below changes:
>
> https://gist.github.com/anhsirksai/9334565
>
> Post my changes compilation is succes in the source directory.
> But when I ran the tests[make in t/ directory] my tests are failing saying
>
> "
>  free(): invalid pointer: 0x3630376532353636 ***
> ======= Backtrace: =========
> /lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x2b5f3b540b96]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x4fb829]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x47d425]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x4064ad]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x405a04]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x404cbd]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x2b5f3b4e376d]
> /home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x405109]
> "
>
> Can some one please help me with the memory allacation and strbuf_release()

Read the microproject text carefully and _fully_. It provides the clue
you need to understand the problem.

    Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for
    handling packname, and explain why this is useful. Also check if
    the first argument of pack-write.c:finish_tmp_packfile() can be
    made const.

If, after making a closer examination of the mentioned functions, the
problem still eludes you, ask here again.
