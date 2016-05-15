From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC v1 1/1] No duplicate CRLF rewrite warnings on commit
Date: Sun, 15 May 2016 02:15:15 -0400
Message-ID: <CAPig+cTrijGb5C1DRYTYtas0Rp5Fb34KmkxW5Fqb-T5-bdyD9Q@mail.gmail.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<1463292503-12559-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, adam@dinwoodie.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pKn-0006q5-1i
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbcEOGPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:15:17 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34111 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbcEOGPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 02:15:16 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so177468406iow.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=3LQNch123whO/5zwY3vl7zYxLF+W7Ejnhfrk1P5Y4kI=;
        b=Hrj/S6T1tUkJvxBBZyxqJAG5Q4TT9pTXa01CQFQ6NyPKP4i7PdwSG2Oi+Y/x/M3Vmz
         kduaiKhJvQimShPVUeVWI5uTYhXI+D7lUkHML8md1nQumSHHu6Gcz/+xU8UfWlL29rcS
         DYfb586MLTop5QmXDcQ8eCYg9DB9HK5oLBFq0F8d5anuD8apfTkLrUCXDkXdRbIUto+X
         1wrqcw7EOPUkzOb0aQHiQtnUn8qxaoN7fKChFH/DBUclzFkLMsJlQjJdKqJAqtmaoTEW
         BtGNupk29Z0KEIZXKklc6uzDH6oNO9hV67cIUmCNBi4hfupAsdgOi0ngTlRbJfA0q/yr
         OKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=3LQNch123whO/5zwY3vl7zYxLF+W7Ejnhfrk1P5Y4kI=;
        b=gKow4Xg7uEaU9P4RuroC6cL+15nJdLoS+d/DUzqU+f76z9JvffWX22g4EJ5zc//iME
         bnYkZ7t+E1glIAwwTlKW1Ij3JTeZ6I/KQGNojNvXpEYqA/JrZfj5Ixhpj7qp0Aolx/0/
         BdBQC+YehBJ3sfi57wJvhP0gK+hZNzNZSwnr02T4D6UsCTvriuadLXEyzrgIpSWLvDXE
         Qmc1pScTVGlDH1HVBtOZyoM+SyG3XDxTASNkwg1ZVGGslSLoTFS6FNL/MJG+4Sg8IKvF
         M3O+6LxqMyTMHwHhLjpJTP3W1JTwQzQtDgO03jvNJ9LaFfTb5LZFqJAHi2o6Dsv3ESom
         KnUg==
X-Gm-Message-State: AOPr4FXsYQLEk7DklbrI+a3aU0K54h03dy5djV0AwkAOtbb+9xp9Kx7ZQdq5/UvtBq8qpfTtQ7SUSfmhi1jk/Q==
X-Received: by 10.107.47.37 with SMTP id j37mr15468242ioo.168.1463292915443;
 Sat, 14 May 2016 23:15:15 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sat, 14 May 2016 23:15:15 -0700 (PDT)
In-Reply-To: <1463292503-12559-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: 7AX9Q8o5xI7nhswsjNby8K-8xW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294636>

On Sun, May 15, 2016 at 2:08 AM,  <tboegi@web.de> wrote:
> If .gitattributes are used to enable CRLF->LF rewriting,
> then commiting a file that would have its line endings rewritten,
> the "CRLF will be replaced by LF" warning is printed 2 times.
> A user expects it to be printed only once.
> The automatic rename detection by Git runs the conversion twice,
> suppress the warning in the second run.
>
> Reported-By: Adam Dinwoodie <adam@dinwoodie.org>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> @@ -86,6 +86,20 @@ test_expect_success 'safecrlf: print warning only =
once' '
> +test_expect_success 'safecrlf: print warning only once on commit' '
> +
> +       git config core.autocrlf input &&
> +       git config core.safecrlf warn &&
> +
> +       for w in I am all LF; do echo $w; done >doublewarn2 &&

I would typically say something about how you could instead use:

    test_write_lines I am all LF >doublewarn2 &&

but since you're just mimicking existing style in this script, I won't
mention it.

> +       git add doublewarn2 &&
> +       git commit -m "nowarn" &&
> +       for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr=
 >doublewarn2 &&

Likewise; note my silence.

> +       git add doublewarn2 2>&1 &&
> +       git commit -m Message 2>&1 | grep "CRLF will be replaced by L=
=46" >actual &&
> +       echo "warning: CRLF will be replaced by LF in doublewarn2." >=
expected &&
> +       test_cmp expected actual
> +'
