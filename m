From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:22:26 -0700
Message-ID: <CAGZ79kaaES_k2PUtsDMBjHzjeg=1BPD0UQr3T18yb1n9qmYYLg@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 19:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulDs-0004H2-3I
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbbESRW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:22:27 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35843 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbESRW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:22:26 -0400
Received: by igbpi8 with SMTP id pi8so81488807igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=HQNUFxTGaTX0eXURcoNUlzKWsSSMPAcmcNp1QAguoIY=;
        b=ON/3rHiJk0uxqJq5omM1M9eXk2TyPyO55oGSUGMbGJiNcUHHS5cboR9ttv6c0w1wD6
         cub56TqMXGL6p/fP2KMtOYy4RPcU86BwghaetsPp2UX1iX0tqyedxVSIMGWIyql2U0hG
         t2dBXzN+70tCErlFUJD/JkU5r4fjvL5GFzQelCy1OEIBF4HHpjzmX2L3iNA8uBHYrlmK
         0c9SAl5mJ04bt5JWQYAChCuhh6pSHD12rLfxGJYr3opQeGC/vwja9qjqtZfnfOKJzfac
         eyvVqswpig29PnLN7xaUSEi6VZrnb26cmvKJzIZOI9Vm1jRlXSFeGRR30BNrlcM+VI/Q
         /QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=HQNUFxTGaTX0eXURcoNUlzKWsSSMPAcmcNp1QAguoIY=;
        b=bYHZ30M+LsYIASgsQaCaHrDxG9djrJFyLSAxYA9+I1+0+kRfzx4VRMFzx9ViTJ/8gd
         2UMySXjI35Kn9tBZI8BfFFCaRyx9v7/wZymJh6wiOSsnn/AZEcWzi54astATM0udNUuI
         YalOdYVFMtXcvxGUWtu/ZVVZM0TQ8/KnsNqAceRM3Y/EKVIxj4j/GjYAqZaiNWERCav7
         +fbQaWuB1/wi5k2pTlObP9SXPwxIUllIiGOcHG4OpMBRYHm+ts2ij8ohbnVBtciJrx6W
         hsxYOpP+r401AJlIpU9vnBFVG7+st9QplRbQVauwicMKdwGm19+UoGdpFramtBYZClXb
         saMw==
X-Gm-Message-State: ALoCoQk6bSnDNuGAyLgrcCd3I2L0ZvJiG/yrkI50E0vwSHJGiXv0/7e4dJBGmYNOsSE7nS6k5nlQ
X-Received: by 10.107.13.11 with SMTP id 11mr38418716ion.70.1432056146165;
 Tue, 19 May 2015 10:22:26 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 19 May 2015 10:22:26 -0700 (PDT)
In-Reply-To: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269375>

On Tue, May 19, 2015 at 10:20 AM, Stefan Beller <sbeller@google.com> wrote:
> Hi,
>
> so today I am running make test (no special flags I am aware of) on my
> ubuntu machine using
> git v2.4.1-168-g1ea28e1 and t5570-git-daemon.sh (not ok 8 - fetch
> notices corrupt idx) fails.
>
> Any hints?

It seems to be a flaky test. When I try the test with -d or -i it passes.
Using -v it still fails,

test_must_fail: command succeeded: git --bare fetch
git://127.0.0.1:5570/repo_bad2.git

>
> Thanks,
> Stefan
