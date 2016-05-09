From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Mon, 09 May 2016 19:12:53 -0400
Organization: Twitter
Message-ID: <1462835573.24478.53.camel@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	 <1462832134.24478.49.camel@twopensource.com>
	 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
	 <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:13:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azuMH-000269-5q
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 01:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbcEIXM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 19:12:57 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33134 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbcEIXM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 19:12:56 -0400
Received: by mail-qk0-f172.google.com with SMTP id n63so103826094qkf.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MUZhkC8EIOiTCuZ8JVAShhb4+hIf902jnl0kjewNFpM=;
        b=iSyp4yV3LsTJancS4GZBW8RvidpHiMV1+KIOPYydaGzrwEjmEDySw0HhzLhxtllMJs
         Alv9hmnR9AwX3+RvpGeibfYPfsQotrDB4mkkGQ2dBnrWDVv85c31hvteqVInbearU37P
         HxDh4IAThuC+OJ6U7/y52wJ6PrC5hM4L/47gzkyW3l90Sjf8snmdSZ/9bJ+UanYR30yt
         6xabk7jOOmz/LSG8fqzqyjcbr3RCfr9vkYQLO5LfCzGTmxQKkYPM4JojPEXz3oAjzYpM
         hlRI3gM8+vDH6jPOhlLcR885JbQcCCyQq1tY48CLY7gGHr7QuDaDEXUiPa3G4efeOEWZ
         bkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MUZhkC8EIOiTCuZ8JVAShhb4+hIf902jnl0kjewNFpM=;
        b=EJxMqpRDKi+13gM5OTSjYABqUfkSGaJsKUqGoXfzy2xz/SBHC/r1L5laHCTT8Zig2N
         z9ymCoipvotT44dAa7BAovH/tBl7EhZMSJPhNTPHhjYYQyc+ZGKjqW9QO5cCEDaPGtrU
         kF7u7ZTFBH+ACiFTGzy3vQupcJv89UovAqJMDqtnHBW4P1JDgKuGCpr6t6BNa6+qA/Eb
         vwHXOJVAhh9rf7j6w52K4mHnwsuOxWdabCwImU5Btth3J0M8gWQVdH7T0kfCjVHRXHo7
         MOD4/nCslyKbA1XapmDCGgBqqqttg7/zJQjnPalsDZcyRKx0bixEwrR8bJVRDARjkCQV
         ZxtA==
X-Gm-Message-State: AOPr4FWtf+m8MI8PcFljP8jp+TWX7gvyCmRPwSJt3FjCII8fH7iTn/HWWXoa6+h80Bd6CQ==
X-Received: by 10.55.59.74 with SMTP id i71mr14142248qka.50.1462835575823;
        Mon, 09 May 2016 16:12:55 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id s1sm12774607qge.9.2016.05.09.16.12.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 16:12:54 -0700 (PDT)
In-Reply-To: <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294082>

On Mon, 2016-05-09 at 15:32 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Turner <dturner@twopensource.com> writes:
> > 
> > > On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
> > > > Hmmm, I seem to be getting
> > > > 
> > > >     $ cat t/trash*7900*/err
> > > >     fatal: Already running
> > > > 
> > > > after running t7900 and it fails at #5, after applying
> > > > "index-helper: optionally automatically run"
> 
> The symptom looks pretty similar to $gmane/293461 reported earlier.
> Here is how "t7900-index-helper.sh -i -v -x -d" ends.
> 
> 
> expecting success:
>         test_when_finished "git index-helper --kill" &&
>         rm -f .git/index-helper.sock &&
>         git status &&
>         test_path_is_missing .git/index-helper.sock &&
>         test_config indexhelper.autorun true &&
>         git status &&
>         test -S .git/index-helper.sock &&
>         git status 2>err &&
>         test -S .git/index-helper.sock &&
>         test_must_be_empty err &&
>         git index-helper --kill &&
>         test_config indexhelper.autorun false &&
>         git status &&
>         test_path_is_missing .git/index-helper.sock
> 
> + test_when_finished git index-helper --kill
> + test 0 = 0
> + test_cleanup={ git index-helper --kill
>                 } && (exit "$eval_ret"); eval_ret=$?; :
> + rm -f .git/index-helper.sock
> + git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
>         err
> 
> nothing added to commit but untracked files present (use "git add" to
> track)
> + test_path_is_missing .git/index-helper.sock
> + test -e .git/index-helper.sock
> + test_config indexhelper.autorun true
> + config_dir=
> + test indexhelper.autorun = -C
> + test_when_finished test_unconfig  'indexhelper.autorun'
> + test 0 = 0
> + test_cleanup={ test_unconfig  'indexhelper.autorun'
>                 } && (exit "$eval_ret"); eval_ret=$?; { git index
> -helper --kill
>                 } && (exit "$eval_ret"); eval_ret=$?; :
> + git config indexhelper.autorun true
> + git status
> error: last command exited with $?=141

I think that's a SIGPIPE on the first git status.  Weird, since I just
added sigpipe-avoidance code (in v8).  Does anyone have any idea why
the sigchain stuff isn't doing what I think it is?
