From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: remote-bzr status
Date: Tue, 05 Oct 2010 21:24:45 -0400
Message-ID: <4CABCFDD.4050902@gmail.com>
References: <4CA8F2F1.5090407@gmail.com> <20101004061104.GH24884@burratino> <4CAA16F8.4050705@gmail.com> <AANLkTin_ziCLfsHOeqwzCSaAGWwxwUPi=1=4Hdhz7uSk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 03:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Ika-0008CY-LP
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 03:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0JFBYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 21:24:51 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50300 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0JFBYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 21:24:50 -0400
Received: by qyk29 with SMTP id 29so2551306qyk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 18:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=g7KFwNxZolD0OzUkiejSJLhp6YI/RL36xyGo9whGPiA=;
        b=mLnvn1tlbouveWGnmUgEaICIweCX2urZW9EHB0YS3botQnycLY36Q2CZ0FNTt3ymbl
         UB31dMLq+n2xdmD6i6SeKmTkSTBxFlD9KI83TwbJ7gqn94yPOxGvfr8YxqQ8DbNdcaSJ
         vZLToKoGfDOQkDGJgnSMJRXXf1pyk3E/xU4gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=RGkd5cz7VrCYoKKidEF5M0AzI034mKGMzn8/tLc0iZ0UHy3X8/zpqWWsOGW3Mk6nNW
         +5ZZDGLKL9Xkxu6S9dLqWjgv+O+gLRc7QNXvHqSkxp8249IKZ+uq2dkQjkHfijCX3x7d
         EL57mMZK7tYjDpP2DQN09jljDOVXLTeLEgtZQ=
Received: by 10.220.200.10 with SMTP id eu10mr469462vcb.234.1286328289382;
        Tue, 05 Oct 2010 18:24:49 -0700 (PDT)
Received: from [192.168.2.202] (dsl-156-187.aei.ca [66.36.156.187])
        by mx.google.com with ESMTPS id w5sm18399vcr.6.2010.10.05.18.24.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 18:24:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Iceowl/1.0b1 Icedove/3.0.6
In-Reply-To: <AANLkTin_ziCLfsHOeqwzCSaAGWwxwUPi=1=4Hdhz7uSk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158261>

On 2010-10-04 14:07, Sverre Rabbelier wrote:
> On Mon, Oct 4, 2010 at 20:03, Gabriel Filion <lelutin@gmail.com> wrote:
>> My original plan was to try and make the helper work both ways, and then
>> to incorporate it into git.git to build patches on top of master (since
>> it's a new feature that should be working on the current master).
> 
> It would be great if you could make it work by adding a bzr directory
> to git_remote_helpers and a git-remote-bzr.py to the root directory!

I have written a test file that uses test-lib.sh. It is named
t5801-remote-bzr.sh. I don't know if this name is right so I can correct
it. I simply took the next sequential number after t5800-remote-helpers.sh.

It is included in the repo mentioned earlier but it won't work in there..

I've created a clone of git.git [1] in which there's a 'remote-bzr'
branch. I will be rebasing this branch on top of master and keeping it
up to date with the other repo's content. (so most operations will be
non-fastforward pushes)
The previous repository will contain the detailed history about work on
the remote helper, while the git clone will contain a simple commit for
the helper, plus relevant commits for integration in git.git.
The test file can be used inside the git clone.

[1]: http://github.com/lelutin/git

Maintaining two repositories will add a little more work but it will
make it easier for me to post a series on top of git for review and
possible inclusion later.
Also, it should make it easier for interested people to test out the
remote helper, and to run the test file.

So now, most of my work will be to try and fix bzr-fastimport. I tried
to get in contact with current maintainers of the plugin via Bazaar's
mailing list but was unsuccessful. I guess I should e-mail Jelmer
Vernooij directly since he merged some code in not so long ago.

-- 
Gabriel Filion
