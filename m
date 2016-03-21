From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 21 Mar 2016 09:53:15 +0100
Message-ID: <E8903192-701B-4EE9-B804-B612EAAF7A45@gmail.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com> <1455873362-66998-5-git-send-email-larsxschneider@gmail.com> <56D723F0.7020106@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 09:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahvaX-0002xa-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 09:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcCUIxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 04:53:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33309 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbcCUIxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2016 04:53:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id x188so20286524wmg.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 01:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EF080uuJe1g2TGOOZ0NU8jNe/tL67gwSZuhdCpLnx/8=;
        b=Cc6nEhpPpzQJc+o+hZZL/kPrs/upo0qBsvUP8HljjxAY1Vbap55AegB8U5nQZ8BLUi
         Qw5vLAwqf9oHUWtR3mlL2Pgtzsa2xf7BHlmFnEjhwcT/FiqnQk+h6ZRHWngmYNqm+mcQ
         /bT5+l1ylrfxGqhOUuynRlQc+bRou8jEfs5cN98MuHDn+8rahBEajUzqhGucCFLE1AAq
         fsaA3J1s3u2CSXkg/x5ZD7YtBfyVeiHRRgLUzg97B+OGinm1Nn1mMMEW2g2JB79XchD6
         aFAtKaLSZ7QIhdfSomNVkTa2R0t/cvbAgmLcCVhVAk0MrPBtJ428tsoPraZIlcjwC+K0
         ub6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EF080uuJe1g2TGOOZ0NU8jNe/tL67gwSZuhdCpLnx/8=;
        b=cZDGyhiKSnqXsVeZXszd6WQv7y+k952xH+DaApgNpnsxEKAIT9luTzgd487FVc1QQ/
         owpuaXcT4IkhYQBX7RiKgmWpTtV9/sPYD0bdIBDC98QoppLNEb9w8LsuFPTeh8jFNOj+
         +fMQoFc98Q/rVJRUGgWpsXA0f9cqPp5IKT8ApvAfqsLaKlO0LziduWC+w/qrMGIHHR99
         fPf7PJg75W/KnmP7BVwLRnRKXT3aXjMUwOBp9n0GtklU34KTg479yX20coPJcJYTgvFK
         uEwAnEbLNSvsbkZcKhxjco6YbLtJpRzX2N3YBS7V2ljKWWb59YAB/wDJdiyYGqn9K0nU
         fGyQ==
X-Gm-Message-State: AD7BkJJ6kzETPa1NPZappeaMPUuvgX9s1qmpX6BO3NkA5OiJAY7wJlimzThiKsIzMHC9ew==
X-Received: by 10.28.177.134 with SMTP id a128mr13342127wmf.55.1458550399514;
        Mon, 21 Mar 2016 01:53:19 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA303.dip0.t-ipconnect.de. [80.139.163.3])
        by smtp.gmail.com with ESMTPSA id ei9sm24194751wjd.40.2016.03.21.01.53.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 01:53:18 -0700 (PDT)
In-Reply-To: <56D723F0.7020106@kdbg.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289411>


On 02 Mar 2016, at 18:33, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 19.02.2016 um 10:16 schrieb larsxschneider@gmail.com:
>> +test_expect_success '--show-origin with --list' '
>> +	cat >expect <<-EOF &&
>> +		file:$HOME/.gitconfig	user.global=true
>> +		file:$HOME/.gitconfig	user.override=global
>> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> 
> On Windows, this injects POSIX-style paths in the expected output, but git.exe produces mangled paths (with a drive letter). The pattern I use to fix this is:
> 
> 		file:$(pwd)/.gitconfig	user.override=global

I tried that. But then I get this (notice the quotation marks):

-file:C:/git-sdk-64/usr/src/git/t/trash directory.t1300-repo-config/.gitconfig  user.global=true
+file:"C:\\git-sdk-64\\usr\\src\\git\\t\\trash directory.t1300-repo-config/.gitconfig"  user.global=true

I am struggling to find a solution that works on all platforms. I see the following options:

(1) I detect MINGW in the test run and check for another string
(2) I detect MINGW in the test run and change the output of 'git config --show-origin' with a regex (e.g. replace \\ with / and remote quotation marks)
(3) I change the implementation of 'git config --show-origin' similar to [1]

If I get your comment ($gmane/288203) correctly then (3) wouldn't be a good idea.
I think (1) would be the cleanest way. Do you have some pointers for me how
Git for Windows solved these kind of problems in the past?

Thanks,
Lars

[1] https://groups.google.com/forum/#!topic/git-for-windows/zTv60HhfnYk
