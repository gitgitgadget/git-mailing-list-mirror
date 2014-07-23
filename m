From: Stefan Beller <stefanbeller@gmail.com>
Subject: Unify subcommand structure; introduce double dashes for all subcommands?
Date: Wed, 23 Jul 2014 15:35:22 +0200
Message-ID: <53CFBA1A.8040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9whc-00076y-QP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 15:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaGWNfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 09:35:25 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:44077 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaGWNfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 09:35:24 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so1180362wgg.28
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=NkBgRQ/Ygm8d5Sk5GXtTJmWKOKfulgBRc4J/qNUFNKs=;
        b=aLGoUscuAtF5wzYx4Jes02N82BwBgq9IDBjAdHpDOteVg/Q4Jsk1qlCwV+98v2Ln5m
         87CCncYoS8/72E3P63MqM+wzdPvncI9HvBSMXJSC6DV69jFJaDFGscbJM4SpcV2vVzpC
         IBbi2lGAoGYeT5ONhwGi3xegf2s3/g/yJDM2TOQJ3AZTlBYvzRh9f3IUY7Z+2FZ7H0ry
         T25JiCD0WZFxnF15F6IBKtdsWU+ULiOQk0xvs2c4BoYiUYyDiVmv0Gerp1vsvFHR/wHh
         usrFZx99vLgzJ83E+RHHuWKnhn/jH0IL8SNHsay2Z6bdg6pzcg2iEUSZfqN734qwE39z
         NjYA==
X-Received: by 10.180.20.105 with SMTP id m9mr3516184wie.6.1406122522768;
        Wed, 23 Jul 2014 06:35:22 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id u10sm6305157wjz.43.2014.07.23.06.35.22
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 06:35:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254076>

In the user survey 2012 question 23 ("In your opinion, which areas in
Git need improvement?"),
the most crucial point identified was the user interface.
I wonder if there are any more recent surveys, showing if this has changed.
Now when we want to improve the user interface, we're likely talking
about the porcelain
commands only, as that's what most users perceive as the commandline
user interface.

A git command is generally setup as:
	git <command> [<subcommand>] [<options>] ...

The subcommands vary wildly by the nature of the command. However all
subcommands
could at least follow one style. The commands bundle, notes, stash and
submodule
have subcommands without two leading dashes (i.e. git stash list) as
opposed to all
other commands (i.e. git tag --list).

So my proposal is to unify the structure of the subcommands to either
have always
leading dashes or never. This would need a longterm thinking of course
(e.g. introduce new options with(out) dashes, but support existing
commands until git 3.0
or such, then drop them.)

Was there a discussion about this topic already?
I'd like to read on these discussions, if any.

I could think about the following points being interesting
 * user interface (what is more appealing to a user?)
 * ease of transition (Is it really worth it? How long does it take to
pay off?)
 * ease of implementation (Could we reuse the option parser already in
   place for the double-dashed subcommands, i.e. have less LoC)
 * error-proneness of the transition

Thanks,
Stefan
