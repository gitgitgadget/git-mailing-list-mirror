From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any
 file, fail properly
Date: Mon, 16 Dec 2013 23:06:50 -0500
Message-ID: <CAJYzjmcAXiMhKA1XKgnd6V1bto=VDCR6xwKaO6f+UAe-S7hGzA@mail.gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqq4n68o647.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 05:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vslvs-0002I8-5m
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 05:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab3LQEGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 23:06:52 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38252 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3LQEGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 23:06:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so5820948obc.33
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 20:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9dWzx/+itslqjRW+ZqLTUMN5O170Fful77NBXWxnwYc=;
        b=D1lcixibdhtJtOhO0jR+i+l0Qd6o+Vg+lxQksnRHg1IgX7ZDYBvOU6Z6ap56JcSqLw
         /Zbp3tbl14LHfH0nbxrI/xR14MuwpGlgR2vYsNNPsHh642wGDzeNKkD4JQLGTC01EDYU
         gtO0gmn01hi7PRRFt7F/fq+C3Dbav+rjXBzh0iDnBoGj9WYvT6FOwQomCBBMMcWU771u
         VA3zwcaiXDuv8/u0UgQoUuqGGXZVh/KDcJL8PvYFqJ0PwESglDUrhGqj3Qsn9SkkkSe7
         DYyWUn3wD73kcabDnVv/aAHcEJjPkaEeBeJURhTO9G9i6Pi9R9OS7THbTl+A5nvaF0pb
         +iNg==
X-Received: by 10.60.115.164 with SMTP id jp4mr14564977oeb.19.1387253210745;
 Mon, 16 Dec 2013 20:06:50 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Mon, 16 Dec 2013 20:06:50 -0800 (PST)
In-Reply-To: <xmqq4n68o647.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239373>

On Mon, Dec 16, 2013 at 4:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:

>> +test_expect_success 'unreadable orderfile' '
>> +     touch unreadable_file &&
>> +     chmod -r unreadable_file &&

>   - this test probably needs restricted to people with sane
>     filesystems; I think POSIXPERM prerequisite and also SANITY
>     prerequisite are needed, at least.

Hmm, yeah, you've got a point; now that I think more carefully, the
most FAT can do is something like "chmod -w", nothing with the "r"
permissions.  Oops.
