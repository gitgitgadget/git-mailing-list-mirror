From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] show-ref: place angle brackets around variables in usage string
Date: Sat, 29 Aug 2015 15:09:20 -0600
Message-ID: <CAMMLpeTsL-_e=oGjuqjS5KfBcmd1UKfCOPXmjhaPFv8+qGzRng@mail.gmail.com>
References: <1440821924-4289-1-git-send-email-alexhenrie24@gmail.com> <47B9DE8756F943C0A0985F41D093340F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>, pclouds@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Aug 29 23:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVnNi-0004fx-7C
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 23:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbbH2VJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 17:09:42 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36950 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbH2VJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 17:09:41 -0400
Received: by wicfv10 with SMTP id fv10so39461540wic.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xQ2g6gZJE9gyLLwv2/9i+LEllxvxHWYQsyylF5LGOLc=;
        b=jxpHiBDQrgV7EewVLnIXFb6ets2/XCOJP1Sf+Bu/7hJzc4qvPxm4I51eHKcn6+Qcd1
         XNJ4OyxM4p4gTikbeE5fnxfOLwWv68xRis6H9AQHBwIqUw9DDT6bmEBDqJGMCy4kuJh+
         Kngzhdg4D7sBtZFNhTBZ3u6TIBVulbTSuQKbpm7ML/42lQcjcMRCwQYHhVjInanxOdnW
         AqQsMzna6bfJqaJTRtxbme0ZKhJ2ouzlAoGNNP4vtlr+EMGO0seUDmBojQszfJYn4kro
         CbOVsVsv+2l1Ck56ZqZmlt/sXvdPektGPX+DWgi+YXiijkWS/MqIXcOx+8glVv0K39GX
         isBw==
X-Received: by 10.194.108.232 with SMTP id hn8mr17983784wjb.154.1440882580209;
 Sat, 29 Aug 2015 14:09:40 -0700 (PDT)
Received: by 10.28.51.137 with HTTP; Sat, 29 Aug 2015 14:09:20 -0700 (PDT)
In-Reply-To: <47B9DE8756F943C0A0985F41D093340F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276794>

2015-08-29 4:21 GMT-06:00 Philip Oakley <philipoakley@iee.org>:
> Should the '<' stdin redirection be shown?
>
> It looks (at first glance) as if this gained a double '< <' at the beginning
> of 'ref-list', rather than being a clean indication of the redirection.
> Perhaps change 'ref-list' to 'ref-list-file' for a slight improvement in
> clarity - this it's only occurance, and the redirection would best match a
> file.

This syntax occurs in three other places in Git:

git cat-file (--batch | --batch-check) [--follow-symlinks] < <list-of-objects>

git check-attr --stdin [-z] [-a | --all | <attr>...] < <list-of-paths>

git hash-object  --stdin-paths < <list-of-paths>

So if we need to say <ref-list-file> for clarity, we should also say
<object-list-file> and <path-list-file> for these other commands.

I think the most sane thing to do is to commit this patch as-is, and
then someone can submit a separate patch to reword all four usage
strings for increased clarity.

-Alex
