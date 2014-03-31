From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd "git diff" breakage
Date: Mon, 31 Mar 2014 11:35:13 -0700
Message-ID: <CA+55aFzjqsMzQxAJAK0DUM0DepE_qQSzSXyN=i9juUyzySM8oQ@mail.gmail.com>
References: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
	<xmqq7g7a6x0g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUh3M-0002a5-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbaCaSfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:35:15 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:37167 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbaCaSfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:35:14 -0400
Received: by mail-vc0-f170.google.com with SMTP id hu19so8879420vcb.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WAFansq2OSnQxkbt4V0cdgh4nnTRS/VUOTfJqHE5DcQ=;
        b=rLhLa0ffyEKCrHyAg/KYk2MQPFkm0SLAjMddVoquM+KzyJ+/KW9MUPkefIYs9I1JFI
         2B3Qpzl1aecDRbWNo0VPeQjqJl/0we0TNQlv6wx6/t0/JPxdgo9EmHsvR1BQBmbbmZe+
         7xmV04WyOQLuM4oghxNxOQruPU2Gjmw12EtUQTrB6hE4/vUE2eTtbR4frS91ujpeat2V
         OGsrrYpBKpkIFmpO5xcCZzKYpn8nAPInyU5ixjupef1XtqCO/hBFr9ne5a1ydhTde+5L
         8DI3ZPJ4Zhi3dhfDzLWLLT8Vf9fN8mWuffUZAsm0jUq9pBuXWvKTZnv23DZCtuknnwyi
         9p6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WAFansq2OSnQxkbt4V0cdgh4nnTRS/VUOTfJqHE5DcQ=;
        b=P4yf1xgp4uNesDMAy8aabOJO28eIFgv/OVTmS8aTk0hJND8EmoOdjlwCFQBRZfUXDn
         MNC1cUSQccm52mGEGZsBQEy1FfCKY5tdzrwwtu4BvFTjzDjxiGr8H5G8XTBSrf7y3cWv
         OMvY2KeqPab0CneDpIT7dkkVILrFzBAZG+gKY=
X-Received: by 10.52.26.161 with SMTP id m1mr2473681vdg.24.1396290913767; Mon,
 31 Mar 2014 11:35:13 -0700 (PDT)
Received: by 10.220.13.2 with HTTP; Mon, 31 Mar 2014 11:35:13 -0700 (PDT)
In-Reply-To: <xmqq7g7a6x0g.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: qvJ-Rszbg-I6ccTgP79UdJ87f8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245506>

On Mon, Mar 31, 2014 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmph, interesting.  "outside a repository" is the key, it seems.

Well, you can do it inside a repository too, but then you need to use
the "--no-index" flag to get the "diff two files" behavior. It will
result in the same infinite error messages.

              Linus
