From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the origin of a config value
Date: Thu, 3 Mar 2016 08:38:01 +0100
Message-ID: <07435444-0C35-4615-A403-9E124AFC9427@gmail.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com> <1455873362-66998-5-git-send-email-larsxschneider@gmail.com> <56D723F0.7020106@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 08:38:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abNpu-00061p-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 08:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbcCCHiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 02:38:08 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34493 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbcCCHiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2016 02:38:07 -0500
Received: by mail-wm0-f47.google.com with SMTP id p65so21673630wmp.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 23:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxemS2lhapQrfbHYduiAwuvhL575XYjrCXzWCflX2Sc=;
        b=P4ro8xG6BCF4Wr1SLY3P93HbKv50JWAAExRqd/akfOGKYsxxr6JZl5Ahp1oM9FYcO/
         /O4dZ/6aiKQ77hxy2qPNdbrV6P3cvU0mJG4PsR1LyFdIoklHjiT0Bn7dxHGoTMesPdnG
         a8oLP9hrqlxhXLctxdX4r9g765sRODEyPVmmEZBikFzi/rnckA8USFGYlK6CFlaqp/ZY
         zuJyudidCxZ3lac0Q+FzcMXZkcOWH96H7P/ymXd2e7tLtT24Ui8dEZGO/yM1W0Fz494u
         RFBJqodkSoernyc5S4LBdwYPu6V2/fRFbxJxeDWgG6MQWKYOdUbtuQqZJL087W8IT0Je
         ExZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxemS2lhapQrfbHYduiAwuvhL575XYjrCXzWCflX2Sc=;
        b=A7yl0YlmShS8D7V/pFkbs9vkTFcewI8JNo5Ko1fGDmhuLySqiHNAII/XlTg0RHweK9
         +dfCSumm3tLetBkwJNcYSfD/4f9bZ8pcEhZTODzenAPWxYj6pKcQ+LKrlcu9lRErr9c0
         9t3tXessVl7vx1b+MuS44MBHXivOYqQKNNFzrx1mOmCbQ90abMyZ6ZDrl5IARsZczrlY
         kH6nHbgz65i/e5RxMFzhw+XdlXrBaaF7JzXdKC0sBAZBn8DghMRXBmtUkzbVH25j92Ge
         hE63BLhVAgW2wvN9dsi7p5ANbWH6JXipbeHWfZ35iswSB+UBznyPx7JoItjkqMYMTZ+D
         ui6A==
X-Gm-Message-State: AD7BkJK+Z4BxIttuTcmcVLcjANLoVWLvoh7dqXmPlsiiw8erwKMgn8bPRzvoS0ibyRZdww==
X-Received: by 10.28.194.68 with SMTP id s65mr1601253wmf.65.1456990684741;
        Wed, 02 Mar 2016 23:38:04 -0800 (PST)
Received: from [10.32.249.45] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id w11sm7555060wmg.21.2016.03.02.23.38.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 23:38:03 -0800 (PST)
In-Reply-To: <56D723F0.7020106@kdbg.org>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288168>


> On 02 Mar 2016, at 18:33, Johannes Sixt <j6t@kdbg.org> wrote:
> 
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
OK, I try to fix it that way.

> 
>> +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
>> +		file:.git/config	user.local=true
>> +		file:.git/config	user.override=local
>> +		file:.git/config	include.path=../include/relative.include
>> +		file:.git/../include/relative.include	user.relative=include
>> +		cmdline:	user.cmdline=true
>> +	EOF
>> +	git -c user.cmdline=true config --list --show-origin >output &&
>> +	test_cmp expect output
>> +'
> ...
>> +test_expect_success 'set up custom config file' '
>> +	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
>> +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
>> +		[user]
>> +			custom = true
>> +	EOF
> 
> This fails on Windows, because the shell cannot create a file containing a double-quote character.
> 
> IIUC, the test serves two purposes: (1) to test C-style quoting of the output and (2) non-standard configuration files. We'll have to separate that so that we can test at least (2) on Windows with "regular" file name. We cannot test (1) because the only case where quoting is used is when the file name contains a double-quote character.
OK, I will try to separate this and disable (1) for Windows.

> 
>> +'
>> +
>> +test_expect_success '--show-origin escape special file name characters' '
>> +	cat >expect <<-\EOF &&
>> +		file:"file\" (dq) and spaces.conf"	user.custom=true
>> +	EOF
>> +	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
>> +	test_cmp expect output
>> +'
> ...
>> +test_expect_success '--show-origin blob ref' '
>> +	cat >expect <<-\EOF &&
>> +		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
>> +	EOF
>> +	git add "$CUSTOM_CONFIG_FILE" &&
> 
> Is this dual-purpose as well or just re-using the files established earlier in the test suite?
Just re-using files.

Thanks for making me aware of the Windows problems. I can reproduce them with the Git for Windows SDK (super easy to setup, great work Dscho!) and I will try to fix them.

I am fairly new to the Git for Windows SDK (+ an inexperienced Windows user) and therefore I wonder if you can help me with the following questions:

(1) If I have a Git core branch with a some changes that builds and tests clean on Linux and OSX. How do I apply all the necessary Git for Windows specific changes to this branch?

(2) During my testing with Windows I noticed that the git config paths look funny by adding  ("\\" and "/"). I mentioned the problem in the Git for Windows forum:
https://groups.google.com/forum/#!topic/git-for-windows/zTv60HhfnYk
Duy suggested a solution in that thread. Is this the default way to deal with the paths? Would the list accept this solution?

(3) The tests on Windows seemed very slow to me. Are there tricks to speed them up? Did you try a RAM disk? If yes, how do you do it?

Thanks,
Lars