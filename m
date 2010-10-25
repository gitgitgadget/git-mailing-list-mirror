From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 01/18] rev-parse: add --internal-cwd and
 --internal-git-dir for tests
Date: Mon, 25 Oct 2010 17:30:33 +0700
Message-ID: <AANLkTikm+JxyXk_bVXKaX_0aaSfqjrXU=m946Nm0=1vV@mail.gmail.com>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
 <1287922310-14678-2-git-send-email-pclouds@gmail.com> <20101024154005.GB31764@burratino>
 <AANLkTimfDVPFK7y-bkg-QYsTyHKdoxmvZxzzt36w95r5@mail.gmail.com> <m339ruk284.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 12:31:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKKV-00042r-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab0JYKaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:30:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49480 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0JYKaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 06:30:55 -0400
Received: by wwe15 with SMTP id 15so3317458wwe.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=hDuLkVeaPdOMb1hLdYkxfw/fuDtvO7xZZbNe0QwS0Yk=;
        b=Mpp1fXzSZ46yujiRcOBvVRTxnUicEVTGfdq8gdvSY3MfjGreOscBpThI1mkmO3nsAM
         dzKQBdt3GzGbjyBgNVCQkV8bfFo/eJNE4BqcK3mJ8cHz01ZLTs/ETtP2TQ74172kTxJk
         eJkL0yY3PFI2VTlCdZa+C90nsRsyN+iphtCP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CWwHr0ZO1Ihly/Qo/lmwFvBTGcMa9atkA0XrkpXn4IHkRof0+HG9wAsIPsofaR7PqC
         c6CdRdoVpONKAzGf/+BKBcQ+Kn2bFReyU5Q3CehBv0mX5gzqT5cbiwf+SWLUIbMJo5Au
         zxj8dTFEEAzsbKMRyMzXEJk6tKQrQcBx/1JZc=
Received: by 10.227.145.148 with SMTP id d20mr5187393wbv.2.1288002653910; Mon,
 25 Oct 2010 03:30:53 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Mon, 25 Oct 2010 03:30:33 -0700 (PDT)
In-Reply-To: <m339ruk284.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159939>

On Mon, Oct 25, 2010 at 5:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2010/10/24 Jonathan Nieder <jrnieder@gmail.com>:
>
>> > I think it might: just like the exec: lines provide context about what
>> > command is being traced, such trace: cwd: lines would make it clearer
>> > what paths that are being output might be referring to.
>>
>> Also prefix them all with "setup:", something like
>>
>> setup: git_dir: ../.git
>> setup: work_tree: /my/git/worktree
>> setup: cwd: /my/git/worktree
>> setup: prefix: sub/
>
> I guess that those paths would be c-quoted, if necessary (trailing
> space, embedded newline, quotes, etc.)?

For the sake of grep (because '\n' may break lines), yes.
-- 
Duy
